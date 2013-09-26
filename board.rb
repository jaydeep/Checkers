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
      create_row(row_num, :black, offset) if row_num < 3 #red is first 3 rows
      create_row(row_num, :white, offset) if row_num > 4 #white is last 3 rows
    end

    render_board
  end

  def [](pos)
    x, y = pos
    raise NilObjectError if @board[x][y].nil?
    @board[x][y]
  end

  def []=(pos, val)
    x,y = pos
    @board[x][y] = val
  end

  def move_piece(start_pos, end_pos)
    self[end_pos], self[start_pos] = self[start_pos], nil
  end

  def jump_piece(start_pos, end_pos)
    move_piece(start_pos, end_pos)
    #determine jumped piece
    jumped_x = (end_pos[0] + start_pos[0])/2
    jumped_y = (end_pos[1] + start_pos[1])/2
    self[[jumped_x, jumped_y]] = nil
    p [jumped_x, jumped_y]
  end

  def create_row(row_num, color, offset = 0)
    4.times do |col|
      @board[row_num][col*2+offset] = Piece.new(color, self)
    end
  end

  def render_board
    print " "; (0..7).each {|n| print " #{n}"};
    (0..7).each do |i|
      print "\n#{i} "
      (0..7).each do |j|
        print (@board[i][j].nil?) ? "\u25a2" : @board[i][j].display
        print " "
      end
      # print "\n"
    end
    print "\n\n\n"
  end

  def dup

  end

  def remove_piece
  end

end

#for testing in terminal
if __FILE__ == $PROGRAM_NAME
  begin
  brd = Board.new
  brd.move_piece([2,3], [3,2])
  brd.render_board
  brd.move_piece([3,2], [4,3])
  brd.render_board
  p brd[[5,2]].possible_jump_moves([5,2])
  p brd[[5,4]].possible_jump_moves([5,4])
  p brd[[4,3]].possible_jump_moves([4,3])
  p brd[[5,2]].perform_jump([5,2], [3,4])
  brd[[4,3]].perform_jump([4,3],[5,2])
  rescue NilObjectError => e
    puts "piece doesn't exist!"
  rescue InvalidMoveError => e
    puts "move not possible!"
  ensure
    brd.render_board
  end
end