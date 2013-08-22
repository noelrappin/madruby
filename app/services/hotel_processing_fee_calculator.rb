class HotelProcessingFeeCalculator

  attr_accessor :hotel

  def initialize(hotel)
    @hotel = hotel
  end

  def fee
    if hotel.price > 250 then 10 else 0 end
  end

end
