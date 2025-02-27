Audio.destroy_all
Slide.destroy_all
ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'audios'")
ActiveRecord::Base.connection.execute("DELETE from sqlite_sequence where name = 'slides'")


Dir[File.expand_path "db/seeds/*.rb"].each { |f| require_relative(f) }

Audio.create!(
  id: 1,
  transcription: "Hey, I want to buy a laptop for my son. He wants to be a gamer but he only plays Roblox. With time, he will want to play in more and more complex games. I don't want to spend more than 500 dollars. He must be able to do his homework as well!"
)

Audio.create!(
  id: 2,
  transcription: "Hey Gem, go to the left"
)

Audio.create!(
  id: 3,
  transcription: "Hey Gem, I would like you to jump"
)
