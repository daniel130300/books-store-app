class AddressesController < ApplicationController

    before_action :require_shipping_address, only: []
    before_action :set_address, only: [ :edit, :update ]
    before_action :shipping_address_not_exists?, only: [:create, :new]

    def new
        @address = Address.new()
    end

    def create
        @address = current_user.build_address(address_params)
        if @address.save
            flash[:notice] = "Shipping address was saved successfully"
            redirect_to edit_address_path
        else
            render 'new'
        end
    end

    def edit
    end

    def update
        if @address.update(address_params)
            flash[:notice] = "Shipping address was updated successfully"
            redirect_to edit_address_path
        else
            render 'edit'
        end
    end

    private 

    def set_address
        @address = current_user.address
    end

    def address_params
        params.require(:address).permit(:address_line_1, :address_line_2, :city, :state_or_province, :postal_code, :telephone)
    end

    def shipping_address_not_exists?
        current_user.address.blank?
    end

end
  