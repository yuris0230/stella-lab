class ItemsController < ApplicationController
  # Public browse pages for items
  def index
    # Load published items ordered by release date
    @items = Item.published.recent.page(params[:page]).per(20)
  end

  def show
    # Find by slug or id
    @item = Item.find_by!(slug: params[:id]) rescue Item.find(params[:id])
  end
end