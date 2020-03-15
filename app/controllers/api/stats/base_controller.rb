# frozen_string_literal: true

module Api
  module Stats
    class BaseController < ApplicationController
      include Mixins::DateHelper

      private

      def stats_collection(beg_date, end_date)
        current_courier.daily_stats.where(
          'date BETWEEN ? AND ?', beg_date, end_date
        )
      end
    end
  end
end
