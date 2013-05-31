get "/lobby" do
  erb :lobby
end

get "/create_game" do
  game = Game.create(:creator_id => current_user.id)
  redirect "/game/#{game.id}"
end

get "/game/:game_id" do
  @game = Game.find(params[:game_id])
  erb :game
end

get "/game/:game_id/join" do
  game = Game.find(params[:game_id])
  if game.creator != current_user
    game.joiner_id = current_user.id
    redirect "/game/#{game.id}"
  else
    @errors = "You can't join your own game, muthafucka."
    erb :lobby
  end
end
