class BooksController < ApplicationController
  before_action :set_book, only: [ :show, :edit, :update, :destroy ]

  rescue_from Errors::HttpartyError do |e|
    format_error :internal_server_error, :bad_request
  end

  rescue_from Errors::StandardApiError do |e|
    format_error :not_found, :standard_error
  end

  rescue_from ArgumentError do |e|
    format_error :bad_request, :blank_argument
  end

  def index
    @books = Book.all
  end

  def show
  end

  def new
    @book = Book.new
  end

  def edit
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to @book, 
      flash[:notice] = "Book was successfully created"
    else
      render :new
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    if @book.update(book_params)
      redirect_to @book, 
      flash[:notice] = "Book was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy
      redirect_to books_url
      flash[:notice] = "Book was successfully destroyed."
  end

  def search
  end

  def book_to_add
    @book = Apis::GoogleApi::SearchBooks.volume(params[:id])  
    respond_to do |format|
      if !@book.blank?
        format.html
        format.js
      end
    end    
  end

  def serve_search 
    @books = Apis::GoogleApi::SearchBooks.volumes(params[:book])
    respond_to do |format|
      if !@books.blank?
        format.js { render partial: 'books/result' }
      end
    end    
  end

  private
    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title)
    end
end
