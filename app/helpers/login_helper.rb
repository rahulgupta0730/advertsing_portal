module LoginHelper
  def user_type
    users = [
      ["Organization","organization"] ,
      ["Provider","provider"] ,
      ["Agent","agent"]
    ]
    return users
  end

end
