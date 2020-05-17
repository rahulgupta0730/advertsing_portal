class SlotsController < ApplicationController
	layout "authorize"
	before_action :set_slot, only: [:view, :agent_pre_booked , :binding_amount]

  def add
  	@slot = Slot.new()
  	authorize @slot
  end

  def create
  	@slot = Slot.new()
    authorize @slot
  	@slot.start_time = params[:slot][:start_time]
  	@slot.end_time =  params[:slot][:end_time]
  	@slot.base_price =  params[:slot][:base_price]
  	@slot.provider_id =  session[:user_id]
  	@slot.status =  'available'
  	if @slot.save
      agents =  User.where(:role_name => "agent")
      agents.each do |agent|
        ApplicationMailer.slot_created(@slot.id,agent.id).deliver_later
      end
  		redirect_to "/dashboard", flash: {success:'Slot created successfully' }
  	else
  		render :add
  	end
  end


  def view
    @check =  Biding.where(:slot_id =>  params[:slot_id])
    @bid =  Biding.where(:slot_id =>  params[:slot_id] , :bid_by => session[:bid_by])
    if @bid.blank?
      @bid =  Biding.new()
    end
  end


  def agent_pre_booked
  	@slot.agent_id = session[:user_id]
  	authorize @slot
  	if @slot.save
      ApplicationMailer.agent_pre_book(@slot.id,@slot.provider_id).deliver_later
  		redirect_to "/dashboard", flash: {success:'Slot booked successfully' }
  	else
  		render :view
  	end
  end


  def binding_amount
    user =  User.find(session[:user_id])
    @bid =  Biding.where(:slot_id =>  params[:slot_id] , :bid_by => session[:user_id]).first
    if @bid.blank?
      @bid =  Biding.new()
      @bid.slot_id = params[:slot_id]
      @bid.bid_by = session[:user_id]
    end
    @bid.bid_amounts.push(params[:biding][:latest_bid])
    @bid.latest_bid = params[:biding][:latest_bid]
    if @bid.save
      user.biders(params[:slot_id])
      redirect_to "/dashboard", flash: {success:'Binding for slot is successfull'}
    else
      render :view
    end
  end

  private
    def set_slot
      @slot = Slot.find(params[:slot_id])
    end

end
