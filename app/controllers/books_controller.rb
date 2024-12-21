class BooksController < ApplicationController
  before_action :authenticate_user!
  def index
    if params[:query].present?
      @books = Book.where("title LIKE ? OR description LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    else
      @books = Book.all
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to @book, notice: "Book was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to @book, notice: "Book was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_url, notice: "Book was successfully deleted."
  end

  private

  # Strong parameters
  def book_params
    params.require(:book).permit(:title, :description, :price)
  end
end
