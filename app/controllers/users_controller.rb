class UsersController < ApplicationController
	NOT_LOGGEDIN = -6

	# This is the function to show a user page and list of apartments that the user create
	def show
		if(current_user)
			@user = User.find(params[:id])
			@apartments = Apartment.where(user_id: @user.id)
			@list = @user.flagged_apartments
		else
			render json: {errCode: NOT_LOGGEDIN}
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		valid = @user.update_attributes(user_params)
		redirect_to @user if valid
		render "edit"
	end

	private
	def user_params
		params.require(:user).permit(:username, :email, :password, :password_confirmation, :remember_me, :photo)
	end
end
