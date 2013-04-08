module GamesHelper

  def status(game)
    #"asdfadfsag--#{game.status}--#{game.whose_turn}"
    if game.status=="closed" 
      t :game_finished_status, username: username(game.winner) 
    elsif game.status=="new"  
      t :game_wait_opponent_status
    elsif game.status=="active" && game.whose_turn==game.participant  
      t :game_wait_turn_status
    elsif game.status=="active" && game.whose_turn==game.creator  
      t :game_your_turn_status
    end
  end
end
