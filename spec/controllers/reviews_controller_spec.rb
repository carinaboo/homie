require 'spec_helper'

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

  # describe "POST #create" do
  #   it "successfully adds new review page" do
  #     num = Apartment.find(@apartment.id).reviews.length
  #     post :create, user_id: @user.id, 
  #     @apartment.reviews.add(@user.id, 5, "great place")
  #     expect(Apartment.find(@apartment.id).reviews.length).to equal(num+1)
  #   end
  # end
  
  describe "GET #create" do
    it "successfully adds new review page" do
      expect { get :create, review: FactoryGirl.attributes_for(:review)}.to change(Review, :count).by(1)
    end
  end

  describe "POST #update" do
    it "successfully updates review page" do
      post :create, review: FactoryGirl.attributes_for(:review)
      response.should redirect_to Review.last 
    end

    it "does not update review page with bad info" do
      FactoryGirl.create(:review)
      post :update, review: FactoryGirl.attributes_for(:review)
      response.should_not redirect_to Review.last 
    end  
  end

  describe "GET #find_by_apt" do
    it "returns http success" do
      get 'find_by_apt'
      expect(response).to be_success
    end
  end

end
