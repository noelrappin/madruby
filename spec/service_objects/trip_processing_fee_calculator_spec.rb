require 'spec_helper'

describe TripProcessingFeeCalculator do

  it "returns zero for a trip that is within 100 years" do
    trip = double(start_date: Date.parse("Jan 1, 2000"))
    calculator = TripProcessingFeeCalculator.new(trip)
    expect(calculator.fee).to eq(0)
  end

  it "returns $1 for a trip that is after 100 years" do
    trip = double(start_date: Date.parse("Jan 1, 1900"))
    calculator = TripProcessingFeeCalculator.new(trip)
    expect(calculator.fee).to eq(1)
  end

end
