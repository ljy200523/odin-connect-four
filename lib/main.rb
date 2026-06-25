class Player
  attr_reader :colour
  def initialize(colour)
    @colour = colour
  end
  def get_input
    loop do
      print "Give a column(1-7) for #{@colour}: "
      response = gets.chomp.to_i
      if validate_input(response)
        return response
      end
    end
  end
  def validate_input(input)
    if input > 0 && input < 8
      true
    else
      false
    end
  end
end

class Board
  def initialize
    @board = Array.new(7) { Array.new(6, "") }
  end
  def print_board
    @board.each { |row| p row }
  end
  def insert_token(row, col, colour)
    @board[row][col] = colour
  end
end

class ConnectFour
  attr_accessor :board
  def initialize
    @player_one = Player.new("red")
    @player_two = Player.new("yellow")
    @board = Board.new
  end
  def play
    @board.print_board
    @player_one.get_input
    @board.insert_token(1, 2, red)
  end
end

if __FILE__ == $0 # "$0" is the name of file that starts Ruby process
  connect_four = ConnectFour.new
  player = Player.new("red")
  player.get_input
end


