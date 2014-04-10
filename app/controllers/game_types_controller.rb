class GameTypesController < ApplicationController
  def index
  	# Should return data for all game types.
    render :json => GameType.all.to_json
  end
  
  def show
  	# Should return the data for the given game type id.
    render :json => GameType.find(params[:id])
  end
  
  def update
  	# Should accept new data for given game type, alter it (save it) and return it.
    game_type = GameType.find(params[:id])
    if game_type.update_attributes(
        :name => params[:name] 
      )
      # handle a successful save
      render :json => game_type.to_json
    else
      render :json => {:message => 'Required information missing.  Update unsuccessful.'}, :status => :bad_request
    end
  end

  def create
  	# Should accept new data for a new game type, save it, and return it.
    game_type = GameType.create(
      :name => params[:name]
    )
    if game_type.save
      # handle a successful save
      render :json => game_type.to_json
    else
      render :json => {:message => 'Required information missing.  New player was not created.'}, :status => :bad_request
    end
  end
end
