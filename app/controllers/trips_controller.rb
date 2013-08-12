class TripsController < ApplicationController

  def show
    #@trip = Trip.find(params[:id])
    @trip = TripPresenter.new(Trip.find(params[:id]))
  end
end
