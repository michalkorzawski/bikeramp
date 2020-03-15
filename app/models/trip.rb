# frozen_string_literal: true

class Trip < ApplicationRecord
  belongs_to :courier

  monetize :price_cents

  validates :start_address, presence: true
  validates :destination_address, presence: true
  validates :price_cents, presence: true
  validates :price_cents, numericality: {
    greater_than_or_equal_to: 0
  }
  validates :date, presence: true
end
