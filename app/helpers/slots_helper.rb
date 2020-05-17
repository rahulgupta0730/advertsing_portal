module SlotsHelper

	def name(user_id = nil)
		if !user_id.blank?
			user = User.find(user_id)
			return user.fname+" "+user.lname
		else
			return "No agent pre book it"
		end
	end
end
