import { useEffect } from 'react'

import { Map } from 'mapbox-gl'

import wrapGeoJSON from '../utils/wrapGeoJSON'

export default function Path({ map }: { map: Map }) {
  const fetchPath = async () => {
    const telemetry = await (await fetch('/telemetry.json')).json()

    const carGeoJSON: GeoJSON.LineString = { type: 'LineString', coordinates: [] }
    telemetry.forEach((point: { lat: number; lng: number }) => {
      carGeoJSON.coordinates.push([point.lng, point.lat])
    })

    map.addSource('carPath', wrapGeoJSON(carGeoJSON))
    map.addLayer({
      id: 'carPath',
      type: 'line',
      source: 'carPath',
      layout: {
        'line-join': 'round',
        'line-cap': 'round'
      },
      paint: {
        'line-dasharray': [4, 3],
        'line-color': '#dd6600',
        'line-width': 3
      }
    })
  }

  useEffect(() => {
    fetchPath()
  }, [map])

  return null
}
