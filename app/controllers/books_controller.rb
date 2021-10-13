class BooksController < ApplicationController
  before_action :set_book, only: [ :show, :edit, :update, :destroy ]

  rescue_from ActiveRecord::RecordNotFound do |e|
    @errors = add_error :not_found, :book_not_found
  end

  rescue_from ArgumentError do |e|
    @errors = add_error :no_content, :blank_argument
    render(partial: 'books/error', format: :js)
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

  def serve_search 
    #@books = Services::GoogleServices::SearchBooks.call(params[:book])
    @errors = []
    @books = Apis::GoogleApi::SearchBooks.volumes(params[:book])
    respond_to do |format|
      format.js { render partial: 'books/result' }
    end
    
    # if params[:book].present?
    #   @books = Book.search(params[:book]) 
    #   if @books
    #     respond_to do |format|
    #       format.js { render partial: 'books/result' }
    #     end
    #   elsif @books.blank?
    #     flash.now[:alert] = "No results found"
    #     respond_to do |format|
    #       format.js { render partial: 'books/result' }
    #     end
    #   end
    # else
    #   flash.now[:alert] = "Please enter something"
    #   respond_to do |format|
    #     format.js { render partial: 'books/result' }
    #   end
    # end
    
  end

  private
    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title)
    end
end
