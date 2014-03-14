class ReviewsController < ApplicationController
	FORBIDDEN = 403
  def create
  	#assuming add method in model will return correct error code or new_average
  	if(current_user)	#check if the user is loggin in
  		code = Review.add(params[:user_id],params[:apt_id], params[:overall_rating]. params[:review]) 
  		#To do: handle the returned error code

  	else
  		#To do: render error code is user is not loggin in
  		
  	end

  	#update new averge rating
	num_of_reviews = Review.count(:conditions => "apt_id == params[:apt_id]") 	#To do: make sure this is correct
	average_review = Apartment.find(params[:apt_id].average_overall_rating
	new_average = Review.update_review(num_of_reviews, average)
	Apartment.average_overall_rating = new_average;
	Apartment.save;

  	#render json to return the newly created review
  	render json: {user_id: params[:user_id], apt_id: params[:apt_id], review: params[:review], overall_rating[new_average]}

  end

  def update
  	#To do: copy code from create after finish create, but call Review.update instead
  end

  def find_by_apt
  	array_of_records = Review.find_by_apt(params[:apt_id])
  	array_length = array_of_records.array_length
  	new_array = Array.new(array_length)
  	array_of_records.each_with_index{ |val, index|
  		review_id = val.review_id
  		user_id = val.user_id
  		username = User.find(user_id).name 		#Todo: name is username or real name?
  		review = val.review
  		overall_rating = val.overall_rating
  		json_object = {:review_id=>review_id, :username=>username, :review=>review, :overall_rating=>overall_rating}.to_json
  		new_array[index] = json_object
  	}
  	return new_array
  end
end
