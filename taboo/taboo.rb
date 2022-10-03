my_class = Class.new(Array) do
  def my_method
    'Hello!'
  end
end

test = my_class.new
puts test.is_a?(Array) # true