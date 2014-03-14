require 'spec_helper'
require 'factory_girl_rails'

describe ApartmentsController do
=begin
  before(:each) do
    FactoryGirl.create(:apartment).should be_valid
  end
=end
  describe "#show" do
    it "assigns requested apartment to @apartment" do
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
