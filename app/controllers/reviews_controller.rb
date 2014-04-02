class ReviewsController < ApplicationController
  FORBIDDEN = 403
  PAGE_NOT_FOUND = 404
  SUCCESS = 1
  NOT_LOGGEDIN = -6
  UNAUTHORIZED_USER = -7

  def create
    # can only create when in an apartment page!
    if(current_user)	# check if the user is loggin in
      apartment = Apartment.find(params[:review][:apartment_id]) 
      # update new averge rating
      num_of_reviews = apartment.reviews.count
      average_review = apartment.average_overall_rating || 0
      overall_rating = params[:review][:overall_rating].to_i
      new_average = Review.add_average_rating(num_of_reviews, average_review, overall_rating)
      apartment.average_overall_rating = new_average;
      apartment.save;
      # add review to apartment
      review = apartment.reviews.add(current_user.id, params[:review][:overall_rating], params[:review][:review])
      redirect_to apartment_path id: apartment.id
    else
      render json: {errCode: NOT_LOGGEDIN}
    end
  end

  #Page for editing review
  def edit
    @review = Review.find(params[:id])
    if !@review
      render json: {errCode: PAGE_NOT_FOUND}
    elsif !current_user
      render json: {errCode: FORBIDDEN}
    end
  end

  def update
    if(current_user)
      review = Review.find(params[:id])
      apartment = Apartment.find(review.apartment_id)
      # check if the current user modifying the review is the user wrote the review
      user_id = review.user_id
      if(current_user.id != user_id)
        render json:{errCode: UNAUTHORIZED_USER}
      else
        # update new averge rating
        num_of_reviews = apartment.reviews.count
        average_review = apartment.average_overall_rating || 0
        new_overall_rating = params[:review][:overall_rating].to_i
        old_overall_rating = review.overall_rating
        new_average = Review.update_average_rating(num_of_reviews, average_review, old_overall_rating, new_overall_rating)
        apartment.average_overall_rating = new_average;
        apartment.save;
        # add review to apartment
        review.update(params[:review][:overall_rating], params[:review][:review])
        redirect_to apartment_path id: apartment.id
      end
    else
      # user is not logged in
      render json: {errCode: NOT_LOGGEDIN}
    end
  end

  def find_by_apt
    reviews = Review.find_by_apt(params[:apt_id])
    render json: reviews.to_json
    # array_length = array_of_records.array_length
    # new_array = Array.new(array_length)
    # array_of_records.each_with_index{ |val, index|
    #   review_id = val.review_id
    #   user_id = val.user_id
    #   username = User.find(user_id).username    #Todo: name is username or real name?
    #   review = val.review
    #   overall_rating = val.overall_rating
    #   json_object = {:review_id=>review_id, :username=>username, :review=>review, :overall_rating=>overall_rating}.to_json
    #   new_array[index] = json_object
    # }
    # return new_array
  end

  def delete
    review = Review.find(params[:id])
    @apartment = Apartment.find(review.apartment_id)
    # check if the current user modifying the review is the user wrote the review
    user_id = review.user_id
    if !@apartment
      flash[:error] = "Error: Apartment page not found\n"
      redirect_to root_path
    elsif current_user.id != user_id
      #user is not review creator
      flash[:error] = "Error: only the owner is allowed to delete apartment\n"
      redirect_to @apartment
    elsif !current_user
      # user is not logged in
      flash[:error] = "Error: user must be signed in to delete apartment\n"
      redirect_to @apartment
    else
      Review.delete(user_id, review.apartment_id)
      redirect_to @apartment
    end
  end
    
end
