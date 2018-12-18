class ApplicationController < ActionController::API
  respond_to :json

  force_ssl if: ->() { !Rails.env.development? }

  protected

  def ensure_authentication_token
    if stream_params[:api_token] != ENV['WS_TOKEN']
      render json: {error: 'Bad api token'}, status: :unauthorized
      false
    end
  end

  def stream_params
    params.permit(:api_token, :state)
  end
end
