require "spec_helper"

describe CouponCode do

  describe "applicability" do
    let(:trip) { Trip.new }
    let(:hotel) { Hotel.new }
    let(:activity) { Activity.new }
    let(:code) { CouponCode.new }

    describe "a general code" do
      before { code.applies_to = :all }
      specify { expect(code.ok_for(trip)).to be_true }
      specify { expect(code.ok_for(hotel)).to be_true }
      specify { expect(code.ok_for(activity)).to be_true }
    end

    describe "a specific code" do
      before { code.applies_to = :trip }
      specify { expect(code.ok_for(trip)).to be_true }
      specify { expect(code.ok_for(hotel)).to be_false }
      specify { expect(code.ok_for(activity)).to be_false }
    end


  end

end
