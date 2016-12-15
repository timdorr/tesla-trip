TeslaTrip::Application.routes.draw do
  resource :telemetry do
    get :state
  end

  get 'map',   to: 'pages#map'
  get 'intro', to: 'pages#intro'

  root 'pages#map'
end
