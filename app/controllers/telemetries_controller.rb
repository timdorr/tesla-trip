class TelemetriesController < ApplicationController
  respond_to :json

  def show
    respond_with TempodbData.new(6.hour.ago)
  end
end