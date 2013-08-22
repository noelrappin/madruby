class OrdersController < ApplicationController

  def create
    PurchasesOrder.new(params[:trip_id], params[:hotel_id],
        params[:activity_id]).run
    redirect_to :root
  end

end
