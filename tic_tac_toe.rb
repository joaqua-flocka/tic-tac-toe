class Board
  attr_accessor :board, :gameover

  def initialize
    @board = [
      [' ', ' ', ' '],
      [' ', ' ', ' '],
      [' ', ' ', ' ']
    ]
    @gameover = false
  end

  def print_board
    puts '   1   2   3'
    @board.each_with_index do |row, idx|
      puts "#{idx + 1}  #{row.join(' | ')}"
      puts '  ——— ——— ———' if idx < 2
    end
  end

  def victory(char)
    puts "#{char}'s win!"
    @gameover = true
  end

  def check_array(array)
    true if array.uniq.length == 1 && !array.include?(' ')
  end

  def check_row
    @board.each_with_index do |row, _r_idx|
      victory(row[0]) if check_array(row)
    end
  end

  def check_column
    3.times do |j|
      y_arr = []
      3.times do |i|
        y_arr << @board[i][j]
      end
      victory(y_arr[j]) if check_array(y_arr)
    end
  end

  def check_diagonals
    arr = [@board[0][0], @board[1][1], @board[2][2]]
    if check_array(arr)
      victory(arr[0])
    else
      arr = [@board[2][0], @board[1][1], @board[0][2]]
      victory(arr[0]) if check_array(arr)
    end
  end

  def check_for_win
    check_row
    check_column
    check_diagonals
  end
end

class Player
  attr_reader :name

  @@players = 0
  def initialize
    @cross = true if @@players.even?
    @@players += 1
    @name = @@players.odd? ? "Player #{@@players % 2}" : 'Player 2'
  end

  def choose_square
    puts "#{@name}'s turn!"
    begin
      puts 'Which row would you like to mark?'
      y = gets.chomp.to_i - 1
      raise StandardError unless y.between?(0, 2)
    rescue StandardError
      puts 'Please enter a valid row!'
      retry
    end
    begin
      puts 'Which column in that row?'
      x = gets.chomp.to_i - 1
      raise StandardError unless x.between?(0, 2)
    rescue StandardError
      puts 'Please enter a valid column!'
      retry
    end
    [x, y]
  end

  def make_move(board, _player)
    symbol = @cross == true ? 'X' : 'O'
    begin
      coordinates = choose_square
      raise StandardError unless board.board[coordinates[1]][coordinates[0]] == ' '
    rescue StandardError
      puts 'That space is taken! Please try again.'
      retry
    end
    board.board[coordinates[1]][coordinates[0]] = symbol
    board.print_board
    board.check_for_win
  end
end

keep_playing = true

while keep_playing == true
  board = Board.new
  board.print_board
  me = Player.new
  you = Player.new
  while board.gameover == false
    me.make_move(board, you)
    you.make_move(board, me) unless board.gameover
  end
  begin
    puts 'Play again? [y/n]'
    choice = gets.chomp.downcase
    raise StandardError unless %w[y n].include?(choice)
  rescue StandardError
    puts 'Invalid choice! Please try again.'
    retry
  end
  keep_playing = false if choice == 'n'
end
