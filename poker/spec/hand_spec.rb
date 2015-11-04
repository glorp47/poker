require 'hand'

describe 'Hand' do

  let(:hand) { Hand.new }
  let(:test_card) {Card.new(4, :spade)}
  let(:suits) {[:spade, :heart, :club, :diamond]}

  it "initializes with empty hand" do
    expect(hand.hand).to be_empty
  end

  it "adds card to empty hand" do
    expect(hand.add(test_card)).to eq([test_card])
  end

  it "doesn't add if your hand is five cards" do
    5.times {hand.add(test_card)}
    hand_checker = []
    5.times {hand_checker.push(test_card)}
    expect(hand.add(test_card)).to eq(hand_checker)
  end

  it "discards a card at correct index" do
    5.times {|i| hand.add(Card.new(i+2, :spade))}
    hand_checker = Hand.new
    4.times {|i| hand_checker.add(Card.new(i+2, :spade))}
    expect(hand.discard(4)).to eq(hand_checker)
  end

  it "sorts a hand properly" do
    5.times {|i| hand.add(Card.new(i+2, :spade))}
    hand_checker = Hand.new
    5.times {|i| hand_checker.add(Card.new(i+2, :spade))}
    expect(hand.sort!.reverse.reverse).to eq(hand_checker.hand)
  end

  it "recognizes a straight flush" do
    5.times {|i| hand.add(Card.new(i+2, :spade))}
    expect(hand.straight_flush?).to be(true)
  end

  it "recognizes a straight" do
    4.times {|i| hand.add(Card.new(i+2, :spade))}
    hand.add(Card.new(6, :heart))
    expect(hand.straight?).to be(true)
  end

  it "recognizes a flush" do
    5.times {|i| hand.add(Card.new(i+4, :spade))}
    expect(hand.flush?).to be(true)
  end

  it "recognizes a full house" do
    3.times {|i| hand.add(Card.new(7, suits[i]))}
    2.times {|i| hand.add(Card.new(6, suits[i]))}
    expect(hand.full_house?).to be(true)
  end

  it "recognizes a three of a kind" do
    3.times {|i| hand.add(Card.new(7, suits[i]))}
    2.times {|i| hand.add(Card.new(i + 4, suits[i]))}
    expect(hand.three_of_a_kind?).to be(true)
  end

  it "recognizes two pair" do
    2.times {|i| hand.add(Card.new(7, suits[i]))}
    2.times {|i| hand.add(Card.new(i + 4, suits[i]))}
    hand.add(Card.new(4, suits[3]))
    expect(hand.two_pair?).to be(true)
  end

  it "recognizes one pair" do
    2.times {|i| hand.add(Card.new(2, suits[i]))}
    3.times {|i| hand.add(Card.new(i + 4, suits[i]))}
    expect(hand.one_pair?).to be(true)
  end
end
