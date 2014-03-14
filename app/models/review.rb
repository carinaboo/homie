class Review < ActiveRecord::Base

  SUCCESS = 1
  FORBIDDEN = 403

  validates :user_id, presence: true
  validates :apt_id, presence: true
  validates :overall_rating, presence: true
  validates :review, presence: true

  def self.add(user_id, apt_id, overall_rating, review)
    # adds a review to the database
    review = self.new(user_id: user_id, apt_id: apt_id, overall_rating: overall_rating, review: review)
    # checks there is an input for each field
    if review.valid?
      review.save
      return SUCCESS
    else
      return FORBIDDEN
    end
  end

  def update(overall_rating, review)
    # updates the overall_rating and review text
    valid = self.update_attributes(overall_rating: overall_rating, review: review)
    return SUCCESS if valid
    return FORBIDDEN
  end

  def self.find_by_apt(apt_id)
    # returns all the reviews for corresponding apt_id
    apartment = Apartment.find(apt_id) # can call Apartment model because of has belong relationship
    return apartment.Reviews
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
    new_average = total / num_of_reviews
    return new_average
  end

  def self.update_average_rating(num_of_reviews, average_review, old_overall_rating, new_overall_rating)
    # updates the overall_average_rating when an existing review is updated
    total = num_of_reviews * average_review - old_overall_rating + new_overall_rating
    new_average = total / num_of_reviews
    return new_average
  end

end