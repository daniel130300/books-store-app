class BooksController < ApplicationController
  before_action :set_book, only: [ :show, :edit, :update ]
  before_action :require_admin, only: [:search, :serve_search, :add_book, :book_to_add, :edit, :update]
  rescue_from Exceptions::BaseException, :with => :render_error_response

  def index
    @books = Book.paginate(page: params[:page], per_page: 5)
  end

  def catalog_search
    @search_books = Book.search_book(params[:book]).paginate(page: params[:page], per_page: 5) 
  end

  def show
    if !@book.blank?
      @book.already_in_wishlist = current_user.already_in_wishlist?(@book)
      @book.already_in_cart = current_user.already_in_cart?(@book)
      @book.still_available = Book.still_available?(@book)
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to @book 
      flash[:notice] = "Book was successfully updated"
    else
      render :edit
    end
  end

  def search
  end

  def serve_search 
    @api_books = Apis::GoogleApi::SearchBooks.volumes(params[:book])
    if !@api_books.blank?
      @api_books.each {|book| book["already_added"] = !Book.check_book(book["id"])}
    end
    respond_to do |format|
      format.js { render partial: 'books/partials/search_result' }
    end    
  end

  def book_to_add
    @book_model = Book.new
    @api_book = Apis::GoogleApi::SearchBooks.volume(params[:id])
  end

  def add_book
    @book_model = Book.new(book_params)
    params[:author][:full_names] = params[:author][:full_names] == "None" ? "Anonymous" : params[:author][:full_names].split(", ")
    if !params[:author][:full_names].blank?
      params[:author][:full_names].each do |full_name|
        author = Author.where(full_name: full_name.titleize).first_or_create(full_name: full_name.titleize)
        @book_model.authors << author
      end
    end
    if @book_model.save
      flash[:notice] = "Book was added successfully"
      redirect_to @book_model
    else 
      @api_book = Apis::GoogleApi::SearchBooks.volume(params[:id])
      render 'book_to_add' 
    end 
  end

  private
    def set_book
      @book = Book.find(params[:id]) rescue not_found
    end

    def book_params
      params.require(:book).permit(:id, :title, :description, :image_link, :average_rating, :publisher, :published_date, :preview_link, :stock, :purchase_price, :sale_price, :external_id)
    end    

    def require_admin
      if !current_user.admin?
        flash[:alert] = "Can't access this page"
        redirect_to books_path
      end
    end  

    def render_error_response(error)
      @error = error 
      respond_to do |format|
        format.js { render partial: 'shared/ajax_error' }
      end
    end
end
