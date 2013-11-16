//= require jquery
//= require jquery_ujs
//= require_tree .

var map = L.mapbox.map('map', 'timdorr.g9a9eko1');
var carPathLayer = null;


$.getJSON("/telemetry", function(response){
  var geoJSON = { type: 'LineString', coordinates: [] };
  var data = response.data;
  var length = data.length;

  for (var i = 0; i < length; i++) {
    geoJSON.coordinates.push([data[i].lng, data[i].lat].slice());
  }

  console.log(geoJSON);
  carPathLayer = L.geoJson(geoJSON).addTo(map);
});