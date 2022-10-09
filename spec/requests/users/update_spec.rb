# frozen_string_literal: true

require 'rails_helper'

feature 'Update User', type: 'request' do
  let(:updated_user) { build_stubbed :user }
  let!(:user) { create :user }
  let!(:existing_user) { create :user }

  it 'successfully update user with valid credentials' do
    put "/users",
    headers: auth_headers(user),
    params: {
      user: {
        name: updated_user.name
      }
    }
    json = JSON.parse(response.body)
    status = json['status']
    expect(status).to(eq('success'))
    user.reload
    data = json['data']
    expect(user.name).to(eq(updated_user.name))
    expect(user.email).to_not(eq(updated_user.email))
    expect(user.phone_number).to_not(eq(updated_user.phone_number))
  end

  it 'failed to update user with invalid credentials' do
    put "/users",
    headers: auth_headers(user),
    params: {
      user: {
        email: existing_user.email,
        name: '',
        phone_number: existing_user.phone_number,
      }
    }
    json = JSON.parse(response.body)
    status = json['status']
    expect(status).to(eq('error'))
    errors = json['errors']
    expect(errors['full_messages']).to(eq(
      [
        "Name can't be blank",
        "Email has already been taken",
        "Phone number has already been taken"
      ]
    ))
  end
end
