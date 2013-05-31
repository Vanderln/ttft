get '/' do
  erb :index
end

post "/login" do
  user = User.authenticate(params[:user])
  if user
    user.update_attributes(:logged_in => true)
    session[:user_id] = user.id
    redirect "/lobby"
  else
    @errors = "You logged in wrong. Muthafucka."
    erb :index
  end
end

post "/signup" do
  user = User.create(params[:user])
  if user.save
    session[:user_id] = user.id
    redirect "/lobby"
  else
    @errors = "You signed up wrong. Muthafucka."
    erb :index
  end
end

get "/user/:user_id" do 
  @user = User.find(params[:user_id])
  erb :user
end

get "/logout" do
  User.find(current_user.id).update_attributes(:logged_in => false)
  session.clear
end
