# frozen_string_literal: true

module Otp
  class Index
    attr_reader :phone_number

    def initialize(phone_number)
      @phone_number = phone_number
    end

    private

    def rotp_service
      ROTP::TOTP.new(base_32_phone_number)
    end

    def base_32_phone_number
      Base32.encode(phone_number)
    end
  end
end
