import { GeoJSONSourceRaw } from 'mapbox-gl'

export default function wrapGeoJSON(geoJSON: GeoJSON.Geometry): GeoJSONSourceRaw {
  return {
    type: 'geojson',
    data: {
      type: 'FeatureCollection',
      features: [{ type: 'Feature', geometry: geoJSON, properties: null }]
    }
  }
}
