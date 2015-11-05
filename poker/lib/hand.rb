require_relative 'card'

HAND_VALUES = [
  :high_card,
  :one_pair,
  :two_pair,
  :three_of_a_kind,
  :straight,
  :flush,
  :full_house,
  :four_of_a_kind,
  :straight_flush
]

class Hand
attr_accessor :hand, :hand_value

  def initialize(cards = [])
    @hand = cards
    @hand_value = nil
  end

  def add(card)
    @hand << card if hand.length < 5
    self.sort!
    self
  end

  def discard(index)
    @hand.delete_at(index) unless hand.empty?
    self
  end

  def to_s
    "#{@hand.join(", ")}"
  end

  def ==(hand2)
    @hand.each_index do |idx|
      return false unless self[idx] == hand2[idx]
    end
    true
  end

  def [](index)
    @hand[index]
  end

  def each
    @hand.each do |card|
      yield(card)
    end
  end

  def select
    @hand.select do |card|
      yield(card)
    end
  end

  def reject
    @hand.reject do |card|
      yield(card)
    end
  end

  def size
    @hand.size
  end
  
  def sort!
    @hand.sort! {|card1, card2 | card1.value <=> card2.value}
  end

  def find_hand
    if straight_flush?
      @hand_value = :straight_flush
    elsif four_of_a_kind?
      @hand_value = :four_of_a_kind
    elsif full_house?
      @hand_value = :full_house
    elsif flush?
      @hand_value = :flush
    elsif straight?
      @hand_value = :straight
    elsif three_of_a_kind?
      @hand_value = :three_of_a_kind
    elsif two_pair?
      @hand_value = :two_pair
    elsif one_pair?
      @hand_value = :one_pair
    else
      @hand_value = :high_card
    end

    @hand_value
  end

  def compare_hands(opp_hand)
    my_value = HAND_VALUES.find_index(self.find_hand)
    opp_value = HAND_VALUES.find_index(opp_hand.find_hand)

    case my_value <=> opp_value
    when -1
      "opp wins"
    when 0
      break_tie(opp_hand)
    when 1
      "you win"
    end
  end

  def compare_cards(card1, card2)
    card1.value <=> card2.value
  end

  def compare_values(card1_value, card2_value)
    card1_value <=> card2_value
  end

  def break_tie(opp_hand)
    winner = 0
    case self.hand_value
    when :high_card
      winner = break_high_card_tie(self, opp_hand)
    when :straight_flush
      winner = break_high_card_tie(self, opp_hand)
    when :one_pair
      winner = break_n_tie(opp_hand, 2)
      winner = break_leftover_tie(opp_hand, 2) if winner.zero?
    when :two_pair
      winner = break_n_tie(opp_hand, 2)
      winner = break_leftover_tie(opp_hand, 2) if winner.zero?
    when :three_of_a_kind,
      winner = break_n_tie(opp_hand, 3)
      winner = break_leftover_tie(opp_hand, 3) if winner.zero?
    when :straight
      winner = break_high_card_tie(self, opp_hand)
    when :flush
      winner = break_high_card_tie(self, opp_hand)
    when :full_house
      winner = break_n_tie(opp_hand, 3)
      if winner == 0
        winner = break_n_tie(opp_hand, 2)
      end
    when :four_of_a_kind
      winner = break_n_tie(opp_hand, 4)
      winner = break_leftover_tie(opp_hand, 4) if winner.zero?
    end

    case winner
    when -1
      "opp wins"
    when 0
      "you tie"
    when 1
      "you win"
    end
  end

  def break_n_tie(opp_hand, n) # break n-of-a-kind ties
    pair1 = self.count_hand.select { |val, count| count == n }.keys
    pair2 = opp_hand.count_hand.select { |val, count| count == n }.keys
    winner = compare_values(pair1.last[0], pair2.last[0])

    if winner == 0 && pair1.size == 2 # only for two pairs
      winner = compare_values(pair1.first[0], pair2.first[0])
    end

    winner
  end

  def break_leftover_tie(opp_hand, n)
    upd_my_hand = self.count_hand.reject { |val, count| count == n }.keys
    upd_opp_hand = opp_hand.count_hand.reject { |val, count| count == n }.keys
    break_high_card_tie(upd_my_hand, upd_opp_hand, true)
  end

  def break_high_card_tie(my_hand, opp_hand, value=false)
    winner = 0
    (1..opp_hand.size).each do |i|
      winner = value ?
        compare_values(my_hand[-i], opp_hand[-i]) :
        compare_cards(my_hand[-i], opp_hand[-i])
      break unless winner == 0
    end

    winner
  end

  def count_hand
    count = Hash.new(0)
    self.each do |card|
      count[card.value] += 1
    end
    count
  end

  def straight_flush?
    flush? && straight?
  end

  def four_of_a_kind?
    count = count_hand
    count.values.include?(4)
  end

  def full_house?
    count = count_hand
    count.values.sort == [2, 3]
  end

  def flush?
    beginning_card = hand[0]
    (1..4).each do |i|
      return false if hand[i].suit != beginning_card.suit
    end
    true
  end

  def straight?
    beginning_card = hand[0]
    (1..4).each do |i|
      return false if hand[i].value != (beginning_card.value + i)
    end
    true
  end

  def three_of_a_kind?
    count = count_hand
    count.values.include?(3)
  end

  def two_pair?
    count = count_hand
    count.values.sort == [1, 2, 2]
  end

  def one_pair?
    count = count_hand
    count.values.include?(2)
  end
end
