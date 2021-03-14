class Manage::ProductsController < Manage::ApplicationController
  def index
    @products = policy_scope([:manage, Product])
  end

  def edit
    @product = Product.find(params[:id])
    authorize [:manage, @product]
  end

  def update
    @product = Product.find(params[:id])
    authorize [:manage, @product]

    if @product.update(product_params)
      redirect_to [:manage, :products]
    else
      render :edit
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :sku, :price, :full_price, :description)
  end
end
