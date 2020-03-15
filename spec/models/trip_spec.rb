require 'rails_helper'

describe Trip do

  let(:trip_attr) do
    {
      start_address: start_address,
      destination_address: destination_address,
      price: price,
      date: date,
    }
  end

  let(:start_address) { 'start_address' }
  let(:destination_address) { 'Plac Dąbrowskiego 2, Warszawa, Polska' }
  let(:price) { '12' }
  let(:date) { '2018-04-03' }

  context 'success' do
    context 'all attr' do
      it do
        expect{ Trip.create!(**trip_attr)}
          .to change{Trip.count}
          .from(0)
          .to(1)
      end
    end # all attr

    context 'without price' do
      it do
        expect{ Trip.create!(**trip_attr.except(:price))}
          .to change{Trip.count}
          .from(0)
          .to(1)
      end

      it do
        Trip.create!(**trip_attr.except(:price))
        expect(Trip.last.price).to eq Money.new(0)
      end
    end
  end # success

  context 'fail' do
    context 'without start_address' do
      it do
        expect{ Trip.create!(**trip_attr.except(:start_address))}
          .to raise_error(
            ActiveRecord::RecordInvalid,
            "Validation failed: Start address can't be blank"
          )
      end

      context 'with empty start_address' do
        let(:start_address) { ' ' }

        it do
          expect{ Trip.create!(**trip_attr)}
            .to raise_error(
              ActiveRecord::RecordInvalid,
              "Validation failed: Start address can't be blank"
            )
        end
      end # with empty start_address
    end # without start_address

    context 'without destination_address' do
      it do
        expect{ Trip.create!(**trip_attr.except(:destination_address))}
          .to raise_error(
            ActiveRecord::RecordInvalid,
            "Validation failed: Destination address can't be blank"
          )
      end

      context 'with empty destination_address' do
        let(:destination_address) { ' ' }

        it do
          expect{ Trip.create!(**trip_attr)}
            .to raise_error(
              ActiveRecord::RecordInvalid,
              "Validation failed: Destination address can't be blank"
            )
        end
      end # with empty destination_address
    end # without destination_address

    context 'without date' do
      it do
        expect{ Trip.create!(**trip_attr.except(:date))}
          .to raise_error(
            ActiveRecord::RecordInvalid,
            "Validation failed: Date can't be blank"
          )
      end

      context 'with empty date' do
        let(:date) { ' ' }

        it do
          expect{ Trip.create!(**trip_attr)}
            .to raise_error(
              ActiveRecord::RecordInvalid,
              "Validation failed: Date can't be blank"
            )
        end
      end # with empty date
    end # without date

    context 'with negative price' do
      let(:price) { '-10' }

      it do
        expect{ Trip.create!(**trip_attr)}
          .to raise_error(
            ActiveRecord::RecordInvalid,
            "Validation failed: Price cents must be greater than or equal to 0"
          )
      end
    end # with negative price
  end # fail
end
