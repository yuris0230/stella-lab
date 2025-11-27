class TierListsController < ApplicationController
  # GET /tier_lists
  def index
    # if have column is_published filter only is pub
    @tier_lists = base_scope.order(created_at: :desc)
  end

  # GET /tier_lists/:id
  def show
    # helper slug_or_id
    @tier_list = base_scope.find_by!(slug_or_id(params[:id]))

    @entries = @tier_list.tier_list_entries
                         .includes(:character)
                         .order(:tier_rank, :id)
  end

  private
  # scope for user
  def base_scope
    if TierList.column_names.include?("is_published")
      TierList.where(is_published: true)
    else
      TierList.all
    end
  end

  # if slug find slug, if no find id
  def slug_or_id(param)
    if TierList.column_names.include?("slug")
      { slug: param }
    else
      { id: param }
    end
  end
end