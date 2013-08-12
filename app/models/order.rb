class Order < ActiveRecord::Base

  has_many :order_line_items
  belongs_to :user

  def trip_item
    order_line_items.where(buyable_type: "Trip").first
  end

  def hotel_item
    order_line_items.where(buyable_type: "Hotel").first
  end

  def activity_items
    order_line_items.where(buyable_type: "Activity")
  end

end
