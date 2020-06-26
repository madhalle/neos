require_relative 'near_earth_objects'
require_relative './lib/printer'

printer = Printer.new
printer.welcome_message

date = gets.chomp
astroid_details = NearEarthObjects.find_neos_by_date(date)
asteroid_list = astroid_details[:asteroid_list]
total_number_of_astroids = astroid_details[:total_number_of_astroids]
largest_astroid = astroid_details[:biggest_astroid]

column_labels = { name: "Name", diameter: "Diameter", miss_distance: "Missed The Earth By:" }
column_data = column_labels.each_with_object({}) do |(col, label), hash|
  hash[col] = {
    label: label,
    width: [asteroid_list.map { |astroid| astroid[col].size }.max, label.size].max}
end

header = "| #{ column_data.map { |_,col| col[:label].ljust(col[:width]) }.join(' | ') } |"
divider = "+-#{column_data.map { |_,col| "-"*col[:width] }.join('-+-') }-+"

#formatter
def format_row_data(row_data, column_info)
  row = row_data.keys.map { |key| row_data[key].ljust(column_info[key][:width]) }.join(' | ')
  puts "| #{row} |"
end

def create_rows(astroid_data, column_info)
  rows = astroid_data.each { |astroid| format_row_data(astroid, column_info) }
end

formated_date = DateTime.parse(date).strftime("%A %b %d, %Y")
#printer
puts "______________________________________________________________________________"
puts "On #{formated_date}, there were #{total_number_of_astroids} objects that almost collided with the earth."
puts "The largest of these was #{largest_astroid} ft. in diameter."
puts "\nHere is a list of objects with details:"
puts divider
puts header
create_rows(asteroid_list, column_data)
puts divider
