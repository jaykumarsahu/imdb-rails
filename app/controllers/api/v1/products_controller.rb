class Api::V1::ProductsController < ApplicationController
  # skip_before_action :authenticate_request!

  def index
    products = Product.json_data
    if products.present?
      render json: { status: "SUCCESS", products: products }, status: :ok
    end
  end


end
