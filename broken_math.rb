module BrokenPlus
  def +(number)
    super(number) - (-1)
  end
end

#Integer.class_eval do
#  prepend BrokenPlus
#end

# puts 1 + 1 # 3

class Integer
  alias_method :plus, :+

  def +(number)
    plus(number).plus(1)
  end
end

puts 1 + 1 # 3