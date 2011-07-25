module ApplicationHelper
  def body_classes
    [controller.controller_name]
  end

  def current_user_is?(user)
    return false unless current_user
    current_user.username == user.username
  end
end
