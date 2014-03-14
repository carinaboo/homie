require 'spec_helper'

describe ReviewsController do

  before(:each) do
    #login_user  
    @user = FactoryGirl.create(:user)
    subject.sign_in @user
    #FactoryGirl.create(:apartment).should be_valid
  end

  after(:each) do
    subject.sign_out @user if subject.current_user
    @user.destroy
  end
  
  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      expect(response).to be_success
    end
  end

  describe "GET 'update'" do
    it "returns http success" do
      get 'update'
      expect(response).to be_success
    end
  end

  describe "GET 'find_by_apt'" do
    it "returns http success" do
      get 'find_by_apt'
      expect(response).to be_success
    end
  end

end
