import React from 'react'
import styled from 'styled-components'

import imageOverview from '../images/toggle.overview.png'
import imageHeadsup from '../images/toggle.headsup.png'

const Switch = styled.div`
  position: absolute;
  z-index: 100;
  top: 20px;
  right: 20px;
  cursor: pointer;

  img {
    width: 49px;
    height: 49px;
  }

  @media (max-width: 991.98px) {
    top: 10px;
    right: 10px;

    img {
      width: 98px;
      height: 98px;
    }
  }
`

const Toggle = ({ overview, toggleOverview }) => (
  <Switch onClick={toggleOverview}>
    <img src={overview ? imageOverview : imageHeadsup} />
  </Switch>
)

export default Toggle
