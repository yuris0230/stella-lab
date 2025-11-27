class CharactersController < ApplicationController
  # Public character list and detail pages

  def index
    # Base scope: order by name, only published for normal users
    characters = Character.order(:name)
    # hide soft-deleted characters if column exists
    if Character.column_names.include?("is_deleted")
      characters = characters.where(is_deleted: false)
    end
    # NOTE: is_published is not filtered here anymore to avoid characters
    # disappearing for users when admins log out. If you want to use it,
    # make sure it is set correctly on all records.
    # characters = characters.where(is_published: true) unless admin_signed_in?

    # --- Basic text search by name (case-insensitive) ---
    @q = params[:q].to_s.strip
    if @q.present?
      pattern = "%#{@q.downcase}%"
      characters = characters.where('LOWER(name) LIKE ?', pattern)
    end

    # --- Filter by rarity (SR / SSR) ---
    rarity_values = Array(params[:rarities]).reject(&:blank?).map!(&:to_i)
    characters = characters.where(rarity: rarity_values) if rarity_values.present?

    # --- Filter by element (fire / water / wind / earth / light / dark) ---
    element_values = Array(params[:elements]).reject(&:blank?).map!(&:to_i)
    characters = characters.where(element: element_values) if element_values.present?

    # preload associations used in views (likes + portrait)
    characters = characters.includes(:likes, portrait_attachment: :blob)

    # If you want pagination later, you can add kaminari here:
    # @characters = characters.page(params[:page]).per(20)
    @characters = characters
  end

  def show
    # Find by slug so URLs look like /characters/brave-knight
    @character = Character.find_by!(slug: params[:id])
  end
end