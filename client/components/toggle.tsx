import React, { MouseEventHandler } from 'react'
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

export default function Toggle({ overview, toggleOverview }: { overview: boolean; toggleOverview: MouseEventHandler }) {
  return (
    <Switch onClick={toggleOverview}>
      <img src={overview ? imageOverview : imageHeadsup} />
    </Switch>
  )
}
