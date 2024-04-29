INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                [[1, 5, 9], [3, 5, 7]]              # diagonals

def title
  puts ' ____  __  ___     ____  __    ___     ____  __  ____'
  puts '(_  _)(  )/ __)___(_  _)/ _\  / __)___(_  _)/  \(  __)'
  puts '  )(   )(( (__(___) )( /    \( (__(___) )( (  O )) _)'
  puts ' (__) (__)\___)    (__)\_/\_/ \___)    (__) \__/(____)'
  puts ' '
end

def instructions
  quick_prompt "Welcome to Tic Tac Toe!"
  quick_prompt "Whoever gets three in a row first, wins."
  quick_prompt "You will be the X, the computer will be the O."
  quick_prompt "The numbers 1-9 correspond with the following squares:"
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

def prompt(msg)
  puts ">> #{msg}"
  sleep(2)
end

def quick_prompt(msg)
  puts ">> #{msg}"
end

# rubocop:disable Metrics/AbcSize
def display_board(brd)
  system 'clear'
  puts "You are #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}."
  puts ""
  puts "       |       |"
  puts "   #{brd[1]}   |   #{brd[2]}   |   #{brd[3]}"
  puts "       |       |"
  puts "-------+-------+-------"
  puts "       |       |"
  puts "   #{brd[4]}   |   #{brd[5]}   |   #{brd[6]}"
  puts "       |       |"
  puts "-------+-------+-------"
  puts "       |       |"
  puts "   #{brd[7]}   |   #{brd[8]}   |   #{brd[9]}"
  puts "       |       |"
  puts ""
end
# rubocop: enable Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def player_place_piece!(brd)
  square = ''
  loop do
    quick_prompt "Choose a square (#{joinor(empty_squares(brd))}):"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    quick_prompt "Sorry, that is an invalid choice."
  end

  brd[square] = PLAYER_MARKER
end

def computer_place_piece!(brd)
  square = 0
  square = computer_move(square, brd)

  square = 5 if square == 0 && brd[5] == INITIAL_MARKER
  square = empty_squares(brd).sample if square == 0

  brd[square] = COMPUTER_MARKER
end

# rubocop:disable Metrics/CyclomaticComplexity
def computer_move(square, brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 2
      line.each { |num| square = num if brd[num] == INITIAL_MARKER }
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 2
      line.each { |num| square = num if brd[num] == INITIAL_MARKER }
    end
  end
  square
end
# rubocop:enable Metrics/CyclomaticComplexity

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def joinor(array, punct = ', ', conj = 'or')
  if array.length == 2
    array[0].to_s + ' ' + conj + ' ' + array[1].to_s
  elsif array.length == 1
    array[0].to_s
  else
    array[-1] = "#{conj} #{array.last}"
    array.join(punct)
  end
end

def who_goes_first?(input)
  if input.downcase.start_with?('y') == false
    first_turn
  else
    answer = nil
    loop do
      prompt "Who will go first, the player or the computer? (p, c)"
      answer = gets.chomp
      break if answer.start_with?('p', 'c')
      prompt "Sorry, that is an invalid choice."
    end
    answer.start_with?('c') ? false : true
  end
end

def first_turn
  first = ['player', 'computer'].sample
  if first == 'computer'
    prompt "The computer will go first."
    false
  else
    prompt "The player will go first."
    true
  end
end

def alternate_player(player)
  !player
end

def place_piece!(brd, player)
  if player
    player_place_piece!(brd)
  else
    computer_place_piece!(brd)
  end
end

title
instructions

loop do
  quick_prompt "Would you like to choose who goes first? (y or n)"
  answer = gets.chomp
  game_number = 1
  player_score = 0
  computer_score = 0
  first_player = who_goes_first?(answer)

  loop do
    board = initialize_board
    current_player = first_player
    display_board(board)

    loop do
      display_board(board)
      place_piece!(board, current_player)
      current_player = alternate_player(current_player)
      break if someone_won?(board) || board_full?(board)
    end

    display_board(board)
    if someone_won?(board)
      quick_prompt "#{detect_winner(board)} won the round!"
    else
      quick_prompt "It's a tie!"
    end

    game_number += 1

    if detect_winner(board) == 'Player'
      player_score += 1
    elsif detect_winner(board) == 'Computer'
      computer_score += 1
    end

    prompt "The score is #{player_score} player, #{computer_score} computer!"

    if player_score == 5
      prompt "The player wins the match!"
      break
    elsif computer_score == 5
      prompt "The computer wins the match!"
      break
    end

    prompt "Round #{game_number}, begin!"
  end

  prompt "Play again? (y or n)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thank you for playing Tic Tac Toe! Goodbye."
