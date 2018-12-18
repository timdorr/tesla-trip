import React from 'react'
import { render } from 'react-dom'

import CarState from './components/car_state'
import TeslaMap from './components/map'

render(
  <CarState>{state => <TeslaMap {...state} />}</CarState>,
  document.getElementById('root')
)
