require_relative "board"
require_relative "player"

class ConnectFour
  attr_accessor :board
  def initialize
    @player_one = Player.new("red")
    @player_two = Player.new("yellow")
    @board = Board.new
  end
  def play
    loop do
      @board.print_board
      take_turn(@player_one)
      p @board.check_win
      p @board.check_full
      break if check_end

      @board.print_board
      take_turn(@player_two)
      p @board.check_win
      p @board.check_full
      break if check_end
    end
  end

  def take_turn(player)
    loop do
      input_one = player.get_input
      if @board.check_token_position(input_one, player.colour)
        @board.insert_token(input_one, player.colour)
        break
      else
        puts "That column is full, try another column"
      end
    end
  end

  def check_end
    if @board.check_win
      @board.print_board
      puts "A player has won the game"
      return true
    elsif @board.check_full
      @board.print_board
      puts "The game is a draw"
      return true
    end
    return false
  end
end

if __FILE__ == $0 # "$0" is the name of file that starts Ruby process
  connect_four = ConnectFour.new
  connect_four.play
end


