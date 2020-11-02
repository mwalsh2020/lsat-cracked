class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @products = policy_scope(Product).order(:id)
  end
end
