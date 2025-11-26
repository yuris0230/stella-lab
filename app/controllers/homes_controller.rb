class HomesController < ApplicationController
  # Public static pages for the site

  def top
    # simple stats for the top page
    @character_count = Character.count
    @item_count = Item.count
    @guide_count = Guide.count
    @topic_count = Topic.count
  end

  def about
    # just renders static "About Stella Lab" page
  end
end