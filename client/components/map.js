import React, { Component } from 'react'
import styled from 'styled-components'

import 'mapbox-gl/dist/mapbox-gl.css'
import mapboxgl, { Map as MapBox, Marker, LngLatBounds } from 'mapbox-gl'

mapboxgl.accessToken = process.env.MAPBOX_TOKEN

import { routeGeoJSON, stopsGeoJSON } from '../route'
import wrapGeoJSON from '../utils/wrapGeoJSON'

const MapContainer = styled.div`
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  width: 100%;
`

export default class Map extends Component {
  componentDidMount() {
    this.map = new MapBox({
      container: this.mapContainer,
      style: 'mapbox://styles/timdorr/cjp7rb5ra36fj2sn2df2dctaj',
      center: [-77, 38],
      zoom: 5,
      bearing: 0,
      pitch: 45
    })

    this.map.on('load', () => {
      this.map.addSource('routePath', wrapGeoJSON(routeGeoJSON))
      this.map.addLayer({
        id: 'routePath',
        type: 'line',
        source: 'routePath',
        layout: {
          'line-join': 'round',
          'line-cap': 'round'
        },
        paint: {
          'line-opacity': 0.75,
          'line-color': '#6699ff',
          'line-width': 6
        }
      })

      stopsGeoJSON.features.forEach(marker => {
        const markerDiv = document.createElement('div')
        markerDiv.className =
          'marker marker-' + marker.properties['marker-symbol']

        new Marker(markerDiv)
          .setLngLat(marker.geometry.coordinates)
          .addTo(this.map)
      })

      const bounds = routeGeoJSON.coordinates.reduce(
        (bounds, coord) => bounds.extend(coord),
        new LngLatBounds(
          routeGeoJSON.coordinates[0],
          routeGeoJSON.coordinates[0]
        )
      )

      this.map.fitBounds(bounds, {
        padding: 100
      })
    })
  }

  componentWillUnmount() {
    this.map.remove()
  }

  render() {
    return <MapContainer ref={el => (this.mapContainer = el)} />
  }
}
