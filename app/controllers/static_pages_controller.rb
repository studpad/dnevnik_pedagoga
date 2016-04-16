class StaticPagesController < ApplicationController
	include SessionsHelper
  before_action :signed_in_user,
                only: [:home]

	def home
		if current_user.followed_users.count > 0
			@article = current_user.articles.build if logged_in?
			@feed_items = current_user.feed  if logged_in?
		else
			@users = User.all
		end
	end

	def help
	end
end
