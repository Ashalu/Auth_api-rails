class User < ApplicationRecord
  devise :two_factor_authenticatable,
         :otp_secret_encryption_key => ENV['1f50929bda00e4b8fe2f5fd9aa901740a902dea332c5f618497c996c8c50f4b1ee79d253959103eb84592b755732960f9a36616a61beef55a11ecc32ff2934c6']

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :registerable,
         :recoverable, :rememberable, :validatable
  has_many :api_tokens
  has_one_time_password
  enum otp_module: {disabled: 0,enabled: 1},_prefix: true
  attr_accessor :otp_code_token

  def generate_token
  	Digest::SHA1.hexdigest([DateTime.now, rand].join)
  end
end
