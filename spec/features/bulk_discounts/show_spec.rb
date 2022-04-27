require 'rails_helper'

RSpec.describe 'Merchant Bulk Discount Show Page' do
  describe 'As a merchant when I visit my bulk discount show page' do
    it 'Then I see the bulk discounts quantity threshold and percentage discount' do
      merchant = Merchant.create!(name: 'Brylan')
      dis1 = merchant.bulk_discounts.create!(percentage: 20, quantity_threshold: 10)
      dis2 = merchant.bulk_discounts.create!(percentage: 30, quantity_threshold: 15)

      visit "/merchant/#{merchant.id}/bulk_discounts/#{dis1.id}"

      expect(page).to have_content("#{dis1.percentage}")
      expect(page).to have_content("#{dis1.quantity_threshold}")
      expect(page).to_not have_content("#{dis2.percentage}")
      expect(page).to_not have_content("#{dis2.quantity_threshold}")
    end

    it 'Then I see a link to edit the bulk discount' do
      merchant = Merchant.create!(name: 'Brylan')
      dis1 = merchant.bulk_discounts.create!(percentage: 20, quantity_threshold: 10)
      dis2 = merchant.bulk_discounts.create!(percentage: 30, quantity_threshold: 15)

      visit "/merchant/#{merchant.id}/bulk_discounts/#{dis1.id}"

      click_link 'Edit Bulk Discount'
      expect(current_path).to eq("/merchant/#{merchant.id}/bulk_discounts/#{dis1.id}/edit")
    end
  end
end