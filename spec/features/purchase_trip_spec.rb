require "spec_helper"

describe "purchasing a trip" do

  let!(:mayflower) { Trip.create!(
      :name => "Mayflower Luxury Cruise",
      :tag_line => "Enjoy The Cruise That Started It All",
      :start_date => "September 6, 1620",
      :end_date => "November 21, 1620",
      :location => "Atlantic Ocean",
      :tag => "Cruising",
      :image_name => "mayflower.jpg",
      :description => "You'll take a scenic 66 day, 67 night cruise from England to Cape Cod. Come for the scurvy, stay for the starvation",
      :price => 1200) }

  before do
    Hotel.create!(
        :trip => mayflower,
        :name => "Deluxe Suite",
        :description => "A luxury suite. On the Mayflower. Really.",
        :price => 500,
        :remote_api_id => "abc123")

    Activity.create!(
        :trip => mayflower,
        :name => "Martha's Vineyard",
        :description => "Tour Martha's Vineyard",
        :price => 400)

    Activity.create!(
        :trip => mayflower,
        :name => "Special Boat Tour",
        :description => "Tour The Whole Boat",
        :price => 300)
  end

  describe "basic process" do

    before(:each) do
      visit("/trips/#{mayflower.id}")
      select('4', :from => 'length_of_stay')
      choose("hotel_id_#{mayflower.hotels.first.id}")
      check("activity_id_#{mayflower.activities.first.id}")
      click_button("Order")
    end

    it "creates order and line item objects" do
      order = Order.last
      expect(order.order_line_items.count).to eq(3)
      expect(order.order_line_items.map(&:buyable)).to eq(
          [mayflower, mayflower.hotels.first, mayflower.activities.first])
    end

    it "correctly puts pricing in the trip line item objects" do
      order = Order.last
      trip = order.trip_item
      expect(trip.unit_price).to eq(1200)
      expect(trip.amount).to eq(1)
      expect(trip.extended_price).to eq(1200)
      expect(trip.processing_fee).to eq(3)
    end

    it "correctly puts pricing in the hotel line item objects" do
      order = Order.last
      hotel = order.hotel_item
      expect(hotel.unit_price).to eq(500)
      expect(hotel.amount).to eq(4)
      expect(hotel.extended_price).to eq(2000)
      expect(hotel.processing_fee).to eq(10)
    end

    it "correctly puts pricing in the activity line item objects" do
      order = Order.last
      activity = order.activity_items.first
      expect(activity.unit_price).to eq(400)
      expect(activity.amount).to eq(1)
      expect(activity.extended_price).to eq(400)
      expect(activity.processing_fee).to eq(5)
    end

    it "correctly puts pricing in the order object" do
      order = Order.last
      expect(order.total_price_paid).to eq(3600 + 3 + 10 + 5 + 10)
    end

  end

  describe "with coupon codes" do

    before do
      CouponCode.create!(code: "HALF_OFF", discount_percentage: 50)
      visit("/trips/#{mayflower.id}")
      select('4', :from => 'length_of_stay')
      choose("hotel_id_#{mayflower.hotels.first.id}")
      check("activity_id_#{mayflower.activities.first.id}")
      fill_in("coupon_code", with: "HALF_OFF")
      click_button("Order")
    end

    it "correctly discounts the trip itself" do
      order = Order.last
      trip = order.trip_item
      expect(trip.unit_price).to eq(1200)
      expect(trip.amount).to eq(1)
      expect(trip.extended_price).to eq(1200)
      expect(trip.discount).to eq(600)
      expect(trip.processing_fee).to eq(3)
      expect(trip.price_paid).to eq(603)
    end

  end

end
