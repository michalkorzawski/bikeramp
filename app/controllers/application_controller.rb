# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable

  def unprocessable(err)
    render json: { errors: err.to_s },
           status: :unprocessable_entity
  end
end
