class ApplicationMailer < ActionMailer::Base
	default from: 'support@advertisingportal.com'
  layout 'mailer'

  def slot_created(solt_id,user_id)
		user =  User.find(user_id)
		slot =  Slot.find(solt_id)
		provider =  User.find(slot.provider_id)
		body = "New slot with start time "+slot.start_time.strftime('%d-%m-%Y %H:%M')+" and end time "+slot.end_time.strftime('%d-%m-%Y %H:%M')+" by provider "+provider.name
		mail(
			to: user.email,
			content_type: "text/html",
			subject: "New Slot is created",
			body: body
			)
  end

  def agent_pre_book(solt_id,user_id)
		user =  User.find(user_id)
		slot =  Slot.find(solt_id)
		agent =  User.find(slot.agent_id)
		body = "Slot with start_time"+slot.start_time.strftime('%d-%m-%Y %H:%M')+" and end time "+slot.end_time.strftime('%d-%m-%Y %H:%M')+"is pre booked by agent "+agent.name
		mail(
			to: user.email,
			content_type: "text/html",
			subject: "Pre booked by agent",
			body: body
			)
  end

  def bid_rate(solt_id,  user_id , organization_id)
  	user =  User.find(user_id)
  	organization =  User.find(organization_id)
		slot =  Slot.find(solt_id)
		max_bid = Biding.where(:slot_id => solt_id).order("latest_bid DESC").first
		body = "New bid price "+max_bid.latest_bid.to_s+" for slot of start_time"+slot.start_time.strftime('%d-%m-%Y %H:%M')+" and end time "+slot.end_time.strftime('%d-%m-%Y %H:%M')+" by orgnization "+organization.name
		mail(
			to: user.email,
			content_type: "text/html",
			subject: "New biding price",
			body: body
			)
  end

  def bid_loser(solt_id , user_id)
  	user =  User.find(user_id)
		slot =  Slot.find(solt_id)
		organization = User.find(slot.organization_id)
		body = "The slot of start_time"+slot.start_time.strftime('%d-%m-%Y %H:%M')+" and end time "+slot.end_time.strftime('%d-%m-%Y %H:%M')+
						" biding is sold to orgnization "+organization.name+" at price of "+slot.final_price.to_s+" better luck next time"
		mail(
			to: user.email,
			content_type: "text/html",
			subject: "Biding is won by different orgnization",
			body: body
			)
  end

  def bid_winner(solt_id , user_id)
  	user =  User.find(user_id)
		slot =  Slot.find(solt_id)
		organization = User.find(slot.organization_id)
		body = "Congralutions for wining bide of slot start time"+slot.start_time.strftime('%d-%m-%Y %H:%M')+" and end time "+slot.end_time.strftime('%d-%m-%Y %H:%M')+
						"at price of "+slot.final_price.to_s
		mail(			
			to: user.email,
			content_type: "text/html",
			subject: "Congralutions your organization has won bidding",
			body: body
			)
  end


  def provider_sold_confirmation(solt_id , user_id)
  	user =  User.find(user_id)
		slot =  Slot.find(solt_id)
		organization = User.find(slot.organization_id)
		body = "Congralutions your slot of  start time"+slot.start_time.strftime('%d-%m-%Y %H:%M')+" and end time "+slot.end_time.strftime('%d-%m-%Y %H:%M')+
						+"is sold to organization "+organization.name+" at price of "+slot.final_price.to_s
		mail(			
			to: user.email,
			content_type: "text/html",
			subject: "Your slot successfully sold to organization",
			body: body
			)
  end
end