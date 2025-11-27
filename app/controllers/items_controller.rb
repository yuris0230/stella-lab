class ItemsController < ApplicationController
  # Public item list and detail pages

  def index
    # base scope
    items = Item.order(:name)
    items = items.where(is_published: true) unless admin_signed_in?

    # --- Basic text search by name ---
    @q = params[:q].to_s.strip
    if @q.present?
      pattern = "%#{@q.downcase}%"
      items = items.where('LOWER(name) LIKE ?', pattern)
    end

    # --- Filter by rarity (SR / SSR etc.) ---
    rarity_values = Array(params[:rarities]).reject(&:blank?).map!(&:to_i)
    items = items.where(rarity: rarity_values) if rarity_values.present?

    # --- Filter by item_type (weapon / armor / accessory / material) ---
    item_type_values = Array(params[:item_types]).reject(&:blank?).map!(&:to_i)
    items = items.where(item_type: item_type_values) if item_type_values.present?

    # N+1 for icon
    @items = items.includes(icon_attachment: :blob)
  end

  def show
    # if admin can see all items
    scope = admin_signed_in? ? Item.all : Item.where(is_published: true)

    # use slug if not found fallback id
    @item = scope.find_by(slug: params[:id]) || scope.find(params[:id])
  end
end