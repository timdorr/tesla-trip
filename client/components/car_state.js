import React, { Component } from 'react'

export default class CarState extends Component {
  state = {
    telemetry: null,
    state: {}
  }

  async componentDidMount() {
    this.socket = new WebSocket(process.env.WEBSOCKET_URL)
    this.socket.onmessage = event => {
      const { type, ...data } = JSON.parse(event.data)
      this.setState({ [type]: data })
    }

    const state = await (await fetch('/state.json')).json()
    this.setState({ state })
  }

  componentWillUnmount() {
    this.socket && this.socket.close()
  }

  render() {
    return this.props.children(this.state)
  }
}
