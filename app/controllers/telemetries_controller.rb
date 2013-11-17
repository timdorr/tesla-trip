class TelemetriesController < ApplicationController
  respond_to :json

  def show
    data = TempodbData.new(Time.parse(ENV["START_TIME"]))
    Rails.logger.info(data)
    respond_with data
  end
end