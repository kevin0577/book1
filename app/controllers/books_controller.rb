class BooksController < ApplicationController
	before_action :authenticate_user!
	def index
		@books = Book.all
		@newbook = Book.new
		@user = current_user
	end

	def show
		@book = Book.find(params[:id])
		@user = User.find(@book.user_id)
		@newbook = Book.new
	end

	def edit
		@book = Book.find(params[:id])
		if @book.user_id != current_user
			redirect_to books_path
		end
	end

	def create
		@newbook = Book.new(book_params)
		@newbook.user_id = current_user.id
		if @newbook.save
			flash[:notice] = "successfully"
			redirect_to book_path(@newbook)
		else
			@books = Book.all
			@user = current_user
			render :index
		end
	end

	def update
		@book = Book.find(params[:id])
		@user = current_user
		if @book.update(book_params)
		   flash[:notice] = "successfully"
		   redirect_to book_path(@book.current_user)
		else
			render :edit
		end
	end

	def destroy
		@book = Book.find(params[:id])
		@book.destroy
		flash[:notice] = "successfully"
		redirect_to books_path
	end

	private
	def book_params
		params.require(:book).permit(:title, :body, :user_id)
	end
end
