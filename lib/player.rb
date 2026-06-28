class Player
  attr_reader :colour
  def initialize(colour)
    @colour = colour
  end
  def get_input
    loop do
      print "Give a column(0-6) for #{@colour}: "
      response = gets.chomp.to_i
      if validate_input(response)
        return response
      end
    end
  end
  def validate_input(input)
    if input >= 0 && input < 7
      true
    else
      false
    end
  end
end
