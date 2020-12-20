import React from 'react'
import styled from 'styled-components'

import { Box } from './styles'

import instagramLogo from '../images/instagram.png'
import tim from '../images/story.tim.jpg'
import becca from '../images/story.becca.jpg'

const StoryBox = styled(Box)`
  display: grid;
  grid-template-rows: 35px;
  grid-template-areas: 'title title';
  grid-gap: 0 20px;
  justify-items: center;
  position: absolute;
  z-index: 1;
  top: 20px;
  left: 20px;
  padding: 20px;

  @media (max-width: 991.98px) {
    grid-template-rows: 40px;
    top: 10px;
    left: 10px;
  }
`

const StoryTitle = styled.h3`
  grid-area: title;
  height: 20px;
  margin: 0;
  padding-left: 25px;
  font-weight: 600;
  font-size: 14px;
  line-height: 18px;
  background: transparent url('${instagramLogo}') no-repeat left top / 20px;

  @media (max-width: 991.98px) {
    font-size: 24px;
  }
`

const StoryLink = styled.a<{ avatar: string }>`
  display: block;
  height: 52px;
  width: 52px;
  background: url('') no-repeat top left / 52px;
  border: 2px solid white;
  border-radius: 50%;
  text-decoration: none;

  :after {
    content: '\00a0';
    position: sticky;
    display: block;
    margin-top: -4px;
    margin-left: -4px;
    z-index: -2;
    width: 60px;
    height: 60px;
    background: linear-gradient(to bottom, #d82b7e, #f57939);
    border-radius: 50%;
  }

  @media (max-width: 991.98px) {
    height: 90px;
    width: 90px;
    background-size: 90px;
    border: 3px solid white;

    :after {
      margin-top: -6px;
      margin-left: -6px;
      width: 102px;
      height: 102px;
    }
  }
`

export default function Stories() {
  return (
    <StoryBox>
      <StoryTitle>Instagram Stories</StoryTitle>
      <StoryLink href="https://www.instagram.com/stories/bexandchar/" target="_blank" avatar={becca} />
      <StoryLink href="https://www.instagram.com/stories/timdorr/" target="_blank" avatar={tim} />
    </StoryBox>
  )
}
