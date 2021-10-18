var map = new ol.Map({
    layers: [
        new ol.layer.Tile({
          source: new ol.source.XYZ({
            attributions: 'Kaartgegevens: &copy; <a href="https://data.amsterdam.nl">Amsterdam</a>',
            url: 'file:///mnt/tiles/lufo_wm_cache_EPSG3857/{z}/{x}/{y}.jpeg'
            // url: 'https://service.pdok.nl/hwh/luchtfotorgb/wmts/v1_0/Actueel_ortho25/EPSG:3857/{z}/{x}/{y}.jpeg'
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
        minZoom: 6,
        maxZoom: 21,
// These coordinates (degrees) are in WGS84!    
        center: new ol.proj.fromLonLat([4.8339212,52.3546449]),
// These coordinates (meters) are in Web Mercator too!                                      
//        center: [631711.827985, 6856275.890632],
        zoom: 12
    })
});
