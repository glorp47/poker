class Array
  def my_uniq
    uniq_arr = []
    self.each do |el|
      uniq_arr << el unless uniq_arr.include?(el)
    end
    uniq_arr
  end

  def two_sum
    return_arr = []
    self.each_index do |i|
      j = i + 1
      while j < self.length
        return_arr << [i, j] if self[i] + self[j] == 0
        j += 1
      end
    end
    return_arr
  end

  def my_transpose
    return [] if self.empty?
    transposed = Array.new(self[0].length) {Array.new}
    self.each do |row|
      row.each_with_index do |cell, j|
        transposed[j] << cell
      end
    end
    transposed
  end

  def stock_picker
    most_profit = 0
    days = []
    self.each_with_index do |buying_price, idx1|
      idx2 = idx1 + 1
      while idx2 < self.length
        current_profit = self[idx2] - buying_price
        if current_profit > most_profit
           most_profit = current_profit
           days = [idx1, idx2]
         end
        idx2 += 1 
       end
     end
     days
   end


end
