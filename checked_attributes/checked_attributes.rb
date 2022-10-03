require 'test/unit'

module CheckedAttributes
  def self.included(klass)
    klass.extend(AttributeExtension)
  end

  module AttributeExtension
    def attr_checked(attribute)
      define_method attribute do
        instance_variable_get("@#{attribute}")
      end

      define_method "#{attribute}=" do |val|
        raise RuntimeError unless val && yield(val)

        instance_variable_set("@#{attribute}", val)
      end
    end
  end
end

class Person
  include CheckedAttributes

  attr_checked :age do |v|
    v >= 18
  end
end

class TestCheckedAttribute < Test::Unit::TestCase
  def setup
    @bob = Person.new
  end

  def test_accepts_valid_values
    @bob.age = 20
    assert_equal 20, @bob.age
  end

  def test_refuses_nil_values
    assert_raises RuntimeError, 'Invalid attribute' do
      @bob.age = nil
    end
  end

  def test_refuses_false_values
    assert_raises RuntimeError, 'Invalid attribute' do
      @bob.age = false
    end
  end

  def test_refuses_invalid_values
    assert_raises RuntimeError, 'Invalid attribute' do
      @bob.age = 17
    end
  end
end


