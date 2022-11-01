module Formatable # formatting text and screen in program
  def joinor(arr, punct=', ', conj='or')
    if arr.length == 1
      arr[0].to_s
    elsif arr.length == 2
      arr[0].to_s + ' ' + conj + ' ' + arr[1].to_s
    else
      arr[-1] = "#{conj} #{arr.last}"
      arr.join(punct)
    end
  end

  def prompt(text)
    puts ">> #{text}"
  end

  def clear
    system 'clear'
  end
end

module Chooseable # all set up choices for the game
  def set_name
    if @type == 'human'
      set_user_name
    else
      set_computer_name
    end
  end

  def set_user_name
    n = ''
    loop do
      prompt "Please enter your name:"
      n = gets.chomp.strip
      break unless n.empty?
      prompt "Sorry, must enter a value."
    end
    n.capitalize
  end

  def set_computer_name
    computer_names = ['BB-8', 'Karen', 'Compy 386', 'J.A.R.V.I.S.', 'BMO']
    n = ''
    loop do
      prompt "Please enter a name for your opponent (or 'rnd' for random name):"
      n = gets.chomp.strip
      n = computer_names.sample if n == 'rnd' || n.downcase == 'random'
      break unless n.empty?
      prompt "Sorry, must enter a value."
    end
    n
  end

  def set_marker
    n = ''
    loop do
      prompt "Would you like your marker to be X or O?"
      n = gets.chomp.strip.capitalize
      n = 'O' if n == '0'
      break if ['X', 'O'].include? n
      prompt "Sorry, must enter an X or an O."
    end
    n
  end

  def first_move
    n = ''
    loop do
      prompt "Who will go first, the player(p), the computer(c), or random(r)?"
      n = gets.chomp.strip.downcase[0]
      break if ['p', 'c', 'r'].include? n
      prompt "Sorry, that entry is invalid."
    end
    return [true, false].sample if n == 'r'
    n == 'p'
  end

  def play_again?
    answer = nil
    loop do
      prompt "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase[0]
      break if %w(y n).include? answer
      prompt "Sorry, entry must be y or n"
    end

    answer == 'y'
  end
end

module Displayable # all TTG display methods to improve class navigability
  def display_welcome_message
    title
    instructions
  end

  def title
    puts ' ____  __  ___     ____  __    ___     ____  __  ____'
    puts '(_  _)(  )/ __)___(_  _)/ _\  / __)___(_  _)/  \(  __)'
    puts '  )(   )(( (__(___) )( /    \( (__(___) )( (  O )) _)'
    puts ' (__) (__)\___)    (__)\_/\_/ \___)    (__) \__/(____)'
    puts ' '
  end

  # rubocop:disable Metrics/MethodLength
  def instructions
    prompt "Welcome to Tic Tac Toe!"
    prompt "Whoever gets three in a row first, wins the game."
    prompt "Whoever wins three games, wins the match."
    prompt "You can choose whether to be X or O."
    prompt "The numbers 1-9 correspond with the following squares:"
    puts ""
    puts " 1 | 2 | 3 "
    puts "---+---+---"
    puts " 4 | 5 | 6"
    puts "---+---+---"
    puts " 7 | 8 | 9"
    puts
    sleep(3)
    prompt "Hit enter to continue:"
    gets
    system 'clear'
  end
  # rubocop:enable Metrics/MethodLength

  def display_goodbye_message
    prompt "Thank you for playing Tic Tac Toe. Goodbye!"
    sleep(5)
  end

  def display_board
    puts "#{return_marker(human)} #{return_marker(computer)}"
    puts ""
    board.draw
    puts ""
  end

  def return_marker(object)
    "#{object.name} is #{object.marker}."
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def display_result
    if @human_score > @computer_score
      prompt "#{human.name} won the match!"
    else
      prompt "#{computer.name} wins the match!"
    end
  end

  def display_round
    @game_number += 1
    puts ''
    prompt "Round #{game_number}, begin!"
    sleep(2)
  end

  def display_round_winner
    clear_screen_and_display_board
    case board.winning_marker
    when human.marker
      prompt "#{human.name} won the round!"
    when computer.marker
      prompt "#{computer.name} won the round!"
    else
      prompt "It's a tie!"
    end
  end

  def display_score
    prompt "The score is:"
    puts "       #{human.name}: #{human_score}"
    puts "       #{computer.name}: #{computer_score}"
    sleep(4)
  end

  def display_play_again_message
    prompt "Let's play again!"
    puts " "
  end
end

class Board
  attr_reader :squares

  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                  [[1, 5, 9], [3, 5, 7]]              # diagonals
  def initialize
    @squares = {}
    reset
  end

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def center_open?
    squares[5].unmarked?
  end

  def someone_won_round?
    !!winning_marker
  end

  # returns winning marker or nil
  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      return squares.first.marker if three_identical_markers?(squares)
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def draw
    puts "       |       |"
    puts "   #{@squares[1]}   |   #{@squares[2]}   |   #{@squares[3]}"
    puts "       |       |"
    puts "-------+-------+-------"
    puts "       |       |"
    puts "   #{@squares[4]}   |   #{@squares[5]}   |   #{@squares[6]}"
    puts "       |       |"
    puts "-------+-------+-------"
    puts "       |       |"
    puts "   #{@squares[7]}   |   #{@squares[8]}   |   #{@squares[9]}"
    puts "       |       |"
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end
end

class Square
  INITIAL_MARKER = ' '
  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  include Chooseable, Formatable

  attr_reader :name
  attr_accessor :marker

  def initialize(marker, type)
    @marker = marker
    @type = type
    @name = set_name
  end
end

class TTTGame
  include Formatable, Chooseable, Displayable

  X_MARKER = 'X'
  O_MARKER = 'O'
  @@player_first = true

  attr_reader :board, :human, :computer
  attr_accessor :game_number, :human_score, :computer_score, :current_player

  def initialize
    @board = Board.new
    @human = Player.new(X_MARKER, 'human')
    @computer = Player.new(O_MARKER, 'computer')
    @current_player = @human
  end

  def play
    clear
    display_welcome_message
    main_game
    display_goodbye_message
  end

  private

  def main_game
    loop do
      play_match
      display_result
      break unless play_again?
      reset
      display_play_again_message
    end
  end

  def play_match
    new_match
    loop do
      clear_screen_and_display_board
      @current_player = (@@player_first ? human : computer)
      play_round
      @@player_first = !@@player_first
      break if someone_won?
      display_round
      reset
    end
  end

  def play_round
    player_move
    keep_score
    display_round_winner
    display_score
  end

  def player_move
    loop do
      current_player_moves
      break if board.someone_won_round? || board.full?
      clear_screen_and_display_board if human_turn?
    end
  end

  def new_match
    @game_number = 1
    @human_score = 0
    @computer_score = 0
    marker = set_marker
    if marker == 'O'
      human.marker, computer.marker = computer.marker, human.marker
    end
    @@player_first = first_move
  end

  def human_moves
    prompt "Choose a square (#{joinor(board.unmarked_keys)}): "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      prompt "Sorry, that entry is invalid."
    end

    board[square] = human.marker
  end

  def computer_moves
    computer_choice = vulnerable_squares
    if computer_choice == 0 && board.center_open?
      board[5] = computer.marker
    elsif computer_choice != 0
      board[computer_choice] = computer.marker
    else
      board[board.unmarked_keys.sample] = computer.marker
    end
  end

  def vulnerable_squares
    offence_square = analyze_lines(computer)
    defence_square = analyze_lines(human)
    offence_square == 0 ? defence_square : offence_square
  end

  def analyze_lines(player)
    Board::WINNING_LINES.each do |line|
      line_values = board.squares.values_at(*line).map(&:marker)
      if find_vulnerability(line_values, player)
        return line[line_values.index(Square::INITIAL_MARKER)]
      end
    end
    0
  end

  def find_vulnerability(line_values, player)
    line_values.count(player.marker) == 2 &&
      line_values.count(Square::INITIAL_MARKER) == 1
  end

  def human_turn?
    @current_player == @human
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_player = @computer
    else
      computer_moves
      @current_player = @human
    end
  end

  def keep_score
    case board.winning_marker
    when human.marker
      @human_score += 1
    when computer.marker
      @computer_score += 1
    end
  end

  def someone_won?
    @human_score == 3 || @computer_score == 3
  end

  def reset
    board.reset
    clear
    @current_player = @human
  end
end

game = TTTGame.new
game.play
