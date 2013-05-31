class User < ActiveRecord::Base
  
  include BCrypt

  has_many :created_games, :class_name => "Game", :foreign_key => :creator_id
  has_many :joined_games, :class_name => "Game", :foreign_key => :joiner_id

  validates :username, :presence => :true, :uniqueness => :true
  validates :password, :presence => :true

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(pass)
    @password = Password.create(pass)
    self.password_hash = @password
  end

  def self.authenticate(params)
    user = User.find_by_username(params[:username])
    (user && user.password == params[:password]) ? user : nil
  end

end
