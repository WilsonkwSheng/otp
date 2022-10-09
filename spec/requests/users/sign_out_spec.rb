# frozen_string_literal: true
require 'rails_helper'

feature 'Sign Out User', type: 'request' do
  let!(:user) { create :user }

  it 'successfully signed out with valid credentials' do
    delete "/users/sign_out",
    headers: auth_headers(user)
    json = JSON.parse(response.body)
    success = json['success']
    expect(success).to(eq(true))
  end

  it 'failed to signed out with invalid credentials' do
    delete "/users/sign_out"
    json = JSON.parse(response.body)
    success = json['success']
    expect(success).to(eq(false))
    errors = json['errors']
    expect(errors).to(eq([
      "User was not found or was not logged in."
    ]))
  end
end
