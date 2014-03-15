class ReviewsController < ApplicationController
  FORBIDDEN = 403
  SUCCESS = 1
  NOT_LOGGEDIN = -6
  UNAUTHORIZED_USER = -7

  def create
    # can only create when in an apartment page!
    # assuming add method in model will return correct error code or new_average
    if(current_user)	# check if the user is loggin in
      # p "beforeeeeeeeeeee  " + Review.count.to_s
      # p "888888888888888888888  " + current_user.id.to_s
      # p "xxxxxxxxxxxxxxxxxxxxx  " + params[:id].to_s
      apartment = Apartment.find(params[:review][:apartment_id])
      # p "xxxxxxxxxxxxxxxxxxxxx apartment.title " + apartment.title
      review = apartment.reviews.add(current_user.id, params[:review][:overall_rating], params[:review][:review])
      # p "xxxxxxxxxxxxxxxxxxxxx review.apartment_id " + review.apartment_id.to_s + " " + review.user_id.to_s + " " + review.review
      # review = Review.add(current_user.id, params[:id], params[:overall_rating], params[:review])
      # p "afterrrrrrrrrrrr  " + Review.count.to_s
      p review.inspect
      # render json: review.to_json
    else
      render json: {errCode: NOT_LOGGEDIN}
    end

    #if code != 1
    #  render json: {errCode: code}
    #end

    # update new averge rating
    # num_of_reviews = Review.count(:conditions => "apartment_id == params[:apartment_id]") 	#To do: make sure this is correct
    num_of_reviews = apartment.reviews.count
    average_review = apartment.average_overall_rating || 0
    overall_rating = params[:review][:overall_rating].to_i
    new_average = Review.add_average_rating(num_of_reviews, average_review, overall_rating)
    apartment.average_overall_rating = new_average;
    apartment.save;

    redirect_to apartment_path id: apartment.id
    # render json: review.to_json
    # render json: {review: review, apartment: apartment}

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
