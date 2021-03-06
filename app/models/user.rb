class User < ActiveRecord::Base
	has_secure_password

	before_save :create_remember_token

	# before_create { |user| user.email.downcase! }   or is it before_save? 
	# before_create :create_remember_token

	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence:   true,
	          		  format:     { with: VALID_EMAIL_REGEX },
	          		  uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: { minimum: 6 }
						 confirmation: true
	validates :password_confirmation, presence: true


	private

	def create_remember_token
		self.remember_token = SecureRandom.urlsafe_base64
	end
end
