require_relative 'lib/secret_code'
require_relative 'lib/player_pick'

class MasterMind
  def game_start
    @secret_code = SecretCode.new.cpu_pick
    play_game
  end

  def play_game
    10.times do
      @player_pick = PlayerPick.new.get_player_input
      puts "Correct position: #{match_chr(@secret_code, @player_pick)} Include number: #{include_chr(@secret_code, @player_pick)}"
      break if @secret_code == @player_pick
    end
    if @secret_code == @player_pick
      puts "You win!"
    else
      puts "You lose"
    end
  end

  def match_chr(string_a, string_b)
    matches = 0
    for i in 0..3
      matches += 1 if string_a[i] == string_b[i]
    end
    matches
  end

  def include_chr(string_a, string_b)
    inclusion = 0
    for i in 0..3
      inclusion += string_a.count(string_b[i])
    end
    inclusion
  end
end

new_game = MasterMind.new
new_game.game_start