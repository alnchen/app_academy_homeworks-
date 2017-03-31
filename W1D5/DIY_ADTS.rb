class Stack
#LILO
  def initialize
    @set = []
  end

  def add(el)
    @set.shift(el)
  end

  def remove
    @set.pop(el)
  end

  def show
    @set
  end
end


class Queue
  #FIFO
  def initialize
    @set = []

  def enqueue(el)
    @set.shift(el)
  end

  def dequeue(el)
    @set.unshift(el)
  end

  def show
    @set
  end
end


class Map
  def initialize
    @set = []

  def assign(key, value)
    if @set.none? { |ary| ary[0] == key }
      @set << [key, value]
    else
      @set.select { |ary| ary[0] == key}[1] = value
    end
  end

  def lookup(key)
    @set.select {|ary| ary[0] == key}.last.last
  end

  def remove(key)
    @set.delete_if {|ary| ary[0] == key}
  end

  def show
    @set
  end
