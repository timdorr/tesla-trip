import { Component } from 'react'

import wrapGeoJSON from '../utils/wrapGeoJSON'

export default class Path extends Component {
  async componentDidUpdate() {
    if (this.props.map) {
      const telemetry = await (await fetch('/telemetry.json')).json()

      const carGeoJSON = { type: 'LineString', coordinates: [] }
      telemetry.forEach(point => {
        carGeoJSON.coordinates.push([point.lng, point.lat])
      })

      this.props.map.addSource('carPath', wrapGeoJSON(carGeoJSON))
      this.props.map.addLayer({
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
  }

  render() {
    return null
  }
}
