class Admin::GuidesController < Admin::BaseController
  before_action :set_guide, only: [:show, :edit, :update, :destroy]

  # GET /admin/guides
  def index
    @guides = Guide.order(created_at: :desc)
  end

  # GET /admin/guides/:id
  def show
  end

  # GET /admin/guides/new
  def new
    @guide = Guide.new
  end

  # POST /admin/guides
  def create
    @guide = Guide.new(guide_params)
    @guide.author_admin = current_admin

    if @guide.save
      redirect_to admin_guide_path(@guide), notice: "Guide was created."
    else
      flash.now[:alert] = "Failed to create guide."
      render :new
    end
  end

  # GET /admin/guides/:id/edit
  def edit
  end

  # PATCH/PUT /admin/guides/:id
  def update
    if @guide.update(guide_params)
      redirect_to admin_guide_path(@guide), notice: "Guide was updated."
    else
      flash.now[:alert] = "Failed to update guide."
      render :edit
    end
  end

  # DELETE /admin/guides/:id
  def destroy
    @guide.destroy
    redirect_to admin_guides_path, notice: "Guide was deleted."
  end

  private
  def set_guide
    # Use slug for lookup
    @guide = Guide.find_by!(slug: params[:id])
  end

  def guide_params
    params.require(:guide).permit(:title, :slug, :body, :category, :is_published)
  end
end