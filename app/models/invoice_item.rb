class InvoiceItem < ApplicationRecord
  validates_presence_of :invoice_id,
                        :item_id,
                        :quantity,
                        :unit_price,
                        :status

  belongs_to :invoice
  belongs_to :item
  has_many :transactions, through: :invoice
  has_one :merchant, through: :item
  has_many :bulk_discounts, through: :merchant

  enum status: [:pending, :packaged, :shipped]

  def self.incomplete_invoices
    invoice_ids = InvoiceItem.where("status = 0 OR status = 1").pluck(:invoice_id)
    Invoice.order(created_at: :asc).find(invoice_ids)
  end

  def correct_bulk_discount_to_apply
    # require "pry"; binding.pry
    item.merchant.bulk_discounts.where('bulk_discounts.quantity_threshold <= ?', quantity)
                                .order(percentage: :desc)
                                .first
  end

  def total_discounted_revenue
    if correct_bulk_discount_to_apply == nil
      (unit_price * quantity)
    else
      (unit_price * quantity) * (1 - (correct_bulk_discount_to_apply.percentage / 100.to_f))
    end
  end
end
