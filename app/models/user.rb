class User < ActiveRecord::Base
	belongs_to :band

	validates_format_of :email, with: /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i
	validates_format_of :role, inclusion: { in %w[member manager admin] }

	has_secure_password

	def proper_name
    	first_name + " " + last_name
	end

	def self.authenticate(email,password)
    	find_by_email(email).try(:authenticate, password)
	end
end
