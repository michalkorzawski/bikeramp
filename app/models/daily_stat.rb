# frozen_string_literal: true

class DailyStat < ApplicationRecord
  belongs_to :courier
  monetize :avg_price_cents
  monetize :total_price_cents
end
