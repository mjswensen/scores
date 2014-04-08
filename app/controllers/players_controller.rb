class PlayersController < ApplicationController

  # display a list of all players
  def index
    render :json => Player.all.to_json
  end

  # create a new player
  def create
    player = Player.create(
      :first_name => params[:first_name], 
      :last_name => params[:last_name], 
      :nickname => params[:nickname], 
      :active => true, 
      :ranks => GameType.all.map{|game_type|
      	Rank.new({
          :game_type => game_type.id
      	})
      }
    )
    if player.save
      # handle a successful save
      render :json => player.to_json
    else
      render :json => {:message => 'Required information missing.  New player was not created.'}, :status => :bad_request
    end
  end

  # display a specific player
  def show
    render :json => Player.find(params[:id]).to_json
  end

  # update a specific player
  def update
  	player = Player.find(params[:id])
    if player.update_attributes(
        :first_name => params[:first_name], 
        :last_name => params[:last_name], 
        :nickname => params[:nickname], 
        :active => params[:active], 
      )
      # handle a successful save
      render :json => player.to_json
    else
      render :json => {:message => 'Required information missing.  Update unsuccessful.'}, :status => :bad_request
    end
  end
end