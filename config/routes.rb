TeslaTrip::Application.routes.draw do

  resource :telemetry

  root "pages#index"
end
