class Review < ActiveRecord::Base
	ERROR = -1
	BAD_USERNAME = -2
	BAD_PASSWORD = -3
	BAD_EMAIL = -4
	BAD_CREDENTIALS = -5
	FORBIDDEN = 403
	PAGE_NOT_FOUND = 404
	
	def self.create(user_id, apt_id, overall_rating, review)
		
end
