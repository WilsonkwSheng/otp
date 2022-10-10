# frozen_string_literal: true

module Users
  class RegistrationsController < DeviseTokenAuth::RegistrationsController
    private

    def sign_up_params
      params.require(:user).permit(:email, :password, :name, :phone_number)
    end

    def account_update_params
      params.require(:user).permit(:email, :name, :phone_number)
    end
  end
end
