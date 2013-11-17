TeslaTrip::Application.routes.draw do

  resource :telemetry do
    get :state
  end

  root "pages#index"
end
