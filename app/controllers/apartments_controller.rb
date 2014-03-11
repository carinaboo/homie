class ApartmentsController < ApplicationController
  include ApartmentsHelper

  def view
    @apartment = Apartment.find(params[:id])
    @reviews = Review.where(:apartment_id => @apartment.id)
    if !can_review(@reviews)
      @show_form = true
    end
  end

  def new
    @apartment = Apartment.new
  end

  def create
    @apartment = Apartment.new(params[:apartment])
    @apartment.save ? redirect_to @apartment : render 'new'
  end

  def edit
  end

  def update
    @apartment = Apartment.find(params[:id])
    valid = @apartment.update_attributes(apartment_params)
    valid ? redirect_to @apartment : render 'edit'
  end

  private
    def apartment_params
      params.require(:apartment).permit(:title, :address)
    end
end
