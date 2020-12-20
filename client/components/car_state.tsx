import React, { createContext, useState, useRef, useEffect, useContext, PropsWithChildren } from 'react'

interface State {
  latitude: number
  longitude: number
  charging_state: string
  shift_state: string
  speed: number
  charge_rate: number
  time_to_full_charge: number
  usable_battery_level: number
  battery_range: number
  outside_temp: number
  inside_temp: number
}

interface Telemetry {
  heading: number
  latitude: number
  longitude: number
  speed: number
  battery_level: number
  range: number
  shift_state: number
}

const CarStateContext = createContext<{ state: State; telemetry: Telemetry }>(
  {} as { state: State; telemetry: Telemetry }
)

export function useCarState() {
  return useContext(CarStateContext)
}

export default function CarState({ children }: PropsWithChildren<{}>) {
  const [carState, setCarState] = useState({ state: {} as State, telemetry: {} as Telemetry })
  const socket = useRef<WebSocket | null>()

  const fetchState = async () => {
    const state = await (await fetch('/state.json')).json()
    setCarState({ ...carState, state })
  }

  useEffect(() => {
    fetchState()

    socket.current = new WebSocket(process.env.WEBSOCKET_URL || '')
    socket.current.onmessage = event => {
      const { type, ...data } = JSON.parse(event.data)
      setCarState({ ...carState, [type]: data })
    }

    return () => {
      socket.current?.close()
    }
  }, [])

  return <CarStateContext.Provider value={carState}>{children}</CarStateContext.Provider>
}
