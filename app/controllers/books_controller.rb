class BooksController < ApplicationController
  before_action :set_book, only: [ :show, :edit, :update, :destroy ]

  rescue_from Exceptions::BaseException, :with => :render_error_response

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

  def serve_search 
    @books = Apis::GoogleApi::SearchBooks.volumes(params[:book])
    respond_to do |format|
      format.js { render partial: 'books/search_result' }
    end    
  end

  def book_to_add
    @book_model = Book.new
    @book = Apis::GoogleApi::SearchBooks.volume(params[:id])
  end

  def add_book
    @book_model = Book.new(book_params)
    if @book_model.save
      flash[:notice] = "Book was added successfully"
      redirect_to @book_model
    else 
      redirect_to book_to_add_path(id:params[:book][:id])
    end 
  end

  private
    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      sanitize_params
      params.require(:book).permit(:id, :title, :description, :image_link, :average_rating, :publisher, :published_date, :preview_link, :quantity, :purchase_price, :sale_price)
    end

    def sanitize_params
      params[:average_rating] = params[:average_rating] == "None" ? nil : params[:average_rating].to_i
    end

    def render_error_response(error)
      @error = error 
      respond_to do |format|
          format.js { render partial: 'books/api_error' }
      end
    end
end
