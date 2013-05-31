class Game < ActiveRecord::Base
  
  belongs_to :creator, :class_name => "User", :foreign_key => :creator_id
  belongs_to :joiner, :class_name => "User", :foreign_key => :joiner_id

  validates :creator_id, :presence => :true

end
