# frozen_string_literal: true

class OtpController < ApplicationController
  def create
    response = Otp::Generate.new(params[:phone_number]).generate
    if response[:success]
      render(json: { success: response[:success], data: "Successfully sent OTP code." }, status: :ok)
      return
    end

    render(json: { success: response[:success], data: response[:data] }, status: :bad_request)
  end

  def verify
    response = Otp::Verify.new(params[:phone_number]).verify(params[:otp_code])
    if response[:success]
      render(json: { success: response[:success], data: response[:data] }, status: :ok)
      return
    end

    render(json: { success: response[:success], data: response[:data] }, status: :bad_request)
  end
end
