# this is a gem code from https://github.com/rorymckinley/luhnacy/blob/master/lib/luhnacy.rb
# i did not write it
class Luhnacy
  
  def self.valid?(candidate)
    calc_modulus(candidate) == 0
  end

  private
  def self.double_and_fix(number)
    2 * number > 9 ? ( (2 * number) % 10 + 1 ) : 2 * number
  end

  def self.calc_modulus(candidate)
    working = candidate.reverse
    double_up = false;
    sum = 0

    working.each_char do |ch|
      num = ch.to_i
      sum += double_up ? double_and_fix(num) : num
      double_up = !double_up
    end

    sum % 10
  end

end