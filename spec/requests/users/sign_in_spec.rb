# frozen_string_literal: true

require "rails_helper"

feature "Sign In User", type: "request" do
  let(:user) { create :user }

  it "successfully signed in with valid credentials" do
    post "/users/sign_in",
      params: {
        email: user.email,
        password: user.password,
      }
    header = response.headers.slice("client", "access-token", "uid")
    expect(header).to(include(
      "client" => be_present,
      "access-token" => be_present,
      "uid" => be_present,
    ))
    json = JSON.parse(response.body)
    data = json["data"]
    expect(data["email"]).to(eq(user.email))
    expect(data["provider"]).to(eq("email"))
    expect(data["uid"]).to(eq(user.email))
    expect(data["id"]).to(eq(user.id))
    expect(data["name"]).to(eq(user.name))
    expect(data["phone_number"]).to(eq(user.phone_number))
  end

  it "failed to signed in with invalid credentials" do
    post "/users/sign_in",
      params: {
        email: user.email,
        password: "incorrect passwords",
      }
    header = response.headers.slice("client", "access-token", "uid")
    expect(header).to(eq({}))
    json = JSON.parse(response.body)
    status = json["success"]
    expect(status).to(eq(false))
    errors = json["errors"]
    expect(errors).to(eq([
      "Invalid login credentials. Please try again.",
    ]))
  end
end
