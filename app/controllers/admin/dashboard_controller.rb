class Admin::DashboardController < ApplicationController
  # http_basic_authenticate_with name: ENV['HTTP_BASIC_AUTH_USER'], password: ENV['HTTP_BASIC_AUTH_PASSWORD']
  http_basic_authenticate_with name: "jungle", password: "book"
  def show
    @product_count = Product.sum(:quantity)
    @category_count = Category.count
  end
end
