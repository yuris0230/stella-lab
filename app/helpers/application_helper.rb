module ApplicationHelper


  def liked_by_current_user?(record)
    return false unless user_signed_in?
      current_user.likes.exists?(likeable: record)
  end
  # Safe path helper
  # Example: safe_path(:characters_path) -> characters_path or "#"
  def safe_path(helper_name, fallback = "#")
    if respond_to?(helper_name)
      send(helper_name)
    else
      fallback
    end
  end
end