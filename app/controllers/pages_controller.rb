class PagesController < ApplicationController
  def map
    render :intro if Time.parse(ENV['START_TIME']) > Time.now
  end

  def intro
  end
end
