require 'rails_helper'

describe 'Verify OTP code', vcr: true do
  let(:phone_number) { '+60102319970' }
  let(:otp_response) { generate_otp(phone_number) }

  subject { Otp::Verify.new(phone_number) }

  it 'successfully verify otp code with valid code' do
    otp_code = otp_response[:data].body.slice(/\d{6}/)
    otp_response[:data].date_created
    Timecop.freeze(otp_response[:data].date_created) do
      response = subject.verify(otp_code)
      expect(response[:success]).to(eq(true))
      expect(response[:data]).to(eq('Successfully verified OTP.'))
    end
  end

  it 'fail to verify otp code when otp code expires' do
    otp_code = otp_response[:data].body.slice(/\d{6}/)
    # Assuming is not pass expiry time
    Timecop.freeze(otp_response[:data].date_created + 30) do
      first_verify_response = subject.verify(otp_code)
      expect(first_verify_response[:success]).to(eq(true))
      expect(first_verify_response[:data]).to(eq('Successfully verified OTP.'))
    end
    # Assuming it has past expiry time
    Timecop.freeze(otp_response[:data].date_created + 600) do
      second_verify_response = subject.verify(otp_code)
      expect(second_verify_response[:success]).to(eq(false))
      expect(second_verify_response[:data]).to(eq('Unable to verify OTP. OTP is invalid or past its expiry time. Please try again.'))
    end
  end
end