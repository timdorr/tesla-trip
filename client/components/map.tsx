import React, { useCallback, useEffect, useState } from 'react'
import styled from '@emotion/styled'

import 'mapbox-gl/dist/mapbox-gl.css'
import mapboxgl, { Map as MapBox, Marker, LngLatBounds, LngLatLike } from 'mapbox-gl'

mapboxgl.accessToken = process.env.MAPBOX_TOKEN || ''

import Toggle from './toggle'
import Tooltip from './tooltip'
import Dot from './dot'
import Path from './path'

import { routeGeoJSON, stopsGeoJSON } from '../route'
import wrapGeoJSON from '../utils/wrapGeoJSON'
import { useCarState } from './car_state'

const bounds = routeGeoJSON.coordinates.reduce(
  (bounds, coord) => bounds.extend(coord as LngLatLike),
  new LngLatBounds(routeGeoJSON.coordinates[0] as LngLatLike, routeGeoJSON.coordinates[0] as LngLatLike)
)

const MapContainer = styled.div`
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  width: 100%;
  height: 100%;

  @media (-webkit-device-pixel-ratio: 3.5) and (orientation: portrait),
    (-webkit-device-pixel-ratio: 4) and (orientation: portrait) {
    height: 1100px;
  }
`

export default function Map() {
  const { telemetry, state } = useCarState()

  const [map, setMap] = useState<MapBox>()
  const [overview, setOverview] = useState(true)
  const [flying, setFlying] = useState(false)

  const mapContainer = useCallback((node: HTMLDivElement) => {
    if (!node) return

    const map = new MapBox({
      container: node,
      style: 'mapbox://styles/mapbox/streets-v11',
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
        if (!marker.properties) return

        const markerDiv = document.createElement('div')
        markerDiv.className = 'marker marker-' + marker.properties['marker-symbol']

        new Marker(markerDiv).setLngLat(marker.geometry.coordinates as LngLatLike).addTo(map)
      })

      setMap(map)
    })

    map.on('pitchstart', () => {
      setFlying(true)
    })

    map.on('pitchend', () => {
      setFlying(false)
    })

    return () => {
      map.remove()
    }
  }, [])

  useEffect(() => {
    if (overview) {
      map?.fitBounds(bounds, {
        padding: 100,
        bearing: 0,
        pitch: 0
      })
    } else {
      map?.flyTo({
        bearing: telemetry.heading || state.heading,
        center: [telemetry.longitude || state.longitude, telemetry.latitude || state.latitude],
        zoom: 13,
        pitch: 40
      })
    }
  }, [map, overview])

  const toggleOverview = (event: React.MouseEvent) => {
    event.preventDefault()

    localStorage.toggled = true
    setOverview(!overview)
  }

  const getLatestLocation = () => {
    if (!telemetry && state) {
      return {
        latitude: state.latitude,
        longitude: state.longitude
      }
    } else if (telemetry) {
      return {
        latitude: telemetry.latitude,
        longitude: telemetry.longitude
      }
    } else {
      return { latitude: 0, longitude: 0 }
    }
  }

  return (
    <div>
      {map && (
        <>
          {telemetry && (
            <>
              <Toggle overview={overview} toggleOverview={toggleOverview} />
              {!localStorage.toggled && <Tooltip />}
            </>
          )}
          <Dot map={map} {...getLatestLocation()} />
          <Path map={map} />
        </>
      )}
      <MapContainer ref={mapContainer} />
    </div>
  )
}
