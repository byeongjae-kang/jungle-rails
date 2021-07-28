require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do


  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They can add products to cart" do
  
  visit root_path
  
  expect(page).to have_content('My Cart (0)')

  save_screenshot
  
  find('.btn-primary', match: :first).click

  expect(page).to have_content('My Cart (1)')

  save_screenshot
  end

end

# <form class="button_to" method="post" action="/cart/add_item?product_id=12"><button class="btn btn-primary" type="submit">
#       <i class="fa fa-shopping-cart"></i> Add
# </button><input type="hidden" name="authenticity_token" value="ySgx6X2E5tBH15kNOoTTcafPmtKGPdpuCdRmnTPzgCAXbl6FJ3e53hL/kgC+EXmlgvdwLNqjvGwClH+2bnIhSA=="></form>