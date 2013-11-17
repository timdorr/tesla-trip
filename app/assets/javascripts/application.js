//= require jquery
//= require jquery_ujs
//= require_tree .

var map = L.mapbox.map('map', 'timdorr.g9a9eko1', {zoomControl: false});

map.dragging.disable();
map.touchZoom.disable();
map.doubleClickZoom.disable();
map.scrollWheelZoom.disable();
if (map.tap) map.tap.disable();

var carData = [];
var carPathLayer = null;
var carGeoJSON = { type: 'LineString', coordinates: [] };

function getTelemetry() {
  $.ajax({
    dataType: "json",
    url: "/telemetry"
  }).done(function(response){
      carData = response.data;
      var length = carData.length;

      for (var i = 0; i < length; i++) {
        carGeoJSON.coordinates.push([carData[i].lng, carData[i].lat]);
      }

      carPathLayer = L.geoJson(carGeoJSON, { style: { color:"#0f9727", weight: 3, dashArray: "5,10" } }).addTo(map);
    });
}

setTimeout(getTelemetry, 100);