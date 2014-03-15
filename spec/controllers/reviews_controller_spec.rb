require 'spec_helper'
require 'pp'

describe ReviewsController do

  before(:each) do
    #login_user  
    @user = FactoryGirl.create(:user)
    @apartment = FactoryGirl.create(:apartment)
    subject.sign_in @user
    #FactoryGirl.create(:apartment).should be_valid
  end

  after(:each) do
    subject.sign_out @user if subject.current_user
    @user.destroy
    @apartment.destroy
  end

  describe "POST #create" do
    it "successfully adds new review page" do
      num = Apartment.find(@apartment.id).reviews.length
      pp "000000000000000000000   " + num.to_s
      post :create, id: 1, overall_rating: 5, review: "beautiful place!"
      # post :create, user_id: @user.id, id: @apartment.id, overall_rating: 5, review: "beautiful place!"
      # @apartment.reviews.add(@user.id, 5, "great place")
      # post :create, review: FactoryGirl.attributes_for(:review), id: 1
      pp "000000000000000000000   " + num.to_s
      new_num = Apartment.find(@apartment.id).reviews.length
      pp "1111111111111111111111   " + new_num.to_s + " " + num.to_s
      expect(new_num).to equal(num+1)
      # expect { post :create, review: FactoryGirl.attributes_for(:review)}.to change(Review, :count).by(1)

    end
  end

  # describe "POST #create" do
  #   it "successfully adds new review page" do
  #     expect { post :create, id: 1, overall_rating: 5, review: "beautiful place!"}.to change(Review, :count).by(1)
  #   end
  # end

  # describe "GET #create" do
  #   it "successfully adds new review page" do
  #     expect { get :create, review: FactoryGirl.attributes_for(:review)}.to change(Review, :count).by(1)
  #   end
  # end

  # describe "POST #update" do
  #   it "successfully updates review page" do
  #     post :create, review: FactoryGirl.attributes_for(:review)
  #     response.should redirect_to Review.last 
  #   end

  #   it "does not update review page with bad info" do
  #     FactoryGirl.create(:review)
  #     post :update, review: FactoryGirl.attributes_for(:review)
  #     response.should_not redirect_to Review.last 
  #   end  
  # end

  # describe "GET #find_by_apt" do
  #   it "returns http success" do
  #     get 'find_by_apt'
  #     expect(response).to be_success
  #   end
  # end

end
