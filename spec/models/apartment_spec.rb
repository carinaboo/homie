require 'spec_helper'

describe Apartment do
  #pending "add some examples to (or delete) #{__FILE__}"
  before do
	@valid_apt = Apartment.add(1, "apt1", "addr1", "desc1", 1000, 1, 1)	
	@bad_apt = Apartment.add(nil, "apt2", "addr2", "desc2", 1000, 1, 1)
  	@apartment = Apartment.find_by_user_id(1)
  end

  describe "new apartment" do
  	it "can only be added by logged in user" do	
	 	expect(@valid_apt.is_a? Apartment).to (eq true)
  	end

  	it "cannot be added by user not logged in" do
	 	expect(@bad_apt).to (eq Apartment::FORBIDDEN)
  	end

	it "testAddUserId" do
	  expect(@apartment.user_id).to (eq 1)
	end

	it "testAddTitle" do
	  expect(@apartment.title).to (eq "apt1")
	end

	it "testAddAddress" do
	  expect(@apartment.address).to (eq "addr1")
	end	

	it "testAddDescription" do
	  expect(@apartment.description).to (eq "desc1")
	end  

	it "testAddPrice" do
	  expect(@apartment.price).to (eq 1000)
	end 

	it "testAddBathroom" do
	  expect(@apartment.bathrooms).to (eq 1)
	  end   

	it "testAddBedrooms" do
	  expect(@apartment.bedrooms).to (eq 1)
	end  
   end

   describe "failing update and search for apartment" do
	  before do
		@result = @apartment.updateDescription(nil, "apt2", "addr2", "desc2", 2000, 2, 2)
	  end

	  it "testUpdateId" do
	  	expect(@result).to (eq Apartment::FORBIDDEN)
	  end
   end

	describe "update and search for apartment" do
	  before do
		@apartment.updateDescription(2, "apt2", "addr2", "desc2", 2000, 2, 2)
	  end

	  it "testUpdateId" do
	  	expect(@apartment.user_id).to (eq 2)
	  end

	  it "testUpdateTitle" do
	  	expect(@apartment.title).to (eq "apt2")
	  end

	  it "testUpdateAddress" do
	  	expect(@apartment.address).to (eq "addr2")
	  end	

	  it "testUpdateDescription" do
	  	expect(@apartment.description).to (eq "desc2")
	  end  

	  it "testUpdatePrice" do
	  	expect(@apartment.price).to (eq 2000)
	  end 

	  it "testUpdateBathroom" do
	  	expect(@apartment.bathrooms).to (eq 2)
	  end   

	  it "testUpdateBedrooms" do
	  	expect(@apartment.bedrooms).to (eq 2)
	  end

	  it "test search with valid address" do
	  	result = Apartment.search("addr2")
	  	expect(result.first.address).to (eq "addr2")
	  end

	  it "test search with invalid address" do
	  	result = Apartment.search("addr1")
	  	expect(result).to (eq [])
	  end	

	  it "test search with nil passed in" do
	  	result = Apartment.search(nil)
	  	expect(result).to (eq [])
	  end 
	end
end
