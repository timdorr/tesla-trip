//= require jquery
//= require jquery_ujs
//= require_tree .

var map = L.mapbox.map('map', 'timdorr.g9a9eko1', {zoomControl: false});

map.dragging.disable();
map.touchZoom.disable();
map.doubleClickZoom.disable();
map.scrollWheelZoom.disable();
if (map.tap) map.tap.disable();

var carPathLayer = null;

function getTelemetry() {
  $.ajax({
    dataType: "json",
    url: "/telemetry"
  }).done(function(response){
      var geoJSON = { type: 'LineString', coordinates: [] };
      var data = response.data;
      var length = data.length;

      for (var i = 0; i < length; i++) {
        geoJSON.coordinates.push([data[i].lng, data[i].lat].slice());
      }

      carPathLayer = L.geoJson(geoJSON).addTo(map);
    });
}

setTimeout(getTelemetry, 100);