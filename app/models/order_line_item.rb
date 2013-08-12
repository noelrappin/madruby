class OrderLineItem < ActiveRecord::Base

  belongs_to :order
  belongs_to :buyable, polymorphic: true

  def price_plus_processing
    total_price + processing_fee
  end

end
