import datetime
import multiprocessing as mp
import os
from mimetypes import guess_type
from queue import Empty

from objectstore.objectstore import ObjectStore
from raket import raket_setup


def logtimestamp():
    return datetime.datetime.now().strftime('%d-%m-%Y %H:%M:%S')


def upload(path_to_tile, nr_of_tiles, filequeue, countqueue):
    print('{} {} Tiles are to be written to container {} from {}'.
          format(logtimestamp(), nr_of_tiles,
                 raket_setup.OBJECTSTORE_CONTAINER, path_to_tile))
    try:
        int_nr_of_tiles = int(nr_of_tiles)
    except ValueError:
        int_nr_of_tiles = -1

    counter = 0
    for root, dirs, files in os.walk(path_to_tile):

        for file in files:
            counter += 1
            filequeue.put_nowait((root, file, path_to_tile))
        if counter == int_nr_of_tiles:
            break

    countqueue.put_nowait(counter)
    print('%s %s files written to queue' % (logtimestamp(), counter))
    filequeue.close()
    filequeue.join_thread()

    return counter


def calc_per_sec(starttime, counter):
    elapse_seconds = (datetime.datetime.now() - starttime).seconds
    return round(counter / elapse_seconds, 1)


def progress_bar(countqueue):
    """
    Measures the progress of the upload and reports
    :param countqueue:
    :return:
    """
    timeout = 2
    counter = 0
    totalcount = -1
    starttime = datetime.datetime.now()
    nexttime = starttime + \
               datetime.timedelta(seconds=int(raket_setup.PROGRESS))
    while True:
        try:
            parm = countqueue.get(timeout=timeout)
        except Empty:
            break
        if isinstance(parm, int) and parm > 1:
            totalcount = parm
        counter += 1
        if totalcount > 0 and datetime.datetime.now() > nexttime:
            pct = round((counter * 100) / totalcount, 0)
            print('{} {}%, {} verwerkt, '
                  '{} per second'.format(logtimestamp(), pct, counter,
                                         calc_per_sec(starttime, counter)))
            nexttime = datetime.datetime.now() + datetime.timedelta(
                seconds=int(raket_setup.PROGRESS))


def worker_actual_upload(filequeue, countqueue, container):
    """
    Worker thread die de feitelijke upload uitvoert
    Let op de timeout, die staat op 1 seconde. Dat wil zeggen dat het
    proces zichzelf afsluit wanneer die niet binnen 1 seconde een
    file om te uploaden heeft gelezen van de queue.
    :param filequeue:
    :param countqueue: counter queue
    :param container: to work from
    :return:
    """
    connected_obj_store = ObjectStore(container)
    timeout = 2
    while True:
        try:
            parm = filequeue.get(timeout=timeout)
        except Empty:
            break
        root, file, path_to_tile = parm
        relpath = os.path.relpath(root,
                                  os.path.commonpath((root, path_to_tile)))
        local_filename = root + '/' + file
        if relpath == '.':
            objectstore_filename = file
        else:
            objectstore_filename = relpath + '/' + file
        with open(local_filename, 'rb') as f:
            mime = guess_type(local_filename)
            if not mime == (None, None):
                filecontent = f.read()
                connected_obj_store.put_to_objectstore(objectstore_filename,
                                                       filecontent, mime[0])
                countqueue.put_nowait(True)


def process_raket(nr_of_tiles='all', nr_of_processes=2):
    # noinspection PyUnresolvedReferences
    filequeue = mp.Queue()
    countqueue = mp.Queue()
    starttime = datetime.datetime.now()
    processes = start_workers(nr_of_processes, filequeue, countqueue)
    counter = upload(raket_setup.SOURCE_PATH_INTERNAL + '/' + raket_setup.OBJECTSTORE_CONTAINER, nr_of_tiles,
                     filequeue,
                     countqueue)

    for p in processes:
        p.join()
    print('{} files uploaded, start {}, {} tiles per second'.
          format(logtimestamp(), starttime, calc_per_sec(starttime, counter)))


def start_workers(nr_of_processes, filequeue, countqueue):
    processes = []
    for i in range(nr_of_processes):
        # noinspection PyUnresolvedReferences
        processes.append(mp.Process(target=worker_actual_upload,
                                    args=(filequeue, countqueue,
                                          raket_setup.
                                          OBJECTSTORE_CONTAINER)))
        processes[-1].start()
    processes.append(mp.Process(target=progress_bar, args=(countqueue,)))
    processes[-1].start()
    return processes
