# frozen_string_literal: true

module AuthHelpers
  def auth_headers(user)
    post("/users/sign_in/",
      params: {
        email: user.email,
        password: user.password,
      }, as: :json)
    response.headers.slice("client", "access-token", "uid")
  end
end

RSpec.configure do |config|
  config.include(AuthHelpers)
end
