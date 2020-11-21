class OrdersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create, :show]

  def show

  end

  def create
    product = Product.find(params[:orderable_id])
    order = Order.new(
      orderable: product,
      orderable_sku: product.sku,
      amount: product.price,
      state: "pending",
      user_id: current_user.id,
    )
    authorize order
    order.save!

    session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      line_items: [{
        name: product.sku,
        amount: product.price_cents,
        currency: "usd",
        quantity: 1,
      }],
      success_url: order_url(order),
      cancel_url: order_url(order),
    )

    order.update(checkout_session_id: session.id)
    redirect_to new_order_payment_path(order)
  end
end
