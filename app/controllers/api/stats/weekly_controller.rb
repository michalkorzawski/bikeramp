# frozen_string_literal: true

module Api
  module Stats
    class WeeklyController < BaseController
      def index
        render json: WeeklyStatsSerializer.new(
          stats: stats_collection(beg_of_week, end_of_week)
        )
      end
    end
  end
end
