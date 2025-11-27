class Admin::CharactersController < Admin::BaseController
  before_action :set_character, only: [:show, :edit, :update]
  before_action :set_collections, only: [:edit, :update]

  # GET /admin/characters
  # Simple list of characters
  def index
    @characters = Character.order(:name)
  end

  # GET /admin/characters/:id
  def show
  end

  def new
    @character = Character.new
  end

  def create
    @character = Character.new(character_params)

    if @character.save
      redirect_to admin_character_path(@character), notice: "Character was created."
    else
      flash.now[:alert] = "Failed to create character."
      render :new
    end
  end
  
  # GET /admin/characters/:id/edit
  def edit
  end

  # PATCH/PUT /admin/characters/:id
  def update
    if @character.update(character_params)
      redirect_to admin_character_path(@character), notice: "Character updated."
    else
      flash.now[:alert] = "Failed to update character."
      render :edit
    end
  end

  def destroy
    @character.destroy
    redirect_to admin_characters_path, notice: "Character was deleted."
  end

  private
  def set_character
    @character =
      Character.find_by(slug: params[:id]) ||
      Character.find(params[:id])
  end

  # For selects in form (items & other characters)
  def set_collections
    @all_items       = Item.order(:name)
    @all_characters  = Character.order(:name)
    @team_candidates = @all_characters.where.not(id: @character.id)
  end

  # Strong params (basic fields + recommended relations)
  def character_params
    params.require(:character).permit(
      :name,
      :slug,
      :rarity,
      :element,
      :weapon_type,
      :job,
      :summary,
      :released_on,
      :is_published,
      :portrait,
      # recommended equipment: uses has_many :through _ids setter
      recommended_item_ids: [],
      # recommended teammates
      recommended_teammate_ids: []
    )
  end
end