class UsersController < ApplicationController
	before_action :autheticate_user!
	def show
		@user = User.find(params[:id])
		@books = @user.books
		@book = Book.new
	end

	def index
		@users = User.all
		@user = current_user
		@book = Book.new
	end

	def edit
		@user = User.find(params[:id])
		if @user.id != current_user.id
			redirect_to user_path(current_user)
		end
	end

	def update
		@user = user.find(params[:id])
		if @user.update(user_params)
			flash[:notice] = "successfully"
			redirect_to user_path(current_user)
		else
			render "edit"
		end
	end

	private
	def user_params
		params.require(:user).permit(:user, :introduction, :profile_image)
	end
end
