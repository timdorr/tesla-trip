import React, { Component } from 'react'
import styled from 'styled-components'

import imageOverview from '../images/toggle.overview.png'
import imageHeadsup from '../images/toggle.headsup.png'

const Switch = styled.div`
  position: absolute;
  z-index: 100;
  top: 20px;
  right: 20px;
  cursor: pointer;
`

const Toggle = ({ overview, toggleOverview }) => (
  <Switch onClick={toggleOverview}>
    <img src={overview ? imageOverview : imageHeadsup} width="49" height="49" />
  </Switch>
)

export default Toggle
