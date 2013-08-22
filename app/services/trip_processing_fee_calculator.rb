class TripProcessingFeeCalculator

  attr_accessor :trip

  def initialize(trip)
    @trip = trip
  end

  def year
    trip.start_date.year
  end

  def fee
    (2013 - year) / 100
  end

end
