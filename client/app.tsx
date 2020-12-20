import React from 'react'
import { render } from 'react-dom'

import Stories from './components/stories'
import CarState from './components/car_state'
import InfoBox from './components/info_box'
import Map from './components/map'

render(
  <>
    <Stories />
    <CarState>
      <InfoBox />
      <Map />
    </CarState>
  </>,

  document.getElementById('root')
)
