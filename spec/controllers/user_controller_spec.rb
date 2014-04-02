require 'spec_helper'

describe UsersController do
	describe "GET #show" do
    it "assigns requested user to @user" do
      #subject.sign_in FactoryGirl.create(:user)
      user = FactoryGirl.create(:user)
      subject.sign_in user
      get :show, id: user
      assigns(:user).should eq(user)
    end

    it "renders #show view" do
      	user = FactoryGirl.create(:user)
      	subject.sign_in user
      	get :show, id: user
        response.should render_template :show
    end

    it "renders forbidden #show view" do
        user = FactoryGirl.create(:user)
        get :show, id: user
        assigns(:user).should eq(nil)
    end
  end
end
