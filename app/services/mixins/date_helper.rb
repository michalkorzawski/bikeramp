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

    def end_of_week
      date.end_of_week
    end
  end
end
