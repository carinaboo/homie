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
    subject.sign_out @user if subject.current_user
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

  describe "GET #new" do
    it "should render #new for logged in user" do
      get :new
      response.should render_template :new
    end

    it "should not render #new if user not logged in" do
      subject.sign_out @user
      get :new
      response.should_not render_template :new
    end
  end

  describe "POST #create" do
    it "successfully adds new apartment page" do
      expect { post :create, apartment: FactoryGirl.attributes_for(:apartment)}.to change(Apartment, :count).by(1)
    end

    it "successfully redirects to new apartment page" do
      post :create, apartment: FactoryGirl.attributes_for(:apartment)
      response.should redirect_to Apartment.last
    end

    it "does not add invalid/duplicate apartment page" do  
      FactoryGirl.create(:apartment)
      expect { post :create, apartment: FactoryGirl.attributes_for(:apartment)}.to change(Apartment, :count).by(0)
    end

    it "should not redirect to new apartment page for bad input" do
      FactoryGirl.create(:apartment)
      post :create, apartment: FactoryGirl.attributes_for(:apartment)
      response.should_not redirect_to Apartment.last
    end
  end

  describe "GET #edit" do
    it "successfully loads edit page" do
      get :edit
      response.should render_template :edit
    end

    it "should not load edit page if user not logged in" do
      subject.sign_out @user
      get :edit
      response.should_not render_template :edit
    end
  end

  describe "POST #update" do
    
  end 

  describe "POST #search" do

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
