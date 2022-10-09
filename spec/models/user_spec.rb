# frozen_string_literal: true
require 'rails_helper'

RSpec.describe(User, type: :model) do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:phone_number) }

  describe 'validate uniqueness of' do
    context 'email' do
      let!(:existing_user) { create(:user) }

      it do
        response = User.create(email: existing_user.email)
        expect(response.errors.messages[:email]).to(eq(["has already been taken"]))
      end
    end

    context 'phone_number' do
      let!(:existing_user) { create(:user) }

      it do
        response = User.create(phone_number: existing_user.phone_number)
        expect(response.errors.messages[:phone_number]).to(eq(["has already been taken"]))
      end
    end
  end
end