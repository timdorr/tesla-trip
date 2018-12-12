export default function wrapGeoJSON(geoJSON) {
  return {
    type: 'geojson',
    data: {
      type: 'FeatureCollection',
      features: [{ type: 'Feature', geometry: geoJSON }]
    }
  }
}
