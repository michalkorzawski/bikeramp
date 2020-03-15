# frozen_string_literal: true

module Api
  module Stats
    class WeeklyController < ApplicationController
      include Mixins::DateHelper

      def index
        render json: WeeklyStatsSerializer.new(
          stats: stats_collection(beg_of_week, end_of_week)
        )
      end

      private

      def stats_collection(beg_date, end_date)
        current_courier.daily_stats.where(
          'date BETWEEN ? AND ?', beg_date, end_date
        )
      end
    end
  end
end
