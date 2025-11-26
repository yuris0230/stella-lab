class Admin::AboutController < Admin::BaseController
  # Admin edits the main About page body
  def edit
    @about_text = SiteText.find_or_initialize_by(key: "about_body")
    @about_text.title ||= "About Stella Lab"
  end

  def update
    @about_text = SiteText.find_or_initialize_by(key: "about_body")
    if @about_text.update(about_text_params)
      redirect_to edit_admin_about_path, notice: "About page updated."
    else
      flash.now[:alert] = "Failed to update About content."
      render :edit
    end
  end

  private

  def about_text_params
    params.require(:site_text).permit(:title, :body)
  end
end