class ReviewsController < ApplicationController
	FORBIDDEN = 403
  def create
  	#assuming add method in model will return correct error code
  	if(current_user)	#check if the user is loggin in
  		code = Review.create(params[:user_id],params[:apt_id], params[:overall_rating]. params[:review]) 
  	else
  		#To do: render error code is user is not loggin in
  		render 

  	#update new averge rating
	num_of_reviews = Review.count(:conditions => "apt_id == params[:apt_id]") 	#TODO: make sure this is correct
	average_review = Apartment.find(params[:apt_id].average_overall_rating
	total = num_of_reviews * average_review + params[:overall_rating]
	num_of_reviews += 1
	new_average = total / num_of_reviews
	Apartment.average_overall_rating = new_average;
	Apartment.save;

	

  	#render json based on the error code returned
  end

  def update
  end

  def find_by_apt
  end
end
