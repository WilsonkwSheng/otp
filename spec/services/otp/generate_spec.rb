# frozen_string_literal: true

require "rails_helper"

describe "Generate and send OTP", vcr: true do
  let(:phone_number) { "+60102319970" }
  let(:otp_response) { generate_otp(phone_number) }

  it "successfully send otp code with valid phone numbers" do
    expect(otp_response[:success]).to(eq(true))
    otp_code = otp_response[:data].body.slice(/\d{6}/)
    expect(otp_response[:data].body).to(include("This is your OTP code. #{otp_code}"))
  end

  it "fail to send otp code with invalid phone numbers" do
    expect(otp_response[:success]).to(eq(false))
    expect(otp_response[:data]).to(include("Unable to generate OTP. Reasons:"))
  end
end
