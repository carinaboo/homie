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

  describe "POST #create" do
    it "not logged in user tries to add new review" do
      subject.sign_out @user
      expect { post :create, review: {apartment_id: @apartment.id, overall_rating: 5, review: "This place is the best"}}.to change(Review, :count).by(0)
    end

    it "successfully adds new review page" do
      expect { post :create, review: {apartment_id: @apartment.id, overall_rating: 5, review: "This place is the best"}}.to change(Review, :count).by(1)
    end
  end

  describe "GET #edit and #update" do

    before(:each) do
      post :create, review: {apartment_id: @apartment.id, overall_rating: 5, review: "This place is the best"}
      @review = @apartment.reviews.first
    end

    after(:each) do
      @review.destroy
    end

    it "successfully loads edit page" do
      get :edit, id: @review.id
      response.should render_template :edit
    end 

    it "successfully loads edit page" do
      get :edit, id: 100000
      response.should render_template :root_path
    end   

    it "successfully updates review page" do
      put :update, id: @review.id, review: FactoryGirl.attributes_for(:review)
      response.should redirect_to apartment_path id: @apartment.id
    end

    it "does not update review page with wrong user" do
      subject.sign_out @user
      @user2 = FactoryGirl.create(:user, email: "differentuser@berkeley.edu")
      subject.sign_in @user2
      put :update, id: @review.id, review: FactoryGirl.attributes_for(:review)
      response.should_not redirect_to apartment_path id: @apartment.id
      subject.sign_in @user
    end  

  end

  describe "GET #find_by_apt" do
    it "returns json of reviews" do
      post :create, review: {apartment_id: @apartment.id, overall_rating: 5, review: "Great place"}
      get 'find_by_apt', apt_id: @apartment.id
      response.body.should == @apartment.reviews.to_json
    end
  end

  describe "DELETE #delete" do
    before(:each) do
      post :create, review: {apartment_id: @apartment.id, overall_rating: 5, review: "This place is the best"}
      @review = @apartment.reviews.first
    end

    after(:each) do
      @review.destroy
    end

    it "should not delete if user not logged in" do
      subject.sign_out @user
      delete :delete, id: @review.id, review: FactoryGirl.attributes_for(:review)
      response.should redirect_to apartment_path id: @apartment.id
    end

    it "should not delete if wrong user" do
      subject.sign_out @user
      @user2 = FactoryGirl.create(:user, email: "differentuser@berkeley.edu")
      subject.sign_in @user2
      delete :delete, id: @review.id, review: FactoryGirl.attributes_for(:review)
      response.should redirect_to apartment_path id: @apartment.id
    end  

    it "successfully deletes Reviews" do
      delete :delete, id: @review.id, review: FactoryGirl.attributes_for(:review)
      response.should redirect_to apartment_path id: @apartment.id
    end
  end 

end
