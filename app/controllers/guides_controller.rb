class GuidesController < ApplicationController
  # Public “Guides” list and detail
  def index
    @guides = Guide.published.order(created_at: :desc)
  end

  def show
    @guide = Guide.published.find_by!(slug: params[:id])
  end
end