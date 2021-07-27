require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    before(:each) do 
      @category = Category.new(
        name: "Electronics"
      )
      
      @product = Product.new(
        name: "product",
        price_cents: 100,
        quantity: 5,
        category: @category
      )
      @product.save
      # p @category
      # p @product
    end

    it "name to be present" do
      @product.name = nil
      @product.valid?
      expect(@product.errors.full_messages).to include("Name can't be blank")

      @product.name = "product"
      expect(@product.name).to be_present
    end

    it "price to be present" do
      @product.price_cents = nil
      @product.valid?
      expect(@product.errors.full_messages).to include("Price can't be blank")
      
      @product.price_cents = 100
      expect(@product.price).to be_present
    end

    it "quantity to be present" do
      @product.quantity = nil
      @product.valid?
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
      
      @product.quantity = 5
      expect(@product.quantity).to be_present
      
    end

    it "category to be present" do
      @product.category = nil
      @product.valid?
      expect(@product.errors.full_messages).to include("Category can't be blank")
      
      @product.category = @category
      expect(@product.category).to be_present
      
    end

  end
end
