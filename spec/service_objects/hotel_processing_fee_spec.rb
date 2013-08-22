require 'spec_helper'

describe HotelProcessingFeeCalculator do

  it "returns zero for a hotel under $250" do
    hotel = double(price: 100)
    calculator = HotelProcessingFeeCalculator.new(hotel)
    expect(calculator.fee).to eq(0)
  end

  it "returns $10 for a hotel that is greater than $250" do
    hotel = double(price: 300)
    calculator = HotelProcessingFeeCalculator.new(hotel)
    expect(calculator.fee).to eq(10)
  end

end
