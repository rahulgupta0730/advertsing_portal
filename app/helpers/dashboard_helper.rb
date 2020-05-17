module DashboardHelper

	def date_time_format(date_time)
		return date_time.strftime('%d-%m-%Y %H:%M')
	end

	def tab_one_heading(user_id)
		user = User.find(user_id)
		if user.role_name == "provider"
			return "Created Slots"
		elsif user.role_name == "agent" || user.role_name == "organization"
			return "Available Slots"
		end
	end

	def tab_two_heading(user_id)
		user = User.find(user_id)
		if user.role_name == "provider"
			return "Created Slots"
		elsif user.role_name == "agent"
			return "Pre Booked Slots"
		elsif user.role_name == "organization"
			return "Booked Slots"
		end
	end
end
