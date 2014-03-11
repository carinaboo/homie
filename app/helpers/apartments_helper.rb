module ApartmentsHelper
  def can_review?(apt_reviews)
    if current_user
      user_reviews = Review.where(:user_id => current_user.id)
      past_review = apt_reviews & user_reviews
      return true if !past_review
    end
    return false
  end
end
