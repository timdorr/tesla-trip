class PagesController < ApplicationController
  def map
    render :intro if (Time.parse(ENV['START_TIME']) - 12.hours) > Time.now
  end

  def intro
  end
end
