import os

from objectstore.objectstore import ObjectStore
from raket import raket_setup, raket

connected_obj_store = ObjectStore(raket_setup.OS_CONTAINER)
raket_setup.SOURCE_PATH_INTERNAL = os.path.dirname(
    os.path.realpath(__file__)) + '/fixtures'


def setUp():
    raket_setup.OS_CONTAINER = 'Test'
    connected_obj_store.create_container('Test')


def checkwrittenfiles():
    stored_objects = connected_obj_store.get_store_object('')
    strobjs = [o.decode('utf-8') for o in stored_objects.split(b'\n') if
               not o == b'']
    assert (len(strobjs) == 4)
    incorrect_objects = [s for s in strobjs if s not in
                         ("test1.txt",
                          "Underlying/test3.txt",
                          "Underlying/test4.txt",
                          "Underlying/Next_level/test5.txt")]
    assert (len(incorrect_objects) == 0)


def test_put_files():
    """
    Execute twice, first time is add, second time is update
    :return:
    """
    setUp()
    raket.process_raket()
    checkwrittenfiles()
    raket.process_raket()
    checkwrittenfiles()
    # tearDown()


def tearDown():
    connected_obj_store.delete_container('Test')
