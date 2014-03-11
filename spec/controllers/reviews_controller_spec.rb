require 'spec_helper'

describe ReviewsController do

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
