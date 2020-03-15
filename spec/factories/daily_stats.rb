FactoryBot.define do
  factory :daily_stat, class: DailyStat do
    total_distance { 123 }
    avg_ride { 12 }
    avg_price_cents { '500' }
    total_price_cents { '5000' }
    date { '2009-11-11' }
  end
end
