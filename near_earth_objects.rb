require 'faraday'
require 'figaro'
require 'pry'
require 'json'
# Load ENV vars via Figaro
Figaro.application = Figaro::Application.new(environment: 'production', path: File.expand_path('../config/application.yml', __FILE__))
Figaro.load

class NearEarthObjects
  def self.largest_astroid_diameter
        @@asteroidguys.map do |astroid|
        astroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i
      end.max { |a,b| a<=> b}
  end

  def self.formatted_asteroid_data
       @@asteroidguys.map do |astroid|
      {
        name: astroid[:name],
        diameter: "#{astroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i} ft",
        miss_distance: "#{astroid[:close_approach_data][0][:miss_distance][:miles].to_i} miles"
      }
    end
  end

  def self.total_number_of_astroids
    @@asteroidguys.count
  end

  def self.find_neos_by_date(date)
    NearEarthObjects.new(date)
    {
      asteroid_list: formatted_asteroid_data,
      biggest_astroid: largest_astroid_diameter,
      total_number_of_astroids: total_number_of_astroids
    }
  end

  attr_reader :date
  def initialize(date)
    @date = date
    @@asteroidguys ||= parsed_asteroids_data
  end

  def asteroids_list_data
    conn = Faraday.new(
      url: 'https://api.nasa.gov',
      params: { start_date: @date, api_key: ENV['nasa_api_key']}
    )
    conn.get('/neo/rest/v1/feed')
  end

  def parsed_asteroids_data
    JSON.parse(asteroids_list_data.body, symbolize_names: true)[:near_earth_objects][:"#{@date}"]
  end
end






# conn = Faraday.new(
#   url: 'https://api.nasa.gov',
#   params: { start_date: date, api_key: ENV['nasa_api_key']}
# )
# asteroids_list_data = conn.get('/neo/rest/v1/feed')


# largest_astroid_diameter = parsed_asteroids_data.map do |astroid|
#   astroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i
# end.max { |a,b| a<=> b}

# formatted_asteroid_data = parsed_asteroids_data.map do |astroid|
#   {
#     name: astroid[:name],
#     diameter: "#{astroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i} ft",
#     miss_distance: "#{astroid[:close_approach_data][0][:miss_distance][:miles].to_i} miles"
#   }
# end
