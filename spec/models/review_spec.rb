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



require 'spec_helper'

describe Review do
  it "add review" do
    apt = Apartment.add(1, "Nice Apartment!", "3001 Haste St", "100A", "Berkeley", "CA", 94704, "Great place!", 800, 1, 1)
    review1 = apt.reviews.add(1, 5, "This place is nice!")
    allReviews = Review.find_by_apt(apt.id)
    expect(allReviews.length).to eq(1)
  end

  it "FORBIDDEN add review" do
    apt = Apartment.add(1, "Pretty Apartment!", "2223 Dana St", "100A", "Berkeley", "CA", 94704, "Pretty place!", 620, 1, 1)
    review1 = apt.reviews.add(nil, 5, "")
    expect(review1).to eq(Review::FORBIDDEN)
  end

  it "update review" do
    apt = Apartment.add(1, "Legit Apartment!", "7777 Ellsworth St", "100A", "Berkeley", "CA", 94704, "Legit place!", 900, 1, 1)
    review1 = apt.reviews.add(1, 2, "This place is horrible!")
    review1.update(5, "This place is legit!")
    expect(review1.overall_rating).to eq(5)
    expect(review1.review).to eq("This place is legit!")
  end

  it "FORBIDDEN update review" do
    apt = Apartment.add(1, "Cool Apartment!", "1111 Dwight St", "100A", "Berkeley", "CA", 94704, "Cool place!", 777, 1, 1)
    review1 = apt.reviews.add(1, 5, "This place is cool!")
    update1 = review1.update(nil, "")
    expect(update1).to eq(Review::FORBIDDEN)
  end

  it "find reviews with find_by_apt by apartment_id" do
    apt1 = Apartment.add(1, "Beautiful Studio", "2402 Fulton St", "100A", "Berkeley", "CA", 94704, "Sid loves this place! :)", 1000, 1, 1)
    review1 = apt1.reviews.add(1, 5, "This place is awesome!")
    review2 = apt1.reviews.add(1, 2, "This place is aiteeee.")
    review3 = apt1.reviews.add(1, 5, "This place is grrreeatttt!")
    review4 = apt1.reviews.add(1, 4, "This place is cool!")
    allReviews = Review.find_by_apt(apt1.id)
    expect(allReviews.length).to eq(4)
  end

  it "new overall average rating by add_average_rating" do
    aar = Review.add_average_rating(9, 3, 10)
    expect(aar).to eq(3.7)
  end

  it "updated overall average rating by update_average_rating" do
    uar = Review.update_average_rating(10, 5, 9, 10)
    expect(uar).to eq(5.1)
  end

  it "test delete review" do
    apt = Apartment.add(1, "Home!", "3127 Parker St", "100A", "Berkeley", "CA", 94704, "cozy!", 500, 1, 1)
    review = apt.reviews.add(1, 5, "Great!")
    result = Review.delete(apt.user_id, review.apartment_id)
    expect(result).to be_a Review
  end

  it "test hasReview" do
    apt = Apartment.add(1, "Second Home!", "3127 Parker St", "100B", "Berkeley", "CA", 94704, "cool!", 600, 1, 1)
    apt_id = apt.id
    user_id = apt.user_id
    apt.reviews.add(user_id, 5, "Great!")
    reviewed = Review.hasReviewed(User.find(user_id) ,apt_id);
    expect(reviewed).to eq(true)
  end

  it "test update_rating_new" do
    apt = Apartment.add(1, "Third Home!", "1234 Cool Ave", "100B", "Berkeley", "CA", 94704, "cool!", 600, 1, 1)
    apt_id = apt.id
    user_id = apt.user_id
    review = apt.reviews.add(user_id, 5, "Great!")
    Review.update_rating_new(apt_id, review.id, 4)
    review = Review.find(review.id)
    expect(review.overall_rating).to eq(4)
  end
end
