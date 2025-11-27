class Admin::TierListsController < Admin::BaseController
  before_action :set_tier_list, only: [:show, :edit, :update, :destroy]

  def index
    @tier_lists = TierList.order(created_at: :desc)
  end

  def show
    @entries = @tier_list.tier_list_entries.includes(:character)
  end

  def new
    @tier_list = TierList.new(is_published: true)
  end

  def create
    @tier_list = TierList.new(tier_list_params)

    if @tier_list.save
      redirect_to new_admin_tier_list_tier_list_entry_path(@tier_list),
                  notice: "Tier list was created. Now add entries."
    else
      flash.now[:alert] = "Failed to create tier list."
      render :new
    end
  end

  def edit; end

  def update
    if @tier_list.update(tier_list_params)
      redirect_to admin_tier_list_path(@tier_list),
                  notice: "Tier list was updated."
    else
      flash.now[:alert] = "Failed to update tier list."
      render :edit
    end
  end

  def destroy
    @tier_list.destroy
    redirect_to admin_tier_lists_path, notice: "Tier list was deleted."
  end

  private

  def set_tier_list
    if TierList.column_names.include?("slug")
      @tier_list = TierList.find_by!(slug: params[:id])
    else
      @tier_list = TierList.find(params[:id])
    end
  end

  def tier_list_params
    available = TierList.column_names.map(&:to_sym)
    allowed   = [:title, :slug, :description, :is_published] & available

    params.require(:tier_list).permit(*allowed)
  end
end