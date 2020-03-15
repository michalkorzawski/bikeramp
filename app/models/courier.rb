# frozen_string_literal: true

class Courier < ApplicationRecord
  has_many :trips, dependent: :destroy
  has_many :daily_stats, dependent: :destroy
end
