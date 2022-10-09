# frozen_string_literal: true

require 'rails_helper'

feature 'Update User Password', type: 'request' do
  let!(:user) { create :user }

  it 'successfully update user password with valid credentials' do
    put "/users/password",
    headers: auth_headers(user),
    params: {
      user: {
        password: 'newpassword',
        password_confirmation: 'newpassword'
      }
    }
    json = JSON.parse(response.body)
    status = json['success']
    expect(status).to(eq(true))
  end

  context 'fails to update user password with invalid credentials' do
    it 'password and password confirmation does not match' do
      put "/users/password",
      headers: auth_headers(user),
      params: {
        user: {
          password: 'newpassword',
          password_confirmation: 'oldpassword'
        }
      }
      json = JSON.parse(response.body)
      status = json['success']
      expect(status).to(eq(false))
      errors = json['errors']['full_messages']
      expect(errors).to(eq(
        ["Password confirmation doesn't match Password"]
      ))
    end

    it 'password confirmation is not parsed' do
      put "/users/password",
      headers: auth_headers(user),
      params: {
        user: {
          password: 'newpassword',
        }
      }
      json = JSON.parse(response.body)
      status = json['success']
      expect(status).to(eq(false))
      errors = json['errors']
      expect(errors).to(eq(
        ["You must fill out the fields labeled 'Password' and 'Password confirmation'."]
      ))
    end
  end
end
