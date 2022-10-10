# frozen_string_literal: true

module Otp
  class Verify < Otp::Index
    def verify(otp_code)
      response = rotp_service.verify(otp_code, drift_behind: 60)
      if response.present?
        {
          success: true,
          data: "Successfully verified OTP.",
        }
      else
        {
          success: false,
          data: "Unable to verify OTP. OTP is invalid or past its expiry time. Please try again.",
        }
      end
    end
  end
end
