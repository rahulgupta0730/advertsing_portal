class BindingsController < ApplicationController
	layout "authorize"
	before_action :set_bindings, only: [:index, :biding_end]


  def index
  end

  def biding_end
    user =  User.find(session[:user_id])
 	  max_bid = @bidings.order("latest_bid DESC").first
 	  @slot.final_price = max_bid.latest_bid
 	  @slot.organization_id = max_bid.bid_by
 	  @slot.status = "sold"
 	  if @slot.save
      user.sold_email(@slot.id)
 	  	redirect_to "/dashboard", flash: {success:'Binding end succesfully' }
 	  else
 	  	render :index
 	  end
  end

  private
    def set_bindings
    	@slot = Slot.find(params[:slot_id])
      @bidings = Biding.where(:slot_id => params[:slot_id])
    end

end
