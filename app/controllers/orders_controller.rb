class OrdersController < ApplicationController

  def create
    PurchasesOrder.new(
        params[:trip_id], params[:hotel_id], params[:activity_id],
        params[:length_of_stay]).run
    redirect_to :root
  end

end
