require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @capacity = 8
    @store = StaticArray.new(@capacity)
    @length = 0
    @start_idx = 0
  end

  # O(1)
  def [](index)
    raise 'index out of bounds' if index >= @length || @length <= 0
    @store[(start_idx + index) % capacity]
  end

  # O(1)
  def []=(index, val)
    raise 'index out of bounds' if index >= @length || @length <= 0
    @store[(start_idx + index) % capacity] = val
  end

  # O(1)
  def pop
    raise 'index out of bounds' if @length <= 0
    # return if @length = 0
    val = self[@length - 1]
    self[@length - 1] = nil
    @length -= 1
    val
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity
    @length += 1
    self[@length - 1] = val
    # self[ length - 1 ] = val
  end

  # O(1)
  def shift
    raise 'index out of bounds' if @length <= 0
    # @store[@start_idx] = nil
    # @length -= 1
    # @start_idx += 1
    val = self[0]
    @start_idx = (start_idx + 1) % capacity
    @length -= 1
    # self[0] = length
    val
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length == @capacity
    @start_idx = ( start_idx - 1) % capacity
    @length += 1
    self[0] = val
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
  end

  def resize!
    new_array = StaticArray.new(@capacity * 2)
    length.times { |idx| new_array[idx] = self[idx] }

    @capacity *= 2
    # @length += 1
    @start_idx = 0

    @store = new_array
  end
end
