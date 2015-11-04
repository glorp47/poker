require 'arr'

describe Array do
      let(:arr) { Array.new }
  describe "#my_uniq" do


    it "returns empty array" do
      expect(arr.my_uniq).to eq([])
    end

    it "returns original array of unique elements" do
      arr = [1, 2, 3, 4]
      expect(arr.my_uniq).to eq(arr)
    end

    it "returns unique array of duplicate elements" do
      arr = [1, 1, 2]
      expect(arr.my_uniq).to eq([1, 2])
    end
  end

  describe "#two_sum" do

    it "returns empty array" do
      expect(arr.two_sum).to eq([])
    end

    it "returns the right stuff" do
      arr = [-1, 0, 2, -2, 1]
      right_answer = [[0, 4], [2, 3]]
      expect(arr.two_sum).to eq(right_answer)
    end

    it "returns empty array if one element" do
      arr = [0]
      expect(arr.two_sum).to eq([])
    end
  end

  describe "#my_transpose" do

    it "returns empty array" do
      expect(arr.my_transpose).to eq([])
    end

    it "returns right things" do
      arr = [[1, 2], [3, 4]]
      good_answer = [[1, 3], [2, 4]]
      expect(arr.my_transpose).to eq(good_answer)
    end
  end

  describe "#stock_picker" do

    it "returns empty array" do
      expect(arr.stock_picker).to eq([])
    end

    it "picks the right stocks" do
      arr = [3, 1, 5, 6, 2]
      right_answer = [1, 3]
      expect(arr.stock_picker).to eq(right_answer)
    end

  end

end
