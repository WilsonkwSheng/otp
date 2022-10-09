module Users
  class PasswordsController < DeviseTokenAuth::PasswordsController
    private

    def password_resource_params
      params.require(:user).permit(:password, :password_confirmation)
    end
  end
end
