require './piece.rb'

class Board

  def initialize
    @board = Array.new(8) { Array.new(8) }
    setup #remove after done testing
  end

  def setup
    (0..7).each do |row_num|
      next if row_num == 3 || row_num == 4
      offset = (row_num % 2 == 0) ? 1 : 0 #determine offset
      create_row(row_num,"R",offset) if row_num < 3 #red is first 3 rows
      create_row(row_num,"W",offset) if row_num > 4 #white is last 3 rows
    end

    render_board
  end

  def create_row(row_num, color, offset = 0)
    4.times do |col|
      @board[row_num][col*2+offset] = Piece.new(color, self)
    end
  end

  def render_board
    (0..7).each do |i|
      (0..7).each do |j|
        print (@board[i][j].nil?) ? "_" : @board[i][j].color
      end
      print "\n"
    end
    "success"
  end

  def dup

  end

  def remove_piece
  end

end

#for testing in terminal
if __FILE__ == $PROGRAM_NAME
  brd = Board.new
end