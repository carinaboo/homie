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
end
