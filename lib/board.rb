require 'pry'

class Board
  attr_accessor :values
  attr_reader :outcome_checker

  def initialize(outcome_checker:)
    @outcome_checker = outcome_checker
    @values = (1..9).to_a
  end

  def get_space(row, column)
    index = (row * dimension) + column
    values[index]
  end

  def mark_space(token, space)
    values[space - 1] = token
  end

  def full?
    open_board = (1..values.length).to_a
    open_spaces = values & open_board
    open_spaces.empty?
  end

  def available?(input)
    space = values[input - 1]
    space.is_a?(Integer)
  end

  def has_win?
    outcome_checker.win?(self)
  end

  def has_draw?
    outcome_checker.draw?(self)
  end

  def lines
    rows + columns + diagonals
  end

  private

  def rows
    values_grid
  end

  def columns
    values_grid.transpose
  end

  def diagonals
    [left_diagonal, right_diagonal]
  end

  def dimension
    Math.sqrt(values.length).to_i
  end

  def max_index
    values.length - 1
  end

  def values_grid
    grid = []
    values.each_slice(dimension) { |row| grid << row }
    grid
  end

  def left_diagonal
    index_range = 0..max_index
    divisor = dimension + 1
    diagonal_values(index_range, divisor)
  end

  def right_diagonal
    index_range = (dimension - 1)..(max_index - 1)
    divisor = dimension - 1
    diagonal_values(index_range, divisor)
  end

  def diagonal_values(index_range, divisor)
    diagonal_indices = index_range.filter { |index| (index % divisor).zero? }
    diagonal_indices.map { |index| values[index] }
  end
end
