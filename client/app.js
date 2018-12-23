import React from 'react'
import { render } from 'react-dom'

import Stories from './components/stories'
import CarState from './components/car_state'
import InfoBox from './components/info_box'
import TeslaMap from './components/map'

render(
  <React.Fragment>
    <Stories />
    <CarState>
      {state => (
        <React.Fragment>
          <InfoBox state={state.state} telemetry={state.telemetry || {}} />
          <TeslaMap {...state} />
        </React.Fragment>
      )}
    </CarState>
  </React.Fragment>,
  document.getElementById('root')
)
