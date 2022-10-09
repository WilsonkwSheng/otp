# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable
  include DeviseTokenAuth::Concerns::User

  validates :name, :phone_number, presence: true
  validates :email, presence: true, uniqueness: true, format: Devise.email_regexp, on: :update
  validates :phone_number, uniqueness: true
  validates_confirmation_of :password
end
