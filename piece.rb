require './board.rb'

class Piece
  attr_reader :color, :king

  def initialize(color, board)
    @color = color
    @board = board
    @king  = false
  end

  def display
    # color.to_s[0].upcase #return "W" or "R"
    return "\u26ab" if color == :black
    return "\u26aa" if color == :white
  end

  def get_move_dirs
  y_dir = (color == :black) ? 1 : -1 #return y_dir based on color
  [ [y_dir, -1], [y_dir, 1] ]
  end

  def pos_within_range?(pos)
    pos.all? { |coord| coord.between?(0,7) }
  end

  def possible_slide_moves(current_pos)
    poss_slide_moves = []
    x, y = current_pos
    #moves one place
    #based on direction, can move towards one of two diagonals

    #1. get diagonals
    move_dirs = get_move_dirs

    move_dirs.each do |move_dir|
      dx, dy = move_dir
      #2. add diagonals to current_pos
      new_x = x + dx
      new_y = y + dy
      new_pos = [new_x, new_y]
      #3. ensure that new_pos is within range and #4. ensure that spot is nil
      if pos_within_range?(new_pos) && @board[new_pos].nil?
        poss_slide_moves << new_pos
      end
    end
    #5. return the possible slide moves
    raise InvalidMoveError if poss_slide_moves.empty?
    poss_slide_moves
  end

  def possible_jump_moves
    #find opportunities to kill
  end

  # def perform_slide
  #   #validates slide_moves
  #   #illegal move should raise an InvalidMoveError
  # end

  # def perform_jump
  #   #validate jump_moves
  #   #illegal move should raise an InvalidMoveError

  #   #remove_jumped piece from board
  # end

  # def perform_moves!(move_sequence)
  #   #takes a sequence of moves. Move can be one or many
  #   #Performs moves one at a time,  Invalid MoveError should be raised
  #   #don't worry about restoring Board state if move sequence fails
  # end

  # def valid_move_seq?
  #   #dup the board
  #   #call perform_moves on duped board
  #   #return true if no eroror is raised
  #   #else return false
  # end

  # def perform_moves
  #   #checks valid_move_seq, and calls perform_moves! or raises an MoveError
  # end
end