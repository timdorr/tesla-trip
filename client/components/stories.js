import React from 'react'
import styled from 'styled-components'

import instagramLogo from '../images/instagram.png'
import tim from '../images/story.tim.jpg'
import becca from '../images/story.becca.jpg'

const StoryBox = styled.div`
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
  background: #f6f6f6;
  box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
  border-radius: 10px;
`

const StoryTitle = styled.h3`
  grid-area: title;
  height: 20px;
  margin: 0;
  padding-left: 25px;
  font-weight: 500;
  font-size: 14px;
  line-height: 18px;
  background: transparent url('${instagramLogo}') no-repeat left top / 20px;
`

const StoryLink = styled.a`
  display: block;
  height: 52px;
  width: 52px;
  background: url('${props => props.avatar}') no-repeat top left / 52px;
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
`

const StoryImage = styled.img`
  width: 100%;
  height: 100%;
`

export default function Stories() {
  return (
    <StoryBox>
      <StoryTitle>Instagram Stories</StoryTitle>
      <StoryLink
        href="https://www.instagram.com/stories/bexandchar/"
        target="_blank"
        avatar={becca}
      />
      <StoryLink
        href="https://www.instagram.com/stories/timdorr/"
        target="_blank"
        avatar={tim}
      />
    </StoryBox>
  )
}