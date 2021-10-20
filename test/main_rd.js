// Geldigheidsgebied van het tiling schema in RD-coördinaten:
var projectionExtent = [-285401.92, 22598.08, 595401.9199999999, 903401.9199999999];
var projection = new ol.proj.Projection({ code: 'EPSG:28992', units: 'm', extent: projectionExtent });
// Resoluties (pixels per meter) van de zoomniveaus:
var resolutions = [3440.640, 1720.320, 860.160, 430.080, 215.040, 107.520, 53.760, 26.880, 13.440, 6.720, 3.360, 1.680, 0.840, 0.420, 0.210, 0.105];
var size = ol.extent.getWidth(projectionExtent) / 256;
// Er zijn 16 (0 tot 15) zoomniveaus beschikbaar van de WMTS-service voor de luchtfoto:
var matrixIds = new Array(16);
for (var z = 0; z < 16; ++z) {
    matrixIds[z] = z;
}

var map = new ol.Map({
    layers: [
        new ol.layer.Tile({
            opacity: 0.7,
            source: new ol.source.WMTS({
                attributions: 'Kaartgegevens: &copy; <a href="https://www.kadaster.nl">Kadaster</a>',
                // url: 'https://geodata.nationaalgeoregister.nl/luchtfoto/rgb/wmts?',
                url: 'file:///mnt/tiles/lufo2021_rd_cache_EPSG28992/{TileMatrix}/{TileCol}/{TileRow}.jpeg',
                // layer: 'Actueel_ortho25',
                matrixSet: 'EPSG:28992',
                format: 'image/jpeg',
                projection: projection,
                requestEncoding: "REST",
                tileGrid: new ol.tilegrid.WMTS({
                    origin: ol.extent.getTopLeft(projectionExtent),
                    resolutions: resolutions,
                    matrixIds: matrixIds
                }),
                style: 'default',
                wrapX: false
            })
        })
    ],
    target: 'map-canvas',
    controls: ol.control.defaults({
        attributionOptions: {
            collapsible: false
        }
    }),
    view: new ol.View({
        minZoom: 0,
        maxZoom: 16,
        projection: projection,
        center: [150000, 450000],
        zoom: 3
    })
});