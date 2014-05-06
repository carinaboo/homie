class ApartmentsController < ApplicationController
  include ApartmentsHelper

  SUCCESS = 1
  FORBIDDEN = 403
  PAGE_NOT_FOUND = 404

  # def favorite
  #   if !current_user
  #     redirect_to new_user_session_url, :notice => "You need to Login to add favorite"
  #   else
  #     @current_user = current_user
  #     @apt = Apartment.find(params[:id])
  #     @list = current_user.flagged_apartments
  #     if @current_user.flagged?(@apt)
  #       @current_user.unflag(@apt)
  #       @list.delete(@apt)
  #       redirect_to apartment_path, :notice => "You removed this apartment to your favourite list"
  #     else
  #       @current_user.flag(@apt, :favorite)
  #       redirect_to apartment_path, :notice => "You added this apartment to your favourite list"
  #     end
  #   end
  # end

  def favorite
    @current_user = current_user
    @apt = Apartment.find(params[:id])
    result = Apartment.favorite(@current_user, @apt)
    if result == 200
      render json: {errCode: 200}
    elsif result == 201
      render json: {errCode: 201}
    else
      render json: {errCode: -1}
    end
  end

  #Loads the apartment profile page with reviews. Provides user with option to add reviews
  #if the user is logged in and hasn't already added a review.
  def show
    @apartment = Apartment.find(params[:id])
    @reviews = Review.find_by_apt(params[:id]) 
    @pictures = @apartment.pictures
    @review = Review.new
    @picture = Picture.new
    @reviewed = Review.hasReviewed(current_user, params[:id])
    @loggedIn = current_user
    if current_user
      @user_id = current_user.id
    end
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
    params[:apartment][:user_id] = user_id
    price = params[:apartment][:price]
    params[:apartment][:price] = Apartment.parsePrice(price)
    street_address = params[:apartment][:street_address]
    apartment_number = params[:apartment][:apartment_number]

=begin
    title = params[:apartment][:title]
    city = params[:apartment][:city]
    state = params[:apartment][:state]
    zip = params[:apartment][:zip]
    desc = params[:apartment][:description]
    price = params[:apartment][:price]
    params[:apartment][:price] = Apartment.parsePrice(price)
    beds = params[:apartment][:bedrooms]
    baths = params[:apartment][:bathrooms]
    street_address = params[:street_address]
    apartment_number = params[:apartment_number]
    @apartment = Apartment.add(user_id, title, street_address, apartment_number, city, state, zip, desc, price, beds, baths)
=end

    @apartment = Apartment.new(apt_params)
    if Apartment.where('street_address = ? AND apartment_number = ?', street_address, apartment_number).empty?    
      if @apartment.save
        redirect_to @apartment
      else
        render "new"
      end
    else
      flash[:error] = "Error: Apartment with same address and apartment number already exists\n"
      redirect_to new_apartment_path
    end
  end

  #Page for editing apartment profile information.
  def edit
    @apartment = Apartment.find_by_id(params[:id])
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
    params[:apartment][:user_id] = user_id
    price = params[:apartment][:price]
    params[:apartment][:price] = Apartment.parsePrice(price)

=begin
    title = params[:apartment][:title]
    street_address = params[:apartment][:street_address]
    apartment_number = params[:apartment][:apartment_number]
    city = params[:apartment][:city]
    state = params[:apartment][:state]
    zip = params[:apartment][:zip]
    description = params[:apartment][:description]
    price = params[:apartment][:price]
    params[:apartment][:price] = Apartment.parsePrice(price)
    beds = params[:apartment][:bedrooms]
    baths = params[:apartment][:bathrooms]
    result = @apartment.update(user_id, title, street_address, apartment_number, city, state, zip, description, price, beds, baths)
=end

    if @apartment.update_attributes(apt_params)
      redirect_to @apartment
    else 
      render "edit"
    end
  end

  def with_price(query)
    min_price = params[:min_price]
    max_price = params[:max_price]
    lowest_price = (min_price.presence || 0).to_f
    highest_price = (max_price.presence || Apartment.maximum("price")).to_f
    query.with(:price).between(lowest_price..highest_price)
  end

  def with_rating(query)
    min_rating = params[:min_rating]
    lowest_rating = (min_rating.presence || 0).to_f
    or_nil = (min_rating.presence || nil)
    if min_rating == (min_rating.presence || 0)
      query.with(:average_overall_rating).greater_than_or_equal_to(lowest_rating)
    elsif min_rating == or_nil
      query.with(:average_overall_rating)
    end

  end

  def with_bedrooms(query)
    min_bedrooms = params[:min_bedrooms]
    max_bedrooms = params[:max_bedrooms]
    lowest_bedrooms = (min_bedrooms.presence || 0).to_f
    highest_bedrooms = (max_bedrooms.presence || Apartment.maximum("bedrooms")).to_f
    query.with(:bedrooms).between(lowest_bedrooms..highest_bedrooms)
  end

  def with_bathrooms(query)
    min_bathrooms = params[:min_bathrooms]
    max_bathrooms = params[:max_bathrooms]
    lowest_bathrooms = (min_bathrooms.presence || 0).to_f
    highest_bathrooms = (max_bathrooms.presence || Apartment.maximum("bathrooms")).to_f
    query.with(:bedrooms).between(lowest_bathrooms..highest_bathrooms)
  end

  def low_high_sort(query)
    sort = params[:sorting]
    if sort == "Ratings: low to high"
      query.order_by(:average_overall_rating, :asc)
    elsif sort == "Ratings: high to low"
      query.order_by(:average_overall_rating, :desc)
    elsif sort == "Price: low to high"
      query.order_by(:price, :asc)
    elsif sort == "Price: high to low"
      query.order_by(:price, :desc)
    else # default sort from highest to lowest rating
      query.order_by(:average_overall_rating, :desc)
    end
  end


  #Searches for apartment listings
  def search
    @search = Apartment.search do |query|
      query.fulltext params[:search]
      with_price(query)
      with_rating(query)
      with_bedrooms(query)
      with_bathrooms(query)
      low_high_sort(query)
    end

    @apartments = @search.results
    @max_price = Apartment.maximum("price") || 5000
    @max_bedrooms = Apartment.maximum("bedrooms") || 6
    @max_bathrooms = Apartment.maximum("bathrooms") || 6
  end

  def destroy
    @apartment = Apartment.find_by_id(params[:id])
    #print "destroy apartment"
    if !@apartment
      #p "no apartment"
      flash[:error] = "Error: Apartment page not found\n"
      redirect_to root_path
    elsif !current_user
      #p "not signed in"
      flash[:error] = "Error: user must be signed in to delete apartment\n"
      redirect_to @apartment
    elsif @apartment.user_id != current_user.id
      #p "not owner"
      flash[:error] = "Error: only the owner is allowed to delete apartment\n"
      redirect_to @apartment
    else
      #print "successful"
      @apartment.delete()
      redirect_to root_path
    end
  end

  private
  def apt_params
    params.require(:apartment).permit(:title, :description, :price, :bathrooms, :bedrooms, :user_id, :apartment_number, :street_address, :city, :state, :zip, :price, :photo)
  end
end
