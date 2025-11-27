# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Default content for Home "Game info" section
SiteText.find_or_create_by!(key: "home_game_info") do |st|
  st.title = "Game information"
  st.body  = <<~TEXT
    This section describes the game Stella Lab is focusing on.
    You can edit this text from the admin panel (Admin > Home content).
  TEXT
end

# Default content for About page main body
SiteText.find_or_create_by!(key: "about_body") do |st|
  st.title = "About Stella Lab"
  st.body  = <<~TEXT
    Stella Lab is a fan-made hub that collects game data, tier lists,
    and community discussions for players who want both fun and depth.

    You can customize this text from the admin panel (Admin > About content).
  TEXT
end