# frozen_string_literal: true

module Otp
  class Generate < Otp::Index
    def generate
      message = twilio_service.messages.create(
        body: "This is your OTP code. #{one_time_password}",
        from: ENV["TWILIO_PHONE_NUMBER"],
        to: phone_number,
      )
      { success: true, data: message }
    rescue => error
      { success: false, data: "Unable to generate OTP. Reasons: #{error}" }
    end

    private

    def twilio_service
      Twilio::REST::Client.new(ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"])
    end

    def one_time_password
      rotp_service.now
    end
  end
end
