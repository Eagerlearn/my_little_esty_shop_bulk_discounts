require 'rails_helper'

RSpec.describe 'Merchant Bulk Discount Index Page' do
  describe 'When I visit the merchant bulk discount index page' do
    it 'I see all of my bulk_discounts including their percentage and quantity_thresholds' do
      merchant = Merchant.create!(name: 'Brylan')
      dis1 = merchant.bulk_discounts.create!(percentage: 20, quantity_threshold: 10)
      dis2 = merchant.bulk_discounts.create!(percentage: 30, quantity_threshold: 15)
      dis3 = merchant.bulk_discounts.create!(percentage: 40, quantity_threshold: 20)

      merchant_2 = Merchant.create!(name: 'another')
      dis4 = merchant_2.bulk_discounts.create!(percentage: 15, quantity_threshold: 5)
      dis5 = merchant_2.bulk_discounts.create!(percentage: 25, quantity_threshold: 10)
      dis6 = merchant_2.bulk_discounts.create!(percentage: 35, quantity_threshold: 15)

      visit "/merchant/#{merchant.id}/bulk_discounts"
      within "#discount-#{dis1.id}" do
        expect(page).to have_content(dis1.percentage)
        expect(page).to have_content(dis1.quantity_threshold)
        expect(page).to_not have_content(dis2.percentage)
        expect(page).to_not have_content(dis2.quantity_threshold)

        click_link "Discount Show Page"
        expect(current_path).to eq("/merchant/#{merchant.id}/bulk_discounts/#{dis1.id}")
      end
      visit "/merchant/#{merchant.id}/bulk_discounts"
      within "#discount-#{dis2.id}" do
        expect(page).to have_content(dis2.percentage)
        expect(page).to have_content(dis2.quantity_threshold)
      end
      within "#discount-#{dis3.id}" do
        expect(page).to have_content(dis3.percentage)
        expect(page).to have_content(dis3.quantity_threshold)
      end
    end

    it 'Then next to each bulk discount I see a link to delete it' do
      merchant = Merchant.create!(name: 'Brylan')
      dis1 = merchant.bulk_discounts.create!(percentage: 20, quantity_threshold: 10)
      dis2 = merchant.bulk_discounts.create!(percentage: 30, quantity_threshold: 15)
      dis3 = merchant.bulk_discounts.create!(percentage: 40, quantity_threshold: 20)

      merchant_2 = Merchant.create!(name: 'another')
      dis4 = merchant_2.bulk_discounts.create!(percentage: 15, quantity_threshold: 5)
      dis5 = merchant_2.bulk_discounts.create!(percentage: 25, quantity_threshold: 10)
      dis6 = merchant_2.bulk_discounts.create!(percentage: 35, quantity_threshold: 15)

      visit "/merchant/#{merchant.id}/bulk_discounts"

      within "#discount-#{dis1.id}" do
        expect(page).to have_content("Delete Discount")
        click_link "Delete Discount"
        expect(current_path).to eq("/merchant/#{merchant.id}/bulk_discounts")
      end
      within "#discount-#{dis2.id}" do
        expect(page).to have_content("Delete Discount")
      end
      within "#discount-#{dis3.id}" do
        expect(page).to have_content("Delete Discount")
      end
      expect(page).to_not have_content("#{dis1.id}")
      expect(page).to_not have_content("#{dis4.id}")
    end

    xit 'I see a section with a header of "Upcoming Holidays"' do
      expect(page).to have_content("Upcoming Holidays")
    end
  end
  describe 'Create new Bulk Discount' do
    describe 'Then I am taken to a new page where I see a form to add a new bulk discount' do
      it 'Fill in the form with valid data' do
        merchant = Merchant.create!(name: 'Brylan')
        dis1 = merchant.bulk_discounts.create!(percentage: 20, quantity_threshold: 10)
        dis2 = merchant.bulk_discounts.create!(percentage: 30, quantity_threshold: 15)
        dis3 = merchant.bulk_discounts.create!(percentage: 40, quantity_threshold: 20)

        visit "/merchant/#{merchant.id}/bulk_discounts/new"

        fill_in 'percentage', with: '45'
        fill_in 'quantity_threshold', with: '25'
        click_button 'Submit'

        expect(current_path).to eq("/merchant/#{merchant.id}/bulk_discounts")
        expect(merchant.bulk_discounts.last.percentage).to eq(45)
        expect(merchant.bulk_discounts.last.quantity_threshold).to eq(25)
      end
    end
  end
end
