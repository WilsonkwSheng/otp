# frozen_string_literal: true

require 'rails_helper'

feature 'Validate User Auth Token', type: 'request' do
  let!(:user) { create :user }

  it 'successfully validate user auth token' do
    get "/users/validate_token",
    headers: auth_headers(user)
    json = JSON.parse(response.body)
    status = json['success']
    expect(status).to(eq(true))
  end

  it 'fail to validate user auth token when expired' do
    auth_headers = auth_headers(user)
    Timecop.travel(3.weeks) do
      get "/users/validate_token",
      headers: auth_headers
      json = JSON.parse(response.body)
      status = json['success']
      expect(status).to(eq(false))
      errors = json['errors']
      expect(errors).to(eq(
        ["Invalid login credentials"]
      ))
    end
  end
end
