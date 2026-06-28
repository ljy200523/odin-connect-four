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

class Board
  def initialize
    @board = Array.new(6) { Array.new(7, "") } #6 rows, 7 columns
  end
  def print_board
    @board.each do |row|
      formatted_row = row.map do |slot|
        case slot
        when "red" then "🔴"
        when "yellow" then "🟡"
        else "⚪"
        end
      end
      puts formatted_row.join(" ")
    end
    puts " 0  1  2  3  4  5  6"
  end
  def insert_token(col, colour)
    lowest = nil
    @board.each_with_index do |row, index|
      if @board[index][col] == ""
        lowest = index
      end
    end
    @board[lowest][col] = colour
  end
  def check_token_position(col, colour)
    lowest = nil
    @board.each_with_index do |row, index|
      if @board[index][col] == ""
        lowest = index
      end
    end
    lowest == nil ? false : true
  end
  def check_win
    @board.each_with_index do |row, ridx|
      row.each_with_index do |column, cidx|

        next if column == ""

        return true if check_horizontal?(ridx, cidx)
        return true if check_vertical?(ridx, cidx)
        return true if check_diagonal_up?(ridx, cidx)
        return true if check_diagonal_down?(ridx, cidx)
      end
    end
    return false
  end
  def check_horizontal?(row, col)
    return false if col > 3
    @board[row][col] == @board[row][col+1] && @board[row][col] == @board[row][col+2] && @board[row][col] == @board[row][col+3]
  end
  def check_vertical?(row, col)
    return false if row > 2
    @board[row][col] == @board[row+1][col] && @board[row][col] == @board[row+2][col] && @board[row][col] == @board[row+3][col]
  end
  def check_diagonal_up?(row, col)
    return false if row > 2 || col > 3
    @board[row][col] == @board[row+1][col+1] && @board[row][col] == @board[row+2][col+2] && @board[row][col] == @board[row+3][col+3]
  end
  def check_diagonal_down?(row, col)
    return false if row < 3 || col > 3
    @board[row][col] == @board[row-1][col+1] && @board[row][col] == @board[row-2][col+2] && @board[row][col] == @board[row-3][col+3]
  end
  def check_full
    if @board.flatten.all? { |element| element.match?(/\w/) }
      return true
    else
      return false
    end
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


