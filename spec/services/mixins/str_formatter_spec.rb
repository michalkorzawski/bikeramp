require 'rails_helper'

class DummyClass
  include Mixins::StrFormatter
end

RSpec.describe Mixins::StrFormatter do
  let(:dummy_class) { DummyClass.new }

  context 'url_ready' do
    it do
      str = 'Plac Europejski 2, Warszawa, Polska'
      str_after = 'Plac+Europejski+2,Warszawa,Polska'

      expect(dummy_class.url_ready(str)).to eq str_after
    end

    it do
      str = 'Plac  Europejski  2 , Polska'
      str_after = 'Plac+Europejski+2,Polska'

      expect(dummy_class.url_ready(str)).to eq str_after
    end
  end # url_ready

  context 'meters_to_km' do
    it 'meters = 1000' do
      expect(dummy_class.meters_to_km(1000)).to eq '1km'
    end

    it 'meters = 0' do
      expect(dummy_class.meters_to_km(0)).to eq '0km'
    end
  end # meters_to_km

  context 'format_number' do
    it 'num = 10.55' do
      expect(dummy_class.format_number(10.55)).to eq '10.55'
    end

    it do
      num = 10.55865634634
      expect(dummy_class.format_number(num)).to eq '10.56'
    end

    it do
      num = 10.55555555
      expect(dummy_class.format_number(num)).to eq '10.56'
    end

    it 'num = 10.05' do
      expect(dummy_class.format_number(10.05)).to eq '10.05'
    end

    it 'num = 0.0' do
      expect(dummy_class.format_number(0.0)).to eq '0'
    end
  end # format_number

  context 'price_format' do
    it 'price = Money.new(1000)' do
      expect(dummy_class.price_format(Money.new(1000))).to eq '10PLN'
    end

    it 'price = Money.new(10)' do
      expect(dummy_class.price_format(Money.new(10))).to eq '0.10PLN'
    end

    it 'price = 0' do
      expect(dummy_class.price_format(0)).to eq '0PLN'
    end
  end # price_format

  context 'day_format' do
    before do
      allow(Date).to receive(:today) { '2020-02-15'.to_date }
    end

    it do
      date = Date.today
      expect(dummy_class.day_format(date)).to eq 'Feb, 15th'
    end
  end # day_format
end
