class ApartmentsController < ApplicationController
  include ApartmentsHelper

  SUCCESS = 1
  FORBIDDEN = 403
  PAGE_NOT_FOUND = 404

  #Loads the apartment profile page with reviews. Provides user with option to add reviews
  #if the user is logged in and hasn't already added a review.
  def show
    @apartment = Apartment.find(params[:id])
    @reviews = Review.where(apartment_id: @apartment.id)
    #boolean value used in view to decide whether user can add new review
    @show_form = can_review?(@reviews)        #method from ApartmentsHelper
  end

  #Page for creating new apartment profile.
  def new
    if current_user
      @apartment = Apartment.new
    else
      render json: {errCode: FORBIDDEN}
    end
  end

  #Creates and saves new apartment profile if information is valid; otherwise reloads page for
  #creating new profiles.
  def create
    user_id = current_user.id
    title = params[:apartment][:title]
    addr = params[:apartment][:address]
    desc = params[:apartment][:description]
    price = params[:apartment][:price]
    beds = params[:apartment][:bedrooms]
    baths = params[:apartment][:bathrooms]
    result = Apartment.add(user_id, title, addr, desc, price, beds, baths)
    #valid = result >= 0 && result != 403 && result != 404
    if result.is_a? Apartment
      redirect_to :action => "show", :id => result.id
    else
      render json: {errCode: result}
    end
  end

  #Page for editing apartment profile information.
  def edit
    @apartment = Apartment.find(params[:id])
    if !@apartment
      render json: {errCode: PAGE_NOT_FOUND}
    elsif !current_user
      render json: {errCode: FORBIDDEN}
    end
  end

  #Saves updates to apartment profile if changes are valid; otherwise reload edit page.
  def update
    @apartment = Apartment.find(params[:id])
    user_id = current_user.id
    title = params[:apartment][:title]
    addr = params[:apartment][:address]
    desc = params[:apartment][:description]
    price = params[:apartment][:price]
    beds = params[:apartment][:bedrooms]
    baths = params[:apartment][:bathrooms]
    result = Apartment.updateDescription(user_id, title, addr, desc, price, beds, baths)
    #valid = result >= 0 && result != 403 && result != 404
    render json: {errCode: result}
  end

  def search
    @apartments = Apartment.search params[:search]
  end
 
end
