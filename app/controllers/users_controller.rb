class UsersController < ApplicationController

	# This is the function to show a user page and list of apartments that the user create
	def show
		if(current_user)
			@user = User.find(params[:id])
			# @orders = Order.where(customer_id: @customer.id)
			@apartments = Apartment.where(user_id: @user.id)
		else
			render json: {errCode: NOT_LOGGEDIN}
		end
	end
end
