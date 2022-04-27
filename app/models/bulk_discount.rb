class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  has_many :items, through: :merchant
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  validates_inclusion_of :percentage, :in => 1..100
  validates_numericality_of :quantity_threshold
end