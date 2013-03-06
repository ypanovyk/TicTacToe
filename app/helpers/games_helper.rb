module GamesHelper

  def status(game)
    #"asdfadfsag--#{game.status}--#{game.whose_turn}"
    if game.status=="closed" 
      "Game finished. Winner - #{username(game.winner)}" 
    elsif game.status=="new"  
      "Waiting for opponent"
    elsif game.status=="active" && game.whose_turn==game.participant  
      "Waiting for opponent's turn"
    elsif game.status=="active" && game.whose_turn==game.creator  
      "Your turn"
    end
  end
end
