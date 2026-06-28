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
