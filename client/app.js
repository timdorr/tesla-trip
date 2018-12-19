import React from 'react'
import { render } from 'react-dom'

import Stories from './components/stories'
import CarState from './components/car_state'
import TeslaMap from './components/map'

render(
  <React.Fragment>
    <Stories />
    <CarState>{state => <TeslaMap {...state} />}</CarState>
  </React.Fragment>,
  document.getElementById('root')
)
