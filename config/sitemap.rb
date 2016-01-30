# Set the host name for path creation
SitemapGenerator::Sitemap.default_host = "http://codelit.com"
SitemapGenerator::Sitemap.compress = :all_but_first

SitemapGenerator::Sitemap.create do
  add new_user_registration_path, :changefreq => 'yearly', priority: 0.7
  add new_user_session_path, :changefreq => 'yearly', priority: 0.7
  add recipes_path, :changefreq => 'weekly', priority: 0.9
  add courses_path, :changefreq => 'weekly', priority: 1.0
  add casts_path, :changefreq => 'weekly', priority: 0.7
  add terms_path, changefreq: 'yearly', priority: 0.5
  add privacy_path, changefreq: 'yearly', priority: 0.5
  add '/about', :changefreq => 'monthly'
  add '/pricing', :changefreq => 'monthly'

  User.find_each do |user|
    add user_path(user), :changefreq => 'weekly', priority: 0.7
  end

  Recipe.find_each do |blog|
    add recipe_path(blog), :lastmod => blog.updated_at
  end

  Course.find_each do |course|
    add course_path(course), :lastmod => course.updated_at
  end

  Cast.find_each do |cast|
    add cast_path(cast), :lastmod => cast.updated_at
  end
end
