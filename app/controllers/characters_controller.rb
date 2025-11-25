class CharactersController < ApplicationController
  # Public browse pages for characters
  def index
    # Load published characters ordered by release date
    @characters = Character.published.recent.page(params[:page]).per(20)
  end

  def show
    # Find by slug or id (thanks to to_param in Character model)
    @character = Character.find_by!(slug: params[:id]) rescue Character.find(params[:id])
  end
end