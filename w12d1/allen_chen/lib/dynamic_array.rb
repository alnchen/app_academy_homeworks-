require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @capacity = 8
    @store = StaticArray.new(@capacity)
    @length = 0
    # @start_idx = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    check_index(value)
    @store[index] = value
  end

  # O(1)
  def pop
    raise 'index out of bounds' if @length <= 0
    # return if @length = 0
    @store[@length] = nil
    @length -= 1
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    @length += 1
    self.resize! if @length > @capacity
    @store[@length] = val
  end

  # O(n): has to shift over all the elements.
  def shift
    raise 'index out of bounds' if @length <= 0
    # @store[@start_idx] = nil
    # @length -= 1
    # @start_idx += 1

    val = @store[0]
    (1...length).each do |idx|
      @store[idx - 1] = @store[idx]
    end
    @length -= 1
    val
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    # @store[@start_idx] = val
    # @start_idx -= 1
    # @length += 1

    @length += 1
    resize! if @length > @capacity
    (length - 2).downto(0) do |idx|
      @store[idx + 1] = @store[idx]
    end
    @store[0] = val

  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    raise 'index out of bounds' if index >= @length || @length <= 0
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    new_array = StaticArray.new(@capacity * 2)
    (0..@length).each { |idx| new_array[idx] = @store[idx] }
    @capacity *= 2
    # @length += 1
    @store = new_array
  end
end
