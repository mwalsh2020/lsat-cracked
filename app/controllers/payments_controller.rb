class PaymentsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new]

  def new
    # TODO: add user?
    @order = Order.find(params[:order_id])
    authorize @order
  end
end
