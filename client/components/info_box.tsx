import React from 'react'
import styled from '@emotion/styled'

import { useCarState } from './car_state'

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

function toFahrenheit(celsius: number) {
  return Math.round(celsius * (9 / 5) + 32)
}

export default function InfoBox() {
  const { state, telemetry } = useCarState()

  const {
    charging_state,
    shift_state: stateShift,
    speed: stateSpeed,
    charge_rate,
    time_to_full_charge,
    usable_battery_level: stateBattery,
    battery_range: stateRange,
    outside_temp,
    inside_temp
  } = state

  const {
    shift_state: telemetryShift,
    speed: telemetrySpeed,
    range: telemetryRange,
    battery_level: telemetryBattery
  } = telemetry

  const shift_state = telemetryShift !== undefined ? telemetryShift : stateShift
  const speed = telemetrySpeed || stateSpeed
  const battery_level = telemetryBattery || stateBattery
  const range = telemetryRange || stateRange

  return (
    <InfoContainer>
      {charging_state == 'Charging' ? (
        <>
          <InfoStatus>Charging</InfoStatus>

          <InfoTitle>Charge Rate: </InfoTitle>
          <InfoData>{Math.round(charge_rate)} mph</InfoData>

          <InfoTitle>Time To Full: </InfoTitle>
          <InfoData>{time_to_full_charge} hours</InfoData>
        </>
      ) : shift_state == 'P' || shift_state == null || shift_state == '' ? (
        <InfoStatus>Parked</InfoStatus>
      ) : (
        <>
          <InfoStatus>Driving</InfoStatus>

          <InfoTitle>Speed: </InfoTitle>
          <InfoData>{speed} mph</InfoData>
        </>
      )}

      <InfoTitle>Battery Level: </InfoTitle>
      <InfoData>{Math.round(battery_level)}%</InfoData>

      <InfoTitle>Range: </InfoTitle>
      <InfoData>{Math.round(range)} mi</InfoData>

      {outside_temp && (
        <>
          <InfoTitle>Outside Temp: </InfoTitle>
          <InfoData>{toFahrenheit(outside_temp)}º</InfoData>
        </>
      )}

      {inside_temp && (
        <>
          <InfoTitle>Inside Temp: </InfoTitle>
          <InfoData>{toFahrenheit(inside_temp)}º</InfoData>
        </>
      )}
    </InfoContainer>
  )
}
