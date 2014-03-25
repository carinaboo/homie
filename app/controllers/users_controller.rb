class UsersController < ApplicationController
	def show
		if(current_user)
			@user = User.find(params[:id])
		else
			render json: {errCode: NOT_LOGGEDIN}
		end
	end
end
