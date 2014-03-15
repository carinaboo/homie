class ReviewsController < ApplicationController
  FORBIDDEN = 403
  SUCCESS = 1
  NOT_LOGGEDIN = -6
  UNAUTHORIZED_USER = -7

  def create
    # can only create when in an apartment page!
    # assuming add method in model will return correct error code or new_average
    if(current_user)	# check if the user is loggin in
      apt = Review.find(params[:id])
      review = apt.reviews.add(current_user.id, params[:overall_rating], params[:review])
      # review = Review.add(current_user.id, params[:id], params[:overall_rating], params[:review])
    else
      render json: {errCode: NOT_LOGGEDIN}
    end

    #if code != 1
    #  render json: {errCode: code}
    #end

    # update new averge rating
    num_of_reviews = Review.count(:conditions => "apt_id == params[:apt_id]") 	#To do: make sure this is correct
    apt_record = Apartment.find(params[:apt_id])
    average_review = apt_record.average_overall_rating
    overall_rating = params[:overall_rating]
    new_average = Review.add_average_rating(num_of_reviews, average_review, overall_rating)
    apt_record.average_overall_rating = new_average;
    apt_record.save;

    # render json to return the newly created review
    render json: {user_id: params[:user_id], apt_id: params[:apt_id], review: params[:review], overall_rating: new_average}

  end

  def update
    if(current_user)
      # check if the current user modifying the review is the user wrote the review
      review = Review.find(params[:review_id])
      user_id = review.user_id
      if(current_user.user_id != user_id)
        render json:{errCode: UNAUTHORIZED_USER}
      end

      code = review.update(params[:overall_rating], params[:review])

    else  # if not logged in
      # handle error: user is not logged in
      render json: {errCode: NOT_LOGGEDIN}
    end

    if code!= 1
      # error handling, only FORBIDDEN will be returned in this case
      render json: {errCode: code}
    end

    # update new averge rating
    num_of_reviews = Review.count(:conditions => "apt_id == params[:apt_id]")   #To do: make sure this is correct
    apt_record = Apartment.find(params[:apt_id])
    average_review = apt_record.average_overall_rating
    new_overall_rating = params[:overall_rating]
    old_overall_rating = review.overall_rating
    new_average = Review.update_average_rating(num_of_reviews, average_review, old_overall_rating, new_overall_rating)
    apt_record.average_overall_rating = new_average;
    apt_record.save;
  end

  def find_by_apt
    array_of_records = Review.find_by_apt(params[:apt_id])
    array_length = array_of_records.array_length
    new_array = Array.new(array_length)
    array_of_records.each_with_index{ |val, index|
      review_id = val.review_id
      user_id = val.user_id
      username = User.find(user_id).username 		#Todo: name is username or real name?
      review = val.review
      overall_rating = val.overall_rating
      json_object = {:review_id=>review_id, :username=>username, :review=>review, :overall_rating=>overall_rating}.to_json
      new_array[index] = json_object
    }
    return new_array
  end
end
