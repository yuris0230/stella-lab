class Admin::HomeController < Admin::BaseController
  # Admin edits the "Game information" section on Home
  def edit
    @home_text = SiteText.find_or_initialize_by(key: "home_game_info")
    @home_text.title ||= "Game information"
  end

  def update
    @home_text = SiteText.find_or_initialize_by(key: "home_game_info")
    if @home_text.update(home_text_params)
      redirect_to edit_admin_home_path, notice: "Home content updated."
    else
      flash.now[:alert] = "Failed to update home page content."
      render :edit
    end
  end

  private

  def home_text_params
    params.require(:site_text).permit(:title, :body)
  end
end