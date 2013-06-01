  get "/lobby" do
  @games = find_available_games
  @error = session[:error]
  erb :lobby
end

get "/create_game" do
  game = Game.create(:creator_id => current_user.id, :turn_id => current_user.id)
  redirect "/game/#{game.id}"
end

get "/game/:game_id" do
  @game = Game.find(params[:game_id])
  erb :game
end

get "/game/:game_id/join" do
  game = Game.find(params[:game_id])
  if game.creator != current_user
    session[:error] = nil
    game.joiner_id = current_user.id
    game.save
    redirect "/game/#{game.id}"
  else
    session[:error] = "You can't join your own game, muthafucka."
    redirect '/lobby'
  end
end

post "/game/:game_id/update" do
  @game = Game.find(params[:game_id])
  @game.creator.id == params[:turn_id].to_i ? new_turn = @game.joiner_id : new_turn = @game.creator.id
  @game.update_attributes(:board => params[:board], :turn_id => new_turn)
  erb :game
end

get "/game/:game_id/status" do
  game = Game.find(params[:game_id])
  content_type :json
  {"board" => game.board, "turn_id" => game.turn_id}.to_json
end
