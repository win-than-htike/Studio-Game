require "minitest/autorun"
require_relative "../../lib/studio_game/player"

module StudioGame
    class PlayerTest < Minitest::Test

        def setup
            @player = Player.new("win", 100)
        end

        def test_has_a_capitalized_name
            assert_equal "Win", @player.name
        end

        def test_has_an_initial_health
            assert_equal 100, @player.health
        end

        def test_computes_a_score_as_the_sum_of_health_and_length_of_name
            @player.score
            assert_equal 103, @player.score
        end

        def test_has_a_string_representation
            assert_equal "I'm Win with a health of 100 and a score of 103", @player.to_s
        end

        def test_increases_health_by_15_when_boosted
            @player.boost
            assert_equal 115, @player.health
        end

        def test_increase_health_by_10_when_drained
            @player.drain
            assert_equal 90, @player.health
        end

    end
end
