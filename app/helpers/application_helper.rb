module ApplicationHelper
  def user_admin?
    if current_user == nil
      false
    else
      user = User.find(current_user.id)
      if user.admin
        true
      else
        false
      end
    end
  end
end
