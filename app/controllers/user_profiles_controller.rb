class UserProfilesController < ApplicationController
  # Only logged-in users can edit their profile
  before_action :authenticate_user!

  # GET /profile/edit
  # Show profile edit form for current user
  def edit
    @profile = current_user.user_profile || current_user.build_user_profile
  end

  # PATCH /profile
  # Update current user's profile
  def update
    @profile = current_user.user_profile || current_user.build_user_profile

    if @profile.update(user_profile_params)
      redirect_to my_page_path, notice: "Profile updated successfully."
    else
      flash.now[:alert] = "Failed to update profile."
      render :edit
    end
  end

  private
  # Strong parameters for profile fields
  def user_profile_params
    params.require(:user_profile).permit(:display_name, :bio)
  end
end