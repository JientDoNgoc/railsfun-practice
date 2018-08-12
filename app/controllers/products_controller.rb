class ProductsController < ApplicationController
  before_action :get_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.published.includes(:category)
  end

  def show

  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    return redirect_to products_path, notice: 'You have successfully created the product' if @product.save
    flash.now[:notice] = 'There is an error in your form'
    render :new
  end

  def edit
    render :new
  end

  def update
    return redirect_to products_path, notice: 'You have successfully updated the product' if @product.update(product_params)
    flash.now[:notice] = 'There is an error in your form'
    render :new
  end

  def destroy
    msg = @product.destroy ? 'Delete successfully' : 'Delete failed'
    redirect_to products_path, notice: msg
  end

  private
  def product_params
     params_require(:product).permit( :title,
                                      :description,
                                      :price,
                                      :published,
                                      :level,
                                      :country,
                                      :category_id)
  end

  def get_product
    @product = Product.find(params[:id])
  end
end
