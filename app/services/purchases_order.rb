class PurchasesOrder

  attr_accessor :length_of_stay

  def initialize(trip_id, hotel_id, activity_ids, length_of_stay)
    @trip_id, @hotel_id, @activity_ids = trip_id, hotel_id, activity_ids
    @length_of_stay = length_of_stay
  end

  def trip
    @trip ||= Trip.find(@trip_id)
  end

  def hotel
    @hotel ||= Hotel.find(@trip_id)
  end

  def activities
    @activities ||= @activity_ids.map { |id| Activity.find(id) }
  end

  def order
    @order ||= Order.new
  end

  def add_line_item(buyable, unit_price, amount, calculator_class)
    extended_price = amount * unit_price
    processing_fee = calculator_class.new(buyable).fee.to_f
    order.order_line_items.new(buyable: buyable,
        unit_price: unit_price,
        amount: amount, extended_price: extended_price,
        processing_fee: processing_fee,
        price_paid: extended_price + processing_fee)
  end

  def calculate_order_price
    order.order_line_items.map(&:price_paid)
        .sum.to_f + 10
  end

  def run
    add_line_item(trip, trip.price, 1,
        TripProcessingFeeCalculator)
    add_line_item(
        hotel, hotel.price, length_of_stay.to_i,
        HotelProcessingFeeCalculator)
    activities.each do |a|
      add_line_item(a, a.price, 1,
          ActivityProcessingFeeCalculator)
    end
    order.total_price_paid = calculate_order_price
    order.save
  end
end
