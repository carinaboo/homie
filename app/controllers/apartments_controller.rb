class ApartmentsController < ApplicationController
  include ApartmentsHelper

  SUCCESS = 1
  FORBIDDEN = 403
  PAGE_NOT_FOUND = 404

  #Loads the apartment profile page with reviews. Provides user with option to add reviews
  #if the user is logged in and hasn't already added a review.
  def show
    @apartment = Apartment.find(params[:id])
    @reviews =  Review.find_by_apt(params[:id]) 
    @review = Review.new
    @reviewed = Review.hasReviewed(current_user, params[:id])
    @user_id = current_user.id
    #boolean value used in view to decide whether user can add new review
    # @show_form = can_review?(@reviews)        #method from ApartmentsHelper
  end

  #Page for creating new apartment profile.
  def new
    @apartment = Apartment.new
    if !current_user
      flash[:error] = "You must be logged in to create new apartment profile"
      redirect_to root_path
    end
  end

  #Creates and saves new apartment profile if information is valid; otherwise reloads page for
  #creating new profiles.
  def create
    user_id = current_user.id
    title = params[:apartment][:title]
    street_address = params[:apartment][:street_address]
    apartment_number = params[:apartment][:apartment_number]
    city = params[:apartment][:city]
    state = params[:apartment][:state]
    zip = params[:apartment][:zip]
    desc = params[:apartment][:description]
    price = params[:apartment][:price]
    beds = params[:apartment][:bedrooms]
    baths = params[:apartment][:bathrooms]
    @apartment = Apartment.add(user_id, title, street_address, apartment_number, city, state, zip, desc, price, beds, baths)
    if @apartment.valid?
      redirect_to @apartment
    else
      render "new"
    end
  end

  #Page for editing apartment profile information.
  def edit
    @apartment = Apartment.find(params[:id])
    if !@apartment
      flash[:error] = "Error: Apartment page not found\n"
      redirect_to root_path
    elsif !current_user
      flash[:error] = "Error: user must be signed in to edit\n"
      redirect_to @apartment
    elsif @apartment.user_id != current_user.id
      flash[:error] = "Error: only the owner is allowed to edit\n"
      redirect_to @apartment
    end
  end

  #Saves updates to apartment profile if changes are valid; otherwise reload edit page.
  def update
    @apartment = Apartment.find(params[:id])
    user_id = current_user.id
    title = params[:apartment][:title]
    street_address = params[:apartment][:street_address]
    apartment_number = params[:apartment][:apartment_number]
    city = params[:apartment][:city]
    state = params[:apartment][:state]
    zip = params[:apartment][:zip]
    description = params[:apartment][:description]
    price = params[:apartment][:price]
    beds = params[:apartment][:bedrooms]
    baths = params[:apartment][:bathrooms]
    result = @apartment.update(user_id, title, street_address, apartment_number, city, state, zip, description, price, beds, baths)
    if result.is_a? Apartment
      redirect_to @apartment
    else 
      render "edit"
    end
  end

  #Searches for apartment listings
  def search
    # @apartments = Apartment.all
    sort = params[:sorting]

    min_price = params[:min_price]
    max_price = params[:max_price]

    min_rating = params[:min_rating]

    min_bedrooms = params[:min_bedrooms]
    max_bedrooms = params[:max_bedrooms]
    
    min_bathrooms = params[:min_bathrooms]
    max_bathrooms = params[:max_bathrooms]
    
    @apartments = Apartment.search(params[:search], sort, min_price, max_price, min_rating, min_bedrooms, max_bedrooms, min_bathrooms, max_bathrooms)
    @max_price = Apartment.maximum("price") || 5000
    @max_bedrooms = Apartment.maximum("bedrooms") || 6
    @max_bathrooms = Apartment.maximum("bathrooms") || 6
  end

  def destroy
    @apartment = Apartment.find(params[:id])
    print "destroy apartment"
    if !@apartment
      p "no apartment"
      flash[:error] = "Error: Apartment page not found\n"
      redirect_to root_path
    elsif !current_user
      p "not signed in"
      flash[:error] = "Error: user must be signed in to delete apartment\n"
      redirect_to @apartment
    elsif @apartment.user_id != current_user.id
      p "not owner"
      flash[:error] = "Error: only the owner is allowed to delete apartment\n"
      redirect_to @apartment
    else
      print "successful"
      @apartment.delete()
      redirect_to root_path
    end
  end
 
end
