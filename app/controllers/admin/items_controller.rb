# app/controllers/admin/items_controller.rb
class Admin::ItemsController < Admin::BaseController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /admin/items
  def index
    @items = Item.order(:name)
  end

  # GET /admin/items/:id
  def show
  end

  # GET /admin/items/new
  def new
    @item = Item.new
  end

  # POST /admin/items
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_items_path, notice: "Item was created."
    else
      flash.now[:alert] = "Failed to create item."
      render :new
    end
  end

  # GET /admin/items/:id/edit
  def edit
  end

  # PATCH/PUT /admin/items/:id
  def update
    if @item.update(item_params)
      redirect_to admin_item_path(@item), notice: "Item updated."
    else
      flash.now[:alert] = "Failed to update item."
      render :edit
    end
  end

  # DELETE /admin/items/:id
  def destroy
    @item.destroy
    redirect_to admin_items_path, notice: "Item was deleted."
  end

  private

  def set_item
    # slug and id ( like Character)
    @item = Item.find_by(slug: params[:id]) || Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(
      :name,
      :slug,
      :rarity,
      :item_type,
      :summary,
      :released_on,
      :is_published,
      :icon
    )
  end
end