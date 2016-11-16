class HumanPlayer
  def prompt
    puts "Enter a position"
  end

  def get_input(board)
    gets.chomp.scan(/\d+/).map(&:to_i)
  end

  def receive(face_value)
  end
end

class ComputerPlayer
  # computer player is broken :(
  def initialize
    @known_cards = Hash.new { |h, k| h[k] = [] }
    @matched_cards = []
    @last_guess = nil
    @first_guess = true
    @queue = []
    @coordinates = nil
  end

  def prompt
  end

  def get_input(board)
    @coordinates ||= populate_coordinates(board.size)

    matching_cards

    if @queue.empty?
      guess = @last_guess = random_guess
    else
      guess = @last_guess = @queue.shift
    end

    if !@queue.empty? && !@first_guess
      guess = @queue.reject { |pos| pos == @last_guess }.first
      @queue = []
    end

    switch_guess

    guess
  end

  def switch_guess
    @first_guess = !@first_guess
  end

  def matching_cards
    @known_cards.each do |key, positions|
      @queue = positions if positions.size == 2
      matched_cards << positions
      @known_cards.delete(key)
    end
  end

  def receive(face_value)
    @known_cards[face_value] << @last_guess
  end

  def random_guess
    (@coordinates - visited_cards).sample
  end

  def visited_cards
    known_cards.values.flatten(1) + matched_cards.flatten(1)
  end

  def populate_coordinates(dimensions)
    rows, cols = dimensions
    rows.times do |row|
      cols.times do |col|
        @coordinates << [row, col]
      end
    end
  end
end
