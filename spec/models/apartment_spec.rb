# == Schema Information
#
# Table name: apartments
#
#  id                     :integer          not null, primary key
#  title                  :string(255)
#  description            :text
#  price                  :float
#  bathrooms              :float
#  bedrooms               :float
#  average_overall_rating :float
#  created_at             :datetime
#  updated_at             :datetime
#  user_id                :integer
#  street_address         :string(255)
#  apartment_number       :string(255)
#  city                   :string(255)
#  state                  :string(255)
#  zip                    :integer
#  photo_file_name        :string(255)
#  photo_content_type     :string(255)
#  photo_file_size        :integer
#  photo_updated_at       :datetime
#

require 'spec_helper'

describe Apartment do
  #pending "add some examples to (or delete) #{__FILE__}"
  before do
  @valid_apt = Apartment.add(1, "apt1", "addr1", "apt#", "city", "state", 94704, "desc1", 1000, 1, 1)
  @bad_apt = Apartment.add(nil, "apt2", "addr2", "apt#2", "city2", "state2", 94704, "desc2", 1000, 1, 1)
    @apartment = Apartment.find_by_user_id(1)
  end

  describe "new apartment" do
    it "can only be added by logged in user" do
    expect(@valid_apt.valid?).to (eq true)
    end

    it "cannot be added by user not logged in" do
    expect(@bad_apt.valid?).to (eq false)
    end

  it "testAddUserId" do
    expect(@apartment.user_id).to (eq 1)
  end

  it "testAddTitle" do
    expect(@apartment.title).to (eq "apt1")
  end

  it "testAddStreetAddress" do
    expect(@apartment.street_address).to (eq "addr1")
  end

  it "testAddApartmentNumber" do
    expect(@apartment.apartment_number).to (eq "apt#")
  end

  it "testAddCity" do
    expect(@apartment.city).to (eq "city")
  end

  it "testAddState" do
    expect(@apartment.state).to (eq "state")
  end

  it "testAddZip" do
    expect(@apartment.zip).to (eq 94704)
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
    @result = @apartment.update(nil, "apt2", "addr2", "apt#2", "city2", "state2", 94704, "desc2", 2000, 2, 2)
    end

    it "testUpdateId" do
      expect(@result).to (eq Apartment::FORBIDDEN)
    end
   end

   describe "update and search for apartment" do
    before do
      @apartment.update(2, "apt2", "addr2", "apt#2", "city2", "state2", 94703, "desc2", 2000, 2, 2)
      @apartment1 = Apartment.add(2, "apt1", "addr1", "apt#1", "city2", "state2", 94703, "desc2", 2000, 2, 2)
      @new_apt = Apartment.add(3, "apt3", "addr3", "apt#3", "city2", "state", 94704, "desc1", 1000, 1, 1)
      review1 = @apartment1.reviews.add(2, 5, "hjk")
      @apartment1.average_overall_rating = 5
      @apartment1.save
      review2 = @new_apt.reviews.add(2, 1, "wertyui")
      @new_apt.average_overall_rating = 5
      @new_apt.save
    end

    it "testUpdateId" do
      expect(@apartment.user_id).to (eq 2)
    end

    it "testUpdateTitle" do
      expect(@apartment.title).to (eq "apt2")
    end

    it "testUpdateAddress" do
      expect(@apartment.street_address).to (eq "addr2")
    end

    it "testUpdateApartmentNumber" do
      expect(@apartment.apartment_number).to (eq "apt#2")
    end

    it "testUpdateCity" do
      expect(@apartment.city).to (eq "city2")
    end

    it "testUpdateState" do
      expect(@apartment.state).to (eq "state2")
    end

    it "testUpdateZip" do
      expect(@apartment.zip).to (eq 94703)
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
      result = Apartment.search("addr1", "Ratings: low to high", nil, 9999, 0, 0, 10, 1, 10)
      puts result
      expect(result.first.street_address).to (eq "addr1")
    end

    it "test search with valid address and sort price from high to low" do
      result = Apartment.search("city2", "Price: high to low", 0, 9999, 0, 0, 10, 1, 10)
      expect(result.first.street_address).to (eq "addr1")
    end

    it "test search with valid address and sort price from low to high" do
      result = Apartment.search("city2", "Price: low to high", 0, 9999, 0, 0, 10, 1, 10)
      expect(result.first.street_address).to (eq "addr3")
    end

    it "test search with valid address and sort ratings from high to low" do
      result = Apartment.search("city2", "Ratings: high to low", 0, 9999, 0, 0, 10, 1, 10)
      expect(result.first.street_address).to (eq "addr1")
    end

    it "test search with valid address and sort ratings from low to high" do
      result = Apartment.search("city2", "Ratings: low to high", 0, 9999, 0, 0, 10, 1, 10)
      expect(result.first.street_address).to (eq "addr1")
    end

    it "test search with valid address and default sorting" do
      result = Apartment.search("city2", nil, 0, 9999, 0, 0, 10, 1, 10)
      expect(result.first.street_address).to (eq "addr1")
    end


    it "test search with invalid address" do
      result = Apartment.search("addrghjkl", "Ratings: high to low", 0, 9999, 0, 0, 10, 1, 10)
      expect(result).to (eq [])
    end

    it "test search with nil passed in" do
      result = Apartment.search(nil, nil, 0, 9999, 0, 0, 10, 1, 10)
      expect(result).to (eq [])
    end

    it "test search with city" do
      result = Apartment.search("city2", "Ratings: low to high", 0, 9999, 0, 0, 10, 1, 10)
      expect(result.first.city).to (eq "city2")
    end

    it "test search with state" do
      result = Apartment.search("", "Ratings: low to high", 0, 9999, 0, 0, 10, 1, 10)
      expect(result.first.state).to (eq "state2")
    end

  end

  describe "delete apartment" do
    it "test delete with valid address" do
      expect(@apartment.delete).to be_a Apartment
    end
  end

  describe "parsePrice to remove '$'', ','', '_'" do
    it "tests parse price " do
      p = Apartment.parsePrice("$1,000")
      expect(p).to (eq 1000) 

end
