# frozen_string_literal: true

module Api
  module Stats
    class MonthlyController < BaseController
      def index
        render json: MonthlyStatsSerializer.new(
          stats: stats_collection(beg_of_month, end_of_month)
        )
      end
    end
  end
end
