require 'spec_helper'

describe User do
  #pending "add some examples to (or delete) #{__FILE__}"
 
  it "should create new user" do
  	expect(FactoryGirl.create(:user).is_a? User).to (eq true)
  end
end