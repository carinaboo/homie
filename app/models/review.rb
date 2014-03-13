class Review < ActiveRecord::Base
  ERROR = -1
  BAD_USERNAME = -2
  BAD_PASSWORD = -3
  BAD_EMAIL = -4
  BAD_CREDENTIALS = -5
  FORBIDDEN = 403
  PAGE_NOT_FOUND = 404

  validates :user_id, presence: true
  validates :apt_id, presence: true
  validates :overall_rating, presence: true
  validates :review, presence: true

  def self.add(user_id, apt_id, overall_rating, review)
    review = self.new(user: user_id, apartment: apt_id, overall_rating: overall_rating, review: review)
    if review.valid?
      review.
          end

      total = num_of_reviews * average_review + params[:overall_rating]
      num_of_reviews += 1
      new_average = total / num_of_reviews
    end

    def self.update(user_id, apt_id, overall_rating, review)


      total = num_of_reviews * average_review + params[:overall_rating]
      num_of_reviews += 1
      new_average = total / num_of_reviews
    end

    def self.find_by_apt(apt_id)

    end