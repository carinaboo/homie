class Review < ActiveRecord::Base

  SUCCESS = 1
  FORBIDDEN = 403

  validates :user_id, presence: true
  validates :apt_id, presence: true
  validates :overall_rating, presence: true
  validates :review, presence: true

  def self.add(user_id, apt_id, overall_rating, review)
    review = self.new(user: user_id, apartment: apt_id, overall_rating: overall_rating, review: review)
    if review.valid?
      review.save
      return SUCCESS
    else
      return FORBIDDEN
    end
  end

    def self.update(review_id, overall_rating, review)
      apt_reviews = self.find(review_id) #check find_by_review
      if apt_reviews
        apt_reviews.overall_rating = overall_rating
        apt_reviews.review = review
        apt_reviews.save
        return SUCCESS
      else
        return FORBIDDEN
      end
    end

    def self.find_by_apt(apt_id)
      review_array = Array.new
      Review.all.each do |r| #reviews with s?
        if r.apt_id == apt_id
          review_array.push(r)
        end
      end
      return review_array
      #apartment = Apartment.find(apt_id) #can't call apartment model here
      #return apartment.Reviews
    end

    def self.add_average_rating(num_of_reviews, average_review, overall_rating)
      total = num_of_reviews * average_review + overall_rating
      num_of_reviews += 1
      new_average = total / num_of_reviews
      return new_average
    end

  def self.update_average_rating(num_of_reviews, average_review, old_overall_rating, new_overall_rating)
    total = num_of_reviews * average_review - old_rating + new_rating
    new_average = total / num_of_reviews
    return new_average
  end

  end