import React from 'react'
import styled from '@emotion/styled'

import { Box } from './styles'

const TooltipBox = styled(Box)`
  position: absolute;
  z-index: 1;
  top: 70px;
  right: 20px;
  max-width: 250px;
  padding: 20px;

  @media (max-width: 991.98px) {
    top: 120px;
    right: 10px;
  }
`

const TooltipTitle = styled.h3`
  margin: 0;
  font-size: 22px;

  @media (max-width: 991.98px) {
    font-size: 32px;
  }
`

const TooltipText = styled.p`
  margin: 0;
  margin-top: 5px;
  font-size: 15px;

  @media (max-width: 991.98px) {
    font-size: 26px;
  }
`

export default function Tooltip() {
  return (
    <TooltipBox>
      <TooltipTitle>Now in 3D!</TooltipTitle>
      <TooltipText>
        Click on the button above to toggle between the trip overview and a 3D overhead view of us as we drive.
      </TooltipText>
    </TooltipBox>
  )
}
