class BooksController < ApplicationController
  before_action :set_book, only: [ :show, :edit, :update, :destroy ]
  rescue_from Exceptions::BaseException, :with => :render_error_response

  def index
    @books = Book.paginate(page: params[:page], per_page: 5)
  end

  def catalog_search
    # raise Exceptions::ApiExceptions::BookError::MissingSearchTerms if params[:book].blank?
    @search_books = Book.search_book(params[:book]).paginate(page: params[:page], per_page: 5) 
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
    sanitize_params
    @book_model = Book.new(book_params)
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
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:id, :title, :description, :image_link, :average_rating, :publisher, :published_date, :preview_link, :quantity, :purchase_price, :sale_price, :external_id)
    end

    #Agregar a el modelo del book, y hacer un callback con esto, before_save
    def sanitize_params
      params[:book][:title] = params[:book][:title].titleize
      params[:book][:quantity] = params[:book][:quantity].to_i
      params[:book][:purchase_price] = params[:book][:purchase_price].to_f
      params[:book][:sale_price] = params[:book][:sale_price].to_f
      params[:book][:average_rating] = params[:book][:average_rating].empty? ? nil : params[:book][:average_rating].to_i
      params[:author][:full_names] = params[:author][:full_names] == "None" ? "Anonymous" : params[:author][:full_names].split(", ")
    end

    def render_error_response(error)
      @error = error 
      respond_to do |format|
        format.js { render partial: 'shared/ajax_error' }
      end
    end
end
