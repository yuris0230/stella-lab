class Admin::TierListEntriesController < Admin::BaseController
  before_action :set_tier_list
  before_action :set_entry, only: [:edit, :update, :destroy]

  def index
    @entries = @tier_list.tier_list_entries
                         .includes(:character)
                         .order(:tier_rank, :id)
  end

  def new
    @entry = @tier_list.tier_list_entries.new
  end

  def create
    @entry = @tier_list.tier_list_entries.new(entry_params)

    if @entry.save
      redirect_to admin_tier_list_tier_list_entries_path(@tier_list),
                  notice: "Entry was created."
    else
      flash.now[:alert] = "Failed to create entry."
      render :new
    end
  end

  def edit
  end

  def update
    if @entry.update(entry_params)
      redirect_to admin_tier_list_tier_list_entries_path(@tier_list),
                  notice: "Entry was updated."
    else
      flash.now[:alert] = "Failed to update entry."
      render :edit
    end
  end

  def destroy
    @entry.destroy
    redirect_to admin_tier_list_tier_list_entries_path(@tier_list),
                notice: "Entry was deleted."
  end

  private

  def set_tier_list
    if TierList.column_names.include?("slug")
      @tier_list = TierList.find_by!(slug: params[:tier_list_id])
    else
      @tier_list = TierList.find(params[:tier_list_id])
    end
  end

  def set_entry
    @entry = @tier_list.tier_list_entries.find(params[:id])
  end

  def entry_params
    permitted = [:character_id, :tier_rank, :note]
    params.require(:tier_list_entry)
          .permit(*(permitted & TierListEntry.column_names.map(&:to_sym)))
  end
end