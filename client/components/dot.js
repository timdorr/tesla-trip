import { Component } from 'react'
import { Marker } from 'mapbox-gl'

export default class Dot extends Component {
  state = { icon: null, pulse: null }

  componentDidUpdate() {
    const { map, latitude, longitude } = this.props
    let { icon, pulse } = this.state

    if (map && latitude && longitude && !icon && !pulse) {
      const iconDiv = document.createElement('div')
      iconDiv.className = 'location-icon'

      const pulseDiv = document.createElement('div')
      pulseDiv.className = 'location-pulse'
      pulseDiv.innerHTML = '<div class="pulse"></div>'

      icon = new Marker(iconDiv)
      pulse = new Marker(pulseDiv)

      icon.setLngLat([longitude, latitude]).addTo(this.props.map)
      pulse.setLngLat([longitude, latitude]).addTo(this.props.map)

      this.setState({ icon, pulse })
    }

    if (icon && pulse && latitude && longitude) {
      icon.setLngLat([longitude, latitude])
      pulse.setLngLat([longitude, latitude])
    }
  }

  render() {
    return null
  }
}
