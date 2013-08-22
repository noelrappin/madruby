require 'spec_helper'

describe ActivityProcessingFeeCalculator do

  it "always returns $5" do
    calculator = ActivityProcessingFeeCalculator.new(double)
    expect(calculator.fee).to eq(5)
  end

end


