class GamesController < ApplicationController

  # Returns to the client all games.
  def index
    render :json => Game.all().to_json
  end

  # Returns to the client a specific game.
  def show
    render :json => Game.find(params[:id])
  end

  # Creates a new game. TODO: add ranking algorithm.
  def create
    participants = JSON.parse(params[:participants], :symbolize_names => true)
    game = Game.create({
      :game_type => BSON::ObjectId(params[:game_type]),
      :date => Time.new, # TODO: can this be a default in the model?
      :participants => participants.map { |participant|
        Participant.new({
          :score => participant[:score],
          :players => participant[:players].map { |player|
            BSON::ObjectId(player)
          }
        })
      }
    })
    render :json => game.to_json
  end

  # Updates the details of a game. Not implemented in this iteration.
  def update
    # 1. Rewind the effects of this game on rankings.
    # 2. Save the changes to the game.
    # 3. Replay the game (and all following) to properly calculate rankings.
    render :nothing => true, :status => :not_implemented
  end

  # Returns to the client all of the games of the given game type.
  def by_game_type
    render :json => Game.where(game_type: params[:game_type_id])
  end

  # Returns to the client all of the games that took place on
  # the day of the provided datetime.
  def by_day
    require 'time'
    begin
      time = Time.parse(params[:datetime])
      render :json => Game.where(:date.gte => time.beginning_of_day, :date.lte => time.end_of_day)
    rescue
      render :text => 'Error parsing datetime.', :status => :bad_request
    end
  end

end
