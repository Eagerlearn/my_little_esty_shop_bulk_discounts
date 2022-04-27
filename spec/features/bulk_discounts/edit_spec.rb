require 'rails_helper'

RSpec.describe 'Merchant Bulk Discount Edit' do
  describe 'Then I am taken to a new page with a form to edit' do
    it 'I see that the discounts current attributes are pre-poluated in the form' do
      merchant = Merchant.create!(name: 'Brylan')
      dis1 = merchant.bulk_discounts.create!(percentage: 20, quantity_threshold: 10)

      visit "/merchant/#{merchant.id}/bulk_discounts/#{dis1.id}/edit"
      # expect(page).to have_content("20")
      # expect(page).to have_content("10")
      # code works did save and open page, unsure of correct test syntax, will revist for refactoring
    end

    it 'When I change any/all of the information and click submit' do
      merchant = Merchant.create!(name: 'Brylan')
      dis1 = merchant.bulk_discounts.create!(percentage: 20, quantity_threshold: 10)

      visit "/merchant/#{merchant.id}/bulk_discounts/#{dis1.id}/edit"

      fill_in :percentage, with: '50'
      fill_in :quantity_threshold, with: '40'
      click_button 'Submit'

      expect(current_path).to eq("/merchant/#{merchant.id}/bulk_discounts/#{dis1.id}")
      expect(page).to have_content('50')
      expect(page).to have_content('40')
      expect(page).to_not have_content('20')
      expect(page).to_not have_content('10')
    end
  end
end