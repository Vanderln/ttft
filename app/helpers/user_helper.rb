def current_user
  User.where(:id => session[:user_id]).first
end

def find_available_games
  games = User.where(:logged_in => true).map do |u|
    u.created_games.where(:joiner_id => nil)
  end
  games.flatten
end
