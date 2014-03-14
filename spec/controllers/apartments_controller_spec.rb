require 'spec_helper'
require 'factory_girl_rails'

describe ApartmentsController do
  before(:each) do
    #login_user  
    @user = FactoryGirl.create(:user)
    subject.sign_in @user
    #FactoryGirl.create(:apartment).should be_valid
  end

  after(:each) do
    subject.sign_out @user
    @user.destroy
  end

  describe "GET #show" do
    it "assigns requested apartment to @apartment" do
      #subject.sign_in FactoryGirl.create(:user)
      apartment = FactoryGirl.create(:apartment)
      get :show, id: apartment
      assigns(:apartment).should eq(apartment)
    end

    it "renders #show view" do
      get :show, id: FactoryGirl.create(:apartment)
      response.should render_template :show
    end
  end

=begin
  describe "new" do
    it "returns http success" do
      get 'new'
      expect(response).to be_success
    end
  end

  describe "create" do
    #it "returns http success" do
      #get 'create'
      #expect(response).to be_success
    end
  end

  describe "edit" do
    it "returns http success" do
      get 'edit'
      expect(response).to be_success
    end
  end

  describe "update" do
    it "returns http success" do
      get 'update'
      expect(response).to be_success
    end
  end

  describe "search" do
    it "returns http success" do
      get 'search'
      expect(response).to be_success
    end
  end
=end

end
