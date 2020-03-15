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
      String(format_number(meters / 1000.0)) + 'km'
    end

    def format_number(num)
      number_with_precision(num,
                            precision: 2,
                            strip_insignificant_zeros: true)
    end

    def price_format(price)
      price.format(
        symbol: false,
        with_currency: true,
        no_cents_if_whole: true
      ).gsub(' ', '')
    end
  end
end
