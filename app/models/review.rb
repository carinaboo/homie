# == Schema Information
#
# Table name: reviews
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  review         :text
#  overall_rating :integer
#  created_at     :datetime
#  updated_at     :datetime
#  apartment_id   :integer
#

class Review < ActiveRecord::Base
  belongs_to :apartment, class_name: 'Apartment', foreign_key: 'apartment_id'
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'

  SUCCESS = 1
  FORBIDDEN = 403

  validates :user_id, presence: true
  validates :apartment_id, presence: true
  validates :overall_rating, presence: true
  # validates :review, presence: true

  def self.add(user_id, overall_rating, review)
    # adds a review to the database
    review = new(user_id: user_id, overall_rating: overall_rating, review: review)
    # checks there is an input for each field
    #if review.valid?
     # review.save
      #return review
    #else
    return review if review.save
      return FORBIDDEN
    #end
  end

  def update(overall_rating, review)
    # updates the overall_rating and review text
    valid = self.update_attributes(overall_rating: overall_rating, review: review)
    return SUCCESS if valid
    return FORBIDDEN
  end

  def self.find_by_apt(apartment_id)
    # returns all the reviews for corresponding apt_id
    apartment = Apartment.find(apartment_id) # can call Apartment model because of has belong relationship
    return apartment.reviews
    #review_array = Array.new
    #Review.all.each do |r| #reviews with s?
    #if r.apt_id == apt_id
    #review_array.push(r)
    #end
    #end
    #return review_array
  end

  def self.add_average_rating(num_of_reviews, average_review, overall_rating)
    # updates the overall_average_rating when a new review is added
    total = num_of_reviews * average_review + overall_rating
    num_of_reviews += 1
    new_average = Float(total)/ num_of_reviews
    return new_average
  end

  def self.update_average_rating(num_of_reviews, average_review, old_overall_rating, new_overall_rating)
    # updates the overall_average_rating when an existing review is updated
    total = num_of_reviews * average_review - old_overall_rating + new_overall_rating
    new_average = Float(total) / num_of_reviews
    return new_average
  end

end
