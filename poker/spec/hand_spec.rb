require 'hand'

describe 'Hand' do

  let(:hand) {Hand.new}
  let(:test_card) {Card.new(4, :spade)}
  let(:suits) {[:spade, :heart, :club, :diamond]}

  let(:straight_flush_hand) { Hand.new([
    Card.new(2, :spade),
    Card.new(3, :spade),
    Card.new(4, :spade),
    Card.new(5, :spade),
    Card.new(6, :spade)
    ])}

  let(:full_house_hand) { Hand.new([
    Card.new(13, :spade),
    Card.new(13, :spade),
    Card.new(13, :heart),
    Card.new(6, :club),
    Card.new(6, :spade)
    ])}

  let(:two_pair_hand) { Hand.new([
    Card.new(2, :spade),
    Card.new(2, :spade),
    Card.new(10, :heart),
    Card.new(6, :club),
    Card.new(6, :spade)
    ])}

  let(:straight_flush_hand2) { Hand.new([
    Card.new(2, :heart),
    Card.new(3, :heart),
    Card.new(4, :heart),
    Card.new(5, :heart),
    Card.new(6, :heart)
    ])}

  let(:full_house_hand2) { Hand.new([
    Card.new(2, :spade),
    Card.new(2, :spade),
    Card.new(2, :heart),
    Card.new(6, :club),
    Card.new(6, :spade)
    ])}

  let(:two_pair_hand2) { Hand.new([
    Card.new(2, :spade),
    Card.new(2, :spade),
    Card.new(13, :heart),
    Card.new(6, :club),
    Card.new(6, :spade)
    ])}

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

  it "doesn't discard if your hand is empty" do
    expect(hand.discard(0)).to eq(hand)
  end

  it "interpolates Hand to string" do
    5.times {|i| hand.add(Card.new(i+2, :spade))}
    expect(hand.to_s).to eq("2 ♠, 3 ♠, 4 ♠, 5 ♠, 6 ♠")
  end

  it "sorts a hand properly" do
    5.times {|i| hand.add(Card.new(i+2, :spade))}
    hand_checker = Hand.new
    5.times {|i| hand_checker.add(Card.new(i+2, :spade))}
    expect(hand.sort!.reverse.reverse).to eq(hand_checker.hand)
  end

  it "recognizes a straight flush" do
    expect(straight_flush_hand.straight_flush?).to be(true)
  end

  it "recognizes a straight" do
    expect(straight_flush_hand.straight?).to be(true)
  end

  it "recognizes a flush" do
    expect(straight_flush_hand.flush?).to be(true)
  end

  it "recognizes a full house" do
    expect(full_house_hand.full_house?).to be(true)
  end

  it "recognizes a three of a kind" do
    expect(full_house_hand.three_of_a_kind?).to be(true)
  end

  it "recognizes two pair" do
    expect(two_pair_hand.two_pair?).to be(true)
  end

  it "recognizes one pair" do
    expect(full_house_hand.one_pair?).to be(true)
  end

  it "sets hand value corrently" do
    3.times {|i| hand.add(Card.new(7, suits[i]))}
    2.times {|i| hand.add(Card.new(6, suits[i]))}
    expect(hand.find_hand).to be(:full_house)
  end

  describe "#compares hands" do
    it "... when you have winning hand" do
      expect(straight_flush_hand.compare_hands(two_pair_hand)).to eq("you win")
    end

    it "... when you have losing hand" do
      expect(two_pair_hand.compare_hands(full_house_hand)).to eq("opp wins")
    end

    it "... breaks ties when you have winning hand" do
      expect(full_house_hand.compare_hands(full_house_hand2)).to eq("you win")
    end

    it "... breaks ties when you have losing hand" do
      expect(two_pair_hand.compare_hands(two_pair_hand2)).to eq("opp wins")
    end

    it "... returns ties when you have tie" do
      expect(straight_flush_hand.compare_hands(straight_flush_hand2)).to eq ('you tie')
    end
  end
end
