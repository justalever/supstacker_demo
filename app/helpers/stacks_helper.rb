module StacksHelper

  def current_user_stack?(stack)
    user_signed_in? && stack.user == current_user
  end
end
