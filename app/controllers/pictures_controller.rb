class PicturesController < ApplicationController
	
	def create
    # can only create when in an apartment page!
	    if(current_user)	# check if the user is logged in
	      apartment = Apartment.find(params[:picture][:apartment_id]) # removed params[:picture][:apartment_id]
	      picture = Picture.new(picture_params)
	      picture.save
	      redirect_to apartment_path id: apartment.id
	    else
	      render json: {errCode: NOT_LOGGEDIN}
	    end
    end

    def delete
	    picture = Picture.find(params[:id])
	    @apartment = Apartment.find(picture.apartment_id)
	    if !@apartment
	      flash[:error] = "Error: Apartment page not found\n"
	      redirect_to root_path
	    elsif !current_user
	      # user is not logged in
	      flash[:error] = "Error: user must be signed in to delete picture\n"
	      redirect_to @apartment
=begin
	    elsif current_user.id != user_id
	      #user is not review creator
	      flash[:error] = "Error: only the owner is allowed to delete picture\n"
	      redirect_to @apartment
=end
	    else
	      picture.destroy
	      redirect_to @apartment
	    end
    end

    private
  	def picture_params
    	params.require(:picture).permit(:apartment_id, :image)
  	end 
end
