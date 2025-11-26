class HomesController < ApplicationController
  # Public static pages for the site

  def top
    # simple stats for the top page
    @characters_count = Character.count
    @items_count = Item.count
    @guides_count = Guide.count
    @topics_count = Topic.count

    # Text for "Game information" section (editable from admin)
    @game_info_title = SiteText.fetch_title("home_game_info") || "Game information"
    @game_info_body  = SiteText.fetch_body("home_game_info")
  end

  def about
    # Main About body is editable from admin
    @about_title = SiteText.fetch_title("about_body") || "About Stella Lab"
    @about_body  = SiteText.fetch_body("about_body")
  end
end