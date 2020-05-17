class EmailQueueController < ApplicationController
	layout "authorize"

  def index
  end

  def clear_emails
  	ActionMailer::Base.deliveries = []
  	redirect_to "/dashboard", flash: {success:'Email queue cleared successfully' }
  end
end
