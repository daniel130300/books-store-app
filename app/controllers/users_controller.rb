class UsersController < ApplicationController
  
    rescue_from Exceptions::BaseException, :with => :render_error_response
    
    def search_friend
    end
  
    def serve_search_friend
      raise Exceptions::ApiExceptions::FriendError::MissingSearchTerms if params[:friend].blank?
      @friends = User.search(params[:friend], current_user)
      if !@friends.blank?
        @friends.each { |friend| friend.already_friends = current_user.not_friends_with?(friend.id) }
      end
      respond_to do |format|
        format.js { render partial: 'users/partials/friend_result' }
      end
    end

    def my_friends
      @friends = current_user.friends
    end

    def show
      @to_friend_checkout = ShoppingCart.new()
      @user = User.find(params[:id])
      @user.already_friends = current_user.not_friends_with?(@user.id)
      @owned_books = Book.joins(sale_books: :sale).where(sales: { user_id: @user.id }).or(Book.joins(sale_books: :sale).where(sales: { friend_id: @user.id })).distinct.paginate(page: params[:page], per_page: 5)
      @wishlist_books = @user.wish_books.paginate(page: params[:page], per_page: 5)
      if !@wishlist_books.blank?
        @wishlist_books.each do |book| 
          book.wish_book_owner = false
          book.price_details = Services::GetCartPrices.call(book)
          book.still_available = Book.still_available?(book)
        end
      end
    end

    def my_books
      @owned_books = Book.joins(sale_books: :sale).where(sales: { user_id: current_user.id }).or(Book.joins(sale_books: :sale).where(sales: { friend_id: current_user.id })).distinct.paginate(page: params[:page], per_page: 5)
    end

    def my_wishlist
      @wishlist_books = current_user.wish_books.paginate(page: params[:page], per_page: 5)
      if !@wishlist_books.blank?
        @wishlist_books.each { |book| book.wish_book_owner = true }
      end
    end

    def my_gifts
      @gifted_sales = Sale.includes( :user, { sale_books: :book } ).where('sales.friend_id = ? and view_flag = false', current_user.id).references(:user).paginate(page: params[:page], per_page: 5)
    end

    def already_seen
      @sale_book = SaleBook.new()
      salebook = SaleBook.where(sale_id: params[:sale_id], book_id: params[:book_id]).first
      if salebook.update_attribute(:view_flag, true)
        flash[:notice] = "Book notification removed"
      else 
        flash[:alert] = "Something went wrong trying to remove the book notification"
      end
      redirect_to my_gifts_path
    end

    private

    def render_error_response(error)
      @error = error 
      respond_to do |format|
        format.js { render partial: 'shared/ajax_error' }
      end
    end
end
  