class TelemetriesController < ApplicationController
  respond_to :json

  def show
    respond_with TempodbData.new(1.day.ago)
  end
end