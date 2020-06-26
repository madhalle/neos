require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative 'near_earth_objects'

class NearEarthObjectsTest < Minitest::Test

  def setup
    @neos = NearEarthObjects.new('2019-03-30')
  end

  def test_a_date_returns_a_list_of_neos
    results = NearEarthObjects.find_neos_by_date('2019-03-30')
    assert_equal '(2019 GD4)', results[:asteroid_list][0][:name]
  end

  def test_it_has_attributes
    assert_equal '2019-03-30', @neos.date
  end

  def test_neos_results
    results = NearEarthObjects.find_neos_by_date('2019-03-30')
    assert_equal Hash, results.class
    assert_equal 3, results.length
  end
  # def test_largest_asteroid_diameter
  #   require "pry"; binding.pry
  #   @neos.formatted_asteroid_data
  # end
  #
  # skip def test_formatted_asteroid_data
  #   # code
  # end
  #
  # skip def test_total_number_of_asteroids
  #   # code
  # end

end
