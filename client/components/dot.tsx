import { useEffect, useState } from 'react'

import { Map, Marker } from 'mapbox-gl'

export default function Dot({ map, latitude, longitude }: { map: Map; latitude: number; longitude: number }) {
  const [icon, setIcon] = useState<Marker>()
  const [pulse, setPulse] = useState<Marker>()

  useEffect(() => {
    if (map && latitude && longitude && !icon && !pulse) {
      const iconDiv = document.createElement('div')
      iconDiv.className = 'location-icon'

      const pulseDiv = document.createElement('div')
      pulseDiv.className = 'location-pulse'
      pulseDiv.innerHTML = '<div class="pulse"></div>'

      const newIcon = new Marker(iconDiv)
      const newPulse = new Marker(pulseDiv)

      newIcon.setLngLat([longitude, latitude]).addTo(map)
      newPulse.setLngLat([longitude, latitude]).addTo(map)

      setIcon(newIcon)
      setPulse(newPulse)
    }

    if (icon && pulse && latitude && longitude) {
      icon.setLngLat([longitude, latitude])
      pulse.setLngLat([longitude, latitude])
    }
  })

  return null
}
