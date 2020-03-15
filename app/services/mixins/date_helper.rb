# frozen_string_literal: true

module Mixins
  module DateHelper
    private

    def date
      Date.today
    end

    def beg_of_week
      date.beginning_of_week
    end

    def beg_of_month
      date.beginning_of_month
    end

    def end_of_week
      date.end_of_week
    end

    def end_of_month
      date.end_of_month
    end
  end
end
