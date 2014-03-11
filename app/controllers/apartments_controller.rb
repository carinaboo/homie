class ApartmentsController < ApplicationController
  include ApartmentsHelper

  #Loads the apartment profile page with reviews. Provides user with option to add reviews
  #if the user is logged in and hasn't already added a review.
  def view
    @apartment = Apartment.find(params[:id])
    @reviews = Review.where(apartment_id: @apartment.id)
    #boolean value used in view to decide whether user can add new review
    @show_form = can_review?(@reviews)        
  end

  #Page for creating new apartment profile.
  def new
    @apartment = Apartment.new
  end

  #Creates and saves new apartment profile if information is valid; otherwise reloads page for
  #creating new profiles.
  def create
    @apartment = Apartment.new(params[:apartment])
    @apartment.save ? redirect_to @apartment : render "new"
  end

  #Page for editing apartment profile information.
  def edit
  end

  #Saves updates to apartment profile if changes are valid; otherwise reload edit page.
  def update
    @apartment = Apartment.find(params[:id])
    valid = @apartment.update_attributes(apartment_params)
    valid ? redirect_to @apartment : render "edit"
  end

  #Verifies the user input contains the required fields of information. 
  private
    def apartment_params
      params.require(:apartment).permit(:title, :address, :description, :price, :bathrooms, :bedrooms)
    end
end
