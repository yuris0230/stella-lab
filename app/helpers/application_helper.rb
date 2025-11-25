module ApplicationHelper
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