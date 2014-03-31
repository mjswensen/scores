class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def index
    # The action that responds to the user's initial request.
    # The view for this action will serve up all of our Angular code.
  end

  # Temporary method that populates the database for development.
  def populateDb

    # TODO: Clear out the database.

    # Create and save game types

    foosball = GameType.create(:name => 'Foosball')
    ping_pong = GameType.create(:name => 'Ping Pong')

    # Create and save players

    roy = Player.create({
      :first_name => 'Roy',
      :nickname => 'Skull Crusher',
      :last_name => 'Matsunaga',
      :ranks => [ # TODO: modify the player constructor to query DB for all game types, and give them the default rank for each game type.
        Rank.new({
          :game_type => foosball.id,
          :rank => 10
        }),
        Rank.new({
          :game_type => ping_pong.id,
          :rank => 10
        })
      ]
    })

    morgan = Player.create({
      :first_name => 'Morgan',
      :nickname => 'The Professor',
      :last_name => 'Young',
      :ranks => [
        Rank.new({
          :game_type => foosball.id,
          :rank => 10
        }),
        Rank.new({
          :game_type => ping_pong.id,
          :rank => 10
        })
      ]
    })

    matt = Player.create({
      :first_name => 'Matt',
      :nickname => 'Slingshot',
      :last_name => 'Swensen',
      :ranks => [
        Rank.new({
          :game_type => foosball.id,
          :rank => 10
        }),
        Rank.new({
          :game_type => ping_pong.id,
          :rank => 10
        })
      ]
    })

    scoish = Player.create({
      :first_name => 'Scoish',
      :nickname => 'Velociraptor',
      :last_name => 'Maloish',
      :ranks => [
        Rank.new({
          :game_type => foosball.id,
          :rank => 10
        }),
        Rank.new({
          :game_type => ping_pong.id,
          :rank => 10
        })
      ]
    })

    # Create and save games

    Game.create({
      :game_type => foosball.id,
      :date => Time.new,
      :participants => [
        Participant.new({
          :score => 3,
          :players => [ matt.id ]
        }),
        Participant.new({
          :score => 5,
          :players => [ morgan.id ]
        })
      ]
    })

    Game.create({
      :game_type => ping_pong.id,
      :date => Time.new,
      :participants => [
        Participant.new({
          :score => 21,
          :players => [ morgan.id, roy.id ]
        }),
        Participant.new({
          :score => 15,
          :players => [ matt.id, scoish.id ]
        })
      ]
    })

    # redirect_to :action => 'index'
    render 'application/index'

  end
end
