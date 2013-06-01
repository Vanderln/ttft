10.times do 
  User.create(:username => Faker::Name.first_name, :password => "qwerty")
end

5.times do
  Game.create(:creator_id => [2,4,6,8,10].sample, :joiner_id => [1,3,5,7,9].sample)
end

5.times do
  Game.create(:creator_id => [2,4,6,8,10].sample)
end
