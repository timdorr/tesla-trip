import React from 'react'
import styled from 'styled-components'

import { Box } from './styles'

const InfoContainer = styled(Box)`
  display: grid;
  grid-template-rows: 35px;
  grid-template-areas: 'status status';
  grid-gap: 10px 20px;
  position: absolute;
  z-index: 3;
  right: 20px;
  bottom: 20px;
  padding: 15px;

  @media (max-width: 991.98px) {
    transform: scale(1);
  }
`

const InfoStatus = styled.div`
  grid-area: status;
  text-align: center;
  color: #666;
  font-weight: 600;
  font-size: 18px;
  letter-spacing: 1px;
  text-transform: uppercase;
`

const InfoTitle = styled.div`
  color: #666;
  font-size: 14px;
`
const InfoData = styled.div``

function toFahrenheit(celsius) {
  return Math.round(celsius * (9 / 5) + 32)
}

export default function InfoBox({
  state: {
    charging_state,
    shift_state,
    speed,
    charge_rate,
    time_to_full_charge,
    usable_battery_level,
    battery_range,
    outside_temp,
    inside_temp
  }
}) {
  return (
    <InfoContainer>
      {charging_state == 'Charging' ? (
        <React.Fragment>
          <InfoStatus>Charging</InfoStatus>

          <InfoTitle>Charge Rate: </InfoTitle>
          <InfoData>{Math.round(charge_rate)} mph</InfoData>

          <InfoTitle>Time To Full: </InfoTitle>
          <InfoData>{time_to_full_charge} hours</InfoData>
        </React.Fragment>
      ) : shift_state == 'P' || shift_state == null ? (
        <InfoStatus>Parked</InfoStatus>
      ) : (
        <React.Fragment>
          <InfoStatus>Driving</InfoStatus>

          <InfoTitle>Speed: </InfoTitle>
          <InfoData>{speed} mph</InfoData>
        </React.Fragment>
      )}

      <InfoTitle>Battery Level: </InfoTitle>
      <InfoData>{Math.round(usable_battery_level)}%</InfoData>

      <InfoTitle>Range: </InfoTitle>
      <InfoData>{Math.round(battery_range)} mi</InfoData>

      {outside_temp && (
        <React.Fragment>
          <InfoTitle>Outside Temp: </InfoTitle>
          <InfoData>{toFahrenheit(outside_temp)}º</InfoData>
        </React.Fragment>
      )}

      {inside_temp && (
        <React.Fragment>
          <InfoTitle>Inside Temp: </InfoTitle>
          <InfoData>{toFahrenheit(inside_temp)}º</InfoData>
        </React.Fragment>
      )}
    </InfoContainer>
  )
}
