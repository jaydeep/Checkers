require './board.rb'

class Piece

  def initialize(color, board)
    @color = color
    @board = board
    @king  = false
  end

  def slide_moves
    #moves one place
  end

  def jump_moves
    #jumps and kills
  end

  def perform_slide
    #validates slide_moves
    #illegal move should raise an InvalidMoveError
  end

  def perform_jump
    #validate jump_moves
    #illegal move should raise an InvalidMoveError

    #remove_jumped piece from board
  end

  def perform_moves!(move_sequence)
    #takes a sequence of moves. Move can be one or many
    #Performs moves one at a time,  Invalid MoveError should be raised
    #don't worry about restoring Board state if move sequence fails
  end

  def valid_move_seq?
    #dup the board
    #call perform_moves on duped board
    #return true if no eroror is raised
    #else return false
  end

  def perform_moves
    #checks valid_move_seq, and calls perform_moves! or raises an MoveError
  end
end