require_relative 'deck'
require_relative 'player'

class Game

attr_reader :pot, :deck, :players

  def initialize(players=[Player.new("Max"), Player.new("John")])
    @pot = 0
    @deck = Deck.new
    @players = players
    deal_deck
  end

  def deal_deck
    deck.shuffle!

    5.times do
      players.each do |player|
        player.add(deck.pop)
      end
    end

    players.each do |player|
      puts player.hand
    end
  end

  def won?
    players.any? { |player| player.won? }
  end

  def prompt
    puts "What do you wanna do? (f for fold, s for see, r for raise, d for discard)"
    gets.chomp.downcase
  end

  def play
    until won?
      amount = 0
      players.each do |player|
        puts "Player #{player.name}"
        case prompt
        when 'f'
          player.fold
        when 's'
          amount = player.see(pot, amount)
          @pot += amount
          puts "Current game pot = #{pot}"
        when 'r'
          amount = player.raise_pot(pot)
          @pot += amount
          puts "Current game pot = #{pot}"
        when 'd'
          player.discard
          player.add(deck.pop)
          puts player.hand
        end
      end
    end
  end
end

g = Game.new
g.play
