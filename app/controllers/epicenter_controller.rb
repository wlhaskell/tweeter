class EpicenterController < ApplicationController
  
	before_filter :authenticate_user!, except: [:show_user]

  def feed
  	@following_tweets = []
  	Tweet.all.each do |tweet|
  		if current_user.following.include?(tweet.user_id)
  			@following_tweets.push(tweet)
  		end
  	end

    @tweet = Tweet.new
    
  end

  def show_user
  	@user = User.find(params[:id])
  end

  def now_following
  	current_user.following.push(params[:id].to_i)
  	current_user.save

  	redirect_to :back
  end

  def unfollow
  	current_user.following.delete(params[:id].to_i)
  	current_user.save

  	redirect_to :back
  end
end
