require_relative "treasure_trove"
require_relative "auditable"

module StudioGame
    class Game
        include Auditable
        attr_reader :title, :players
    
        def initialize(title)
            @title = title
            @players = []
        end
    
        def add_player(player)
            @players << player
        end
    
        def sorted_players
            @players.sort_by { |player| player.score }.reverse
        end
    
        def load_players(file_from, high_scores = "high_scores.txt")
            File.readlines(file_from, chomp: true).each do |line|
                player = Player.from_csv(line)
                add_player(player)
            end
        rescue Errno::ENOENT
            puts "Whoops, can't find the file #{file_from}"
            exit 1
        end
    
        def save_high_scores(to_file = "high_scores.txt")
            File.open(to_file, "w") do |file|
                file.puts "#{@title} High Scores:"
                sorted_players.each do |player|
                    file.puts high_score_entry(player)
                end
            end
        end
    
        def high_score_entry(player)
            name = player.name.ljust(20, ".")
            score = player.score.round.to_s.rjust(5)
            "#{name}#{score}"
        end
    
        def roll_die
            number = [1, 1, 2, 5, 6, 6].sample
            audit(number)
            number
        end
    
        def print_stats
            puts "\nGame Stats:"
            puts "-" * 30
            @players.each do |player|
                puts "\n#{player.name}'s treasure point totals:"
                    player.found_treasures.each do |name, points|
                        puts "#{name}: #{points}"
                    end
                puts "total: #{player.points}"
            end
    
            puts "\nHigh Scores:"
            sorted_players.each do |player|
                name = player.name.ljust(20, ".")
                points = player.score.round.to_s.rjust(5)
                puts "#{name}#{points}"
            end
        end
    
        def play(rounds = 1)
            puts "\nLet's play #{@title}!"
    
            puts "\nThe following treasures can be found:"
            puts TreasureTrove.treasure_items
            
            puts "\nBefore playing:"
            puts @players
            
            1.upto(rounds) do |round|
                puts "\nRound #{round}:"
    
                @players.each do |player|
                    number_rolled = roll_die
                
                    case number_rolled
                    when 1..2
                        player.drain
                        puts "#{player.name} got drained 😩"
                    when 3..4
                        puts "#{player.name} got skipped"
                    else
                        player.boost
                        puts "#{player.name} got boosted 😁"
                    end
    
                    treasure = TreasureTrove.random_treasure
                    player.found_treasure(treasure.name, treasure.points)
                    puts "#{player.name} found a #{treasure.name} worth #{treasure.points} points"
                end
            end
            
            puts "\nAfter playing:"
            puts @players
        end
    
    end
end

