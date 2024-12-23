class Player

    attr_reader :health, :score
    attr_accessor :name

    def initialize(name, health = 100)
        @name = name
        @health = health
        @score = name.length + health
    end

    def name=(new_name)
        @name = new_name.capitalize
    end

    def boost
        @health += 15
    end

    def drain
        @health -= 10
    end

    def to_s
        "I'm #{@name} with a health of #{@health} and a score of #{@score}"
    end

end

player_1 = Player.new("finn", 60)
number_rolled = rand(1..6)

case number_rolled
when 1..2
    player_1.drain
    puts "#{player_1.name} got drained 😩"
when 3..4
    puts "#{player_1.name} got skipped"
else
    player_1.boost
    puts "#{player_1.name} got boosted 😁"
end

# player_2 = Player.new("lucy", 90)
# puts player_2
# player_2.drain
# puts player_2

# player_3 = Player.new("jase")
# puts player_3
# player_3.boost
# player_3.boost
# puts player_3

# player_4 = Player.new("alex", 125)
# puts player_4.name
# player_4.name = "alexander"
# puts player_4.name
# puts player_4.health
# puts player_4.score
# puts player_4