class Api::V1::ProductsController < ApplicationController
    before_action :set_product, only: [ :show, :update, :destroy ]
    before_action :check_login, only: [ :create ]
    before_action :check_owner, only: [ :update, :destroy ]

    def index
        render json: Product.all
    end

    def show
        render json: @product
    end

    def create
        product = current_user.products.build(product_params)
        if product.save
            Rails.logger.info "Product created with ID: #{product.id} by User ID: #{current_user.id}"
            render json: product, status: :created
        else
            render json: { errors: product.errors }, status: :unprocessable_entity
        end
    end

    def update
        if @product.update(product_params)
            Rails.logger.info "Product with ID: #{@product.id} updated by User ID: #{current_user.id}"
            render json: @product, status: :ok
        else
            render json: @product.errors, status: :unprocessable_entity
        end
    end

    def destroy
        Rails.logger.info "Product with ID: #{@product.id} is being deleted by User ID: #{current_user.id}"
        @product.destroy
        head :no_content
    end

    private

    def set_product
        @product = Product.find(params[:id])
    end

    def product_params
        params.require(:product).permit(:title, :price, :published)
    end

    def check_owner
        Rails.logger.info "Current user ID: #{current_user&.id}, Product user ID: #{@product.user_id}"
        head :forbidden unless @product.user_id == current_user&.id
    end
end
