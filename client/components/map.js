import React, { Component } from 'react'
import styled from 'styled-components'

import 'mapbox-gl/dist/mapbox-gl.css'
import mapboxgl, { Map as MapBox, Marker, LngLatBounds } from 'mapbox-gl'

mapboxgl.accessToken = process.env.MAPBOX_TOKEN

import Toggle from './toggle'
import Dot from './dot'
import Path from './path'

import { routeGeoJSON, stopsGeoJSON } from '../route'
import wrapGeoJSON from '../utils/wrapGeoJSON'

const bounds = routeGeoJSON.coordinates.reduce(
  (bounds, coord) => bounds.extend(coord),
  new LngLatBounds(routeGeoJSON.coordinates[0], routeGeoJSON.coordinates[0])
)

const MapContainer = styled.div`
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  width: 100%;
  height: 100%;

  @media screen and (device-width: 412px) and (device-height: 823px) and (-webkit-device-pixel-ratio: 3.5) and (orientation: portrait) {
    height: 1100px;
  }
`

export default class Map extends Component {
  state = { overview: true, map: null, flying: false }

  componentDidMount() {
    const map = new MapBox({
      container: this.mapContainer,
      style: 'mapbox://styles/timdorr/cjp7rb5ra36fj2sn2df2dctaj',
      center: [-77, 38],
      zoom: 5
    })

    map.on('load', () => {
      map.addSource('routePath', wrapGeoJSON(routeGeoJSON))
      map.addLayer({
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

        new Marker(markerDiv).setLngLat(marker.geometry.coordinates).addTo(map)
      })

      this.setState({ map }, this.handleToggle)
    })

    map.on('pitchstart', () => {
      this.setState({ flying: true })
    })

    map.on('pitchend', () => {
      this.setState({ flying: false })
    })
  }

  componentWillUnmount() {
    this.state.map.remove()
  }

  componentDidUpdate() {
    if (
      this.state.map &&
      !this.state.flying &&
      !this.state.overview &&
      this.props.telemetry
    ) {
      const { heading, latitude, longitude } = this.props.telemetry

      this.state.map.easeTo({
        bearing: heading,
        center: [longitude, latitude]
      })
    }
  }

  handleToggle = () => {
    if (this.state.overview) {
      this.state.map.fitBounds(bounds, {
        padding: 100,
        bearing: 0,
        pitch: 0
      })
    } else {
      if (this.props.telemetry) {
        const { heading, latitude, longitude } = this.props.telemetry

        this.state.map.flyTo({
          bearing: heading,
          center: [longitude, latitude],
          zoom: 13,
          pitch: 40
        })
      }
    }
  }

  toggleOverview = event => {
    event.preventDefault()
    const { overview } = this.state

    this.setState({ overview: !overview }, this.handleToggle)
  }

  getLatestLocation = () => {
    if (!this.props.telemetry && this.props.state) {
      return {
        latitude: this.props.state.latitude,
        longitude: this.props.state.longitude
      }
    } else if (this.props.telemetry) {
      return {
        latitude: this.props.telemetry.latitude,
        longitude: this.props.telemetry.longitude
      }
    } else {
      return {}
    }
  }

  render() {
    return (
      <div>
        {this.props.telemetry && (
          <Toggle
            overview={this.state.overview}
            toggleOverview={this.toggleOverview}
          />
        )}
        <Dot map={this.state.map} {...this.getLatestLocation()} />
        <Path map={this.state.map} />
        <MapContainer ref={el => (this.mapContainer = el)} />
      </div>
    )
  }
}
