# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# require "faker"
# puts 'Creating 20 movies...'
# 20.times do
#   movie = Movie.new(
#     title: Faker::Movie.title,
#     overview: Faker::Movie.quote,
#     poster_url: ,
#     rating:
#   )
#   movoe.save!
# end
# puts 'Finished!'

require "json"
require "rest-client"

response = RestClient.get "https://tmdb.lewagon.com/movie/top_rated"
repos = JSON.parse(response)['results']
repos_id_ten = repos.first(20)
puts 'Creating 20 movies...'

repos_id_ten.each do |movie|
  movie_url = "https://tmdb.lewagon.com/movie/#{movie['id'].to_s}"
  movie_response = RestClient.get(movie_url)
  movie_detail = JSON.parse(movie_response)

  movie = Movie.create!(
    title: movie_detail['original_title'],
    overview: movie_detail['overview'],
    poster_url: "https://image.tmdb.org/t/p/w500#{movie_detail['poster_path']}",
    rating: movie_detail['vote_average']
  )
  movie.save!
end
puts 'Finished!'
