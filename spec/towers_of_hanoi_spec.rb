require 'towers_of_hanoi'

describe TowersOfHanoi do
  let(:game) { TowersOfHanoi.new }

  describe "#render" do
    it "renders a string" do
      expect(game.render).to be_a(String)
    end

    it "renders correct string" do
      correct_ans = 'Tower 0:  ' + game.towers[0].join('  ') + "\n" +
        'Tower 1:  ' + game.towers[1].join('  ') + "\n" +
        'Tower 2:  ' + game.towers[2].join('  ') + "\n"
      expect(game.render).to eq(correct_ans)
    end
  end

  describe "#move" do
    it "moves disks from top of from tower" do
      game.move(0, 2)
      from_tower = game.towers[0]
      expect(from_tower).to eq([3, 2])
    end

    it "adds disk to top of to tower" do
      game.move(0, 2)
      from_tower = game.towers[2]
      expect(from_tower).to eq([1])
    end
  end

  describe "won?" do
    it "wins if tower 0 is empty and tower 1 is stacked" do
      game.towers[1] = game.towers[0]
      game.towers[0] = []
      expect(game.won?).to equal(true)
    end

    it "wins if tower 0 is empty and tower 2 is stacked" do
      game.towers[2] = game.towers[0]
      game.towers[0] = []
      expect(game.won?).to equal(true)
    end

    it "doesn't win if tower 0 is stacked" do
      expect(game.won?).to equal(false)
    end
  end
end
