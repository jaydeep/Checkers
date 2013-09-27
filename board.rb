require './piece.rb'

class Board
  attr_reader :board

  def initialize(board = "")
    @board = Array.new(8) { Array.new(8) }
    setup if board == ""
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
    # raise NilObjectError if @board[x][y].nil?
    @board[x][y]
  end

  def []=(pos, val)
    x,y = pos
    @board[x][y] = val
  end

  def move(move_sequence)
      start_pos = move_sequence[0]
      self[start_pos].perform_moves(move_sequence)
  end

  def move_piece(start_pos, end_pos)
    self[end_pos], self[start_pos] = self[start_pos], nil
  end

  def jump_piece(start_pos, end_pos)
    move_piece(start_pos, end_pos)
    #determine jumped piece
    jumped_x = (end_pos[0] + start_pos[0])/2
    jumped_y = (end_pos[1] + start_pos[1])/2
    #remove jumped piece
    self[[jumped_x, jumped_y]] = nil
  end

  def create_row(row_num, color, offset = 0)
    4.times do |col|
      @board[row_num][col*2+offset] = Piece.new(color, self)
    end
  end

  def render_board
    print "\n "; (0..7).each {|n| print " #{n}"};
    (0..7).each do |i|
      print "\n#{i} "
      (0..7).each do |j|
        print (@board[i][j].nil?) ? "\u25a2" : @board[i][j].display
        print " "
      end
    end
    print "\n\n\n"
  end

  def dup
    dup_board = Board.new("dup")

    (0..7).each do |i|
      (0..7).each do |j|
        next if @board[i][j].nil?
        piece = @board[i][j]
        dup_board[[i, j]] = piece.special_dup(dup_board)
      end
    end
    print "duplicate\n"
    dup_board.render_board
    dup_board
  end
end

#for testing in terminal
if __FILE__ == $PROGRAM_NAME
  begin
  brd = Board.new
  brd.move([ [2,3], [3,4] ])
  brd.render_board
  brd.move([ [3,4], [4,3] ])
  puts "back in board.rb"
  brd.render_board
  brd.move([ [1,2], [2,3] ])
  brd.render_board
  brd.move([ [5,2], [3,4], [1,2] ])
  brd.move([ [0,1], [2,3], [3,2] ])
  rescue NilObjectError => e
    puts "piece doesn't exist!"
  rescue InvalidMoveError => e
    puts "move not possible!"
  ensure
    brd.render_board
  end
end