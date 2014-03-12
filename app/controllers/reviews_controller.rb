class ReviewsController < ApplicationController
	FORBIDDEN = 403
  def create
  	#assuming add method in model will return correct error code
  	if(current_user)	#check if the user is loggin in
  		code = Review.create(params[:user_id],params[:apt_id], params[:overall_rating]. params[:review]) 
  	else
  		#To do: render error code is user is not loggin in
  		render 

  		Review.count(:conditions => "apt_id == params[:apt_id]")

  	#render json based on the error code returned
  end

  def update
  end

  def find_by_apt
  end
end
