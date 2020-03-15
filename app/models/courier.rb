class Courier < ApplicationRecord
  has_many :trips, dependent: :destroy
end
