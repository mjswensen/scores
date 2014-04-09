class GamesController < ApplicationController
  # return a JSON object of all the games
  def index
    render :json => Game.all.to_json
  end
  
  # return a JSON object of all games of a specified game type
  def show
  	# check to see if search is by date or by game_type, and respond accordingly
  	if Game.where(game_type: params[:id]).count > 0
      render :json => Game.where(game_type: params[:id])
    else
      begin_time = Time.parse(params[:id]).beginning_of_day
      end_time = Time.parse(params[:id]).end_of_day
      render :json => Game.where(:date.gte => begin_time, :date.lte => end_time)
      # render :json => Game.where(date: params[:date])
    end
  end
  
  # create a new game for a given gametype
  def create
  	participants = params[:participants]
    game = Game.create(
      :game_type => params[:game_type],
      :date => Time.now,
      :participants => participants.each{|participant|
      	
      }
    )
  end
  
  # update a specific game

end
