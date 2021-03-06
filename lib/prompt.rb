class Prompt
  def initialize(console:, board:, number_validator:)
    @console = console
    @board = board
    @number_validator = number_validator
    @valid_input = nil
  end

  def call
    @valid_input = nil

    until valid_input
      console.output('Please choose a space.')
      input = console.gets_input
      range = 1..9

      validate_input(input, range)
    end

    valid_input
  end

  private

  attr_reader :console, :board, :number_validator
  attr_accessor :valid_input

  def validate_input(input, range)
    valid_space_number = valid_space_number(input, range)

    if valid_space_number && board.available?(valid_space_number)
      self.valid_input = valid_space_number
    else
      console.output('Please enter a valid number.')
    end
  end

  def valid_space_number(input, range)
    Integer(input) if number_validator.valid?(input, range)
  end
end
