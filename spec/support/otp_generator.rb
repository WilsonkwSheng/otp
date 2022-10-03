require 'rails_helper'

def generate_otp(phone_number)
  Otp::Generate.new(phone_number).generate
end
