class Printer
  def spacer
    p "________________________________________________________________________________________________________________________________"
  end

  def welcome
    p "Welcome to NEO. Here you will find information about how many meteors, astroids, comets pass by the earth every day. \nEnter a date below to get a list of the objects that have passed by the earth on that day."
  end

  def date_prompt
    p "Please enter a date in the following format YYYY-MM-DD."
  end

  def carrots
    p ">>"
  end
end
