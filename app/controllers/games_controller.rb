class GamesController < ApplicationController

  # Returns to the client all games.
  def index
    render :json => Game.all().to_json
  end

  # Returns to the client a specific game.
  def show
    render :json => Game.find(params[:id])
  end

  # Creates a new game.
  def create
    participants = JSON.parse(params[:participants], :symbolize_names => true)
    # Save the game.
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
    # Calculate and save the new ranks:
    # Winners take 5% of the losers' rank, divided proportionally.
    # Step one: calculate the total amount of the exchange.
    participants.sort! { |a, b|
      b[:score] <=> a[:score]
    }
    winners = Player.find(participants[0][:players])
    losers = Player.find(participants[1][:players])
    winners_total = winners.reduce(0) { |memo, winner|
      memo += winner.ranks.reduce(0) { |mimo, rank|
        if rank.game_type.to_s == params[:game_type]
          mimo + rank.rank
        else
          mimo
        end
      }
    }
    losers_total = losers.reduce(0) { |memo, loser|
      memo += loser.ranks.reduce(0) { |mimo, rank|
        if rank.game_type.to_s == params[:game_type]
          mimo + rank.rank
        else
          mimo
        end
      }
    }
    exchange = (losers_total * 0.05).round
    # Step two: award exchange to the winners proportionately
    winners.each { |winner|
      winner.ranks.each { |rank|
        if rank.game_type.to_s == params[:game_type]
          rank.rank += (rank.rank / winners_total.to_f * exchange).round
          rank.save!
        end
      }
    }
    # Step three: penalize exchange to losers proportionately
    losers.each { |loser|
      loser.ranks.each { |rank|
        if rank.game_type.to_s == params[:game_type]
          rank.rank -= (rank.rank / losers_total.to_f * exchange).round
          rank.save!
        end
      }
    }
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
