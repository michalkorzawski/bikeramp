# frozen_string_literal: true

module Mixins
  module StrFormatter
    include ActionView::Helpers::NumberHelper

    def url_ready(str)
      str.split(',')
         .map(&:strip)
         .join(',')
         .split(' ')
         .join('+')
    end

    def meters_to_km(meters)
      return '0km' if meters.zero?

      String(format_number(meters / 1000.0)) + 'km'
    end

    def format_number(num)
      number_with_precision(num,
                            precision: 2,
                            strip_insignificant_zeros: true)
    end

    def price_format(money_obj)
      money_obj = Money.new(money_obj) if money_obj.zero?

      money_obj.format.gsub(' ', '')
    end

    def day_format(date)
      date.strftime("%b, #{date.day.ordinalize}")
    end
  end
end
