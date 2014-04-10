class GamesController < ApplicationController

  # Returns to the client all games.
  def index
    render :json => Game.all().to_json
  end

  # Returns to the client a specific game.
  def show
    render :json => Game.find(params[:id])
  end

  # Creates a new game. TODO: still working on this.
  def create
    # participants = JSON.parse params[:participants]
    # render :json => participants.to_json
    # game = Game.create({
    #   :game_type => params[:game_type],
    #   :date => Time.new,
    #   :participants => participants.map { |participant|
    #     Participant.new({
    #       :score => participant[:score],
    #       :players => participant[:players].map { |player| ObjectId.new(player) }
    #     })
    #   }
    # })
    # participants.map { |participant|
      # render :text => participant[:players].to_json and return
      # participant[:players].map { |player|
      #   render :json => player.to_json and return
      # }
      # render :json => participant.to_json and return
    # }
    # render :json => game.to_json
    # render :json => params
    render :nothing => true, :status => :not_implemented
  end

  # Updates the details of a game. Not implemented in this iteration.
  def update
    # 1. Rewind the effects of this game on rankings.
    # 2. Save the changes to the game.
    # 3. Replay the game (and all following) to properly calculate rankings.
    render :nothing => true, :status => :not_implemented
  end

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
