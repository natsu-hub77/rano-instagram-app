# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'factory_bot_rails'
include FactoryBot::Syntax::Methods

users = create_list(:user, 5)

users.each do |user|
  create_list(:post, 3, :with_images, user: user) 
end

Post.all.each do |post|
  commenters = users.reject { |u| u == post.user }
  commenters.sample(2).each do |commenter|
    create(:comment, post: post, user: commenter)
  end
end

# 投稿に対してランダムに「いいね」
posts = Post.all
users.each do |user|
  liked_posts = posts.sample(rand(3..7))
  liked_posts.each do |post|
    create(:like, user: user, post: post)
  end
end

posts.update!(created_at: rand(1..30).days.ago)


puts "✅ ユーザー数: #{User.count}"
puts "✅ 投稿数: #{Post.count}"
puts "✅ コメント数: #{Comment.count}"
puts "✅ フォロー関係数: #{Follow.count}" if defined?(Follow)
puts "✅ いいね数: #{Like.count}" if defined?(Like)

