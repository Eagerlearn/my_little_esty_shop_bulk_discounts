require 'rails_helper'

RSpec.describe BulkDiscount do
  describe 'relationships' do
    it { should belong_to :merchant }
  end

  describe 'validations' do
    it { should validate_numericality_of(:quantity_threshold) }
    it do
      validate_inclusion_of(:percentage).
       in_array([1..100])
    end
  end
end