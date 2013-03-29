class InstagramController < ApplicationController

	def index
		Instagram.configure do |config|
		  config.client_id = ENV['INSTAGRAM_APP_ID']
		  config.client_secret = ENV['INSTAGRAM_SECRET']
		end
		@link = Instagram.authorize_url(:redirect_uri => ENV['INSTAGRAM_REDIRECT'])
	end

	def hello
		response = Instagram.get_access_token(params[:code], :redirect_uri => ENV['INSTAGRAM_REDIRECT'])
	  session[:access_token] = response.access_token
    client = Instagram.client(:access_token => session[:access_token])
	  @feed = client.user_media_feed
	end

end
