# frozen_string_literal: true

require 'rails_helper'

feature 'Register User', type: 'request' do
  let!(:existing_user) { create(:user) }

  it 'successfully signed up with valid credential' do
    post "/users/sign_up",
    params: {
      user: {
        email: 'user@google.com',
        password: 'password1',
        name: 'user',
        phone_number: '+60102319970',
      }
    }
    json = JSON.parse(response.body)
    status = json['status']
    expect(status).to(eq('success'))
    expect(User.count).to(eq(2))
  end

  it 'failed to sign up with valid credential' do
    post "/users/sign_up",
    params: {
      user: {
        email: existing_user.email,
        password: existing_user.password,
        name: existing_user.name,
        phone_number: existing_user.phone_number,
      }
    }
    json = JSON.parse(response.body)
    status = json['status']
    expect(status).to(eq('error'))
    expect(User.count).to(eq(1))
  end
end
