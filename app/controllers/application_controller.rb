# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable

  private

  def unprocessable(err)
    render json: { errors: err.to_s },
           status: :unprocessable_entity
  end

  # I follow the "No login required" rule by pretending that we have
  # the current_courier whos id was acquired by decoding authentication
  # bearer token.
  def current_courier
    Courier.first
  end
end
