module ApplicationHelper
	def current_user_name(id)
		user = User.find(id)
		return user.fname.titlecase+" "+user.lname.titlecase
	end

	def role_name(id)
		user = User.find(id)
		return user.role_name.titlecase
	end
end
