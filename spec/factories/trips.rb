FactoryBot.define do
  factory :trip, class: Trip do
    start_address { 'Plac Europejski 2, Warszawa, Polska' }
    destination_address { 'Plac Europejski 2, Warszawa, Polska' }
    price_cents { '5000' }
    date { Time.current }
  end
end
