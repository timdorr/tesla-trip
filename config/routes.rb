TeslaTrip::Application.routes.draw do
  constraints format: :json do
    resource :telemetry
    resource :state
  end
end
