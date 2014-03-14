require 'spec_helper'

describe Review do
  it "find reviews by apartment_id" do
    apt1 = Apartment.add(1, "Beautiful Studio", "2402 Fulton St", "Sid loves this place! :)", 1000, 1, 1)
    review1 = apt1.reviews.add(1, 5, "This place is awesome!")
    review2 = apt1.reviews.add(1, 5, "This place is aiteeee.")
    allReviews = Review.find_by_apt(apt1.id)
    expect(allReviews.length).to eq(2)
  end
end
