module ApplicationHelper
  def body_classes
    [controller.controller_name]
  end

  def current_user_is?(user)
    # TODO: https://github.com/NoamB/sorcery/issues/16
    return false if current_user.nil? or current_user.nil?
    current_user.username == user.username
  end
end
