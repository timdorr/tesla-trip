import React, { Component } from 'react'

export default class CarState extends Component {
  state = {
    telemetry: {},
    state: {}
  }

  componentDidMount() {
    this.socket = new WebSocket(process.env.WEBSOCKET_URL)
    this.socket.onmessage = event => {
      const { type, ...data } = JSON.parse(event.data)
      this.setState({ [type]: data })
    }
  }

  componentWillUnmount() {
    this.socket && this.socket.close()
  }

  render() {
    return this.props.children(this.state)
  }
}
