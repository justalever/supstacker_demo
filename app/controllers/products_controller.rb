class ProductsController < ApplicationController
  before_action :authenticate_user!, except: %i[ index show ]
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :set_stack

  def index
    @products = Product.all
  end

  def show
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    link = params[:product][:link].strip
    ProductImportJob.perform_later(link, @stack.id)
    redirect_to stack_path(@stack), notice: "Product is being created, sit tight!"
  end

  def update
    if @product.update(product_params)
      redirect_to stack_product_url(@stack, @product), notice: "Product was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy!
    redirect_to stack_url(@stack), notice: "Product was successfully destroyed."
  end

  private
    def set_stack
      @stack = Stack.find_by(share_link: params[:share_link]) || Stack.find_by(id: params[:share_link])
    end

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:title, :description, :link, :asin, :price, :brand_id)
    end
end
