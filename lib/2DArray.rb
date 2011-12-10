class Array2D
  def initialize(rows=0, cols=0, default=nil)
    @stuff = Array.new(rows) {Array.new(cols, default)}
  end

  # Iterate through each element, while passing the object, its +x+ and +y+ position to the block.
  def each
    x = 0
    y = 0
    size.times do |s|
      yield(self[x, y], x, y)
      # Restart at +width - 1+ because the array starts at +0, 0+ not +1, 1+.
      if x == width - 1
        x = 0
        y += 1
      else
        x += 1
      end
    end
  end

  # Redefined Object#method_missing as to forward the undefined
  # method to +@stuff+, an array. You can even pass blocks, too,
  # otherwise this would be pretty useless...
  def method_missing(m, *args, &block)
    if @stuff.respond_to?(m)
      @stuff.flatten(1).send(m, *args) {|*b_args| block.call(*b_args)}
    else
      super(m, *args)
    end
  end

  # Set the object at +x+, +y+ to +new+.
  def []=(x, y, new)
    # Initialize the array for +x+ if it hasn't already been.
    if @stuff[x] == nil
      @stuff[x] = []
    end
    @stuff[x][y] = new
  end

  # Returns the object at +x+, +y+.
  def [](x, y)
    # Return +nil+ if there is nothing at the given position.
    if @stuff[x] == nil
      return nil
    end
    @stuff[x][y]
  end

  # Returns if +thing+ is an element.
  def include?(thing)
    @stuff.flatten(1).include?(thing)
  end

  def size
    @stuff.flatten(1).size
  end

  # Returns the number of rows.
  def width
    @stuff.size
  end

  # TODO: Implement a method to return the number of columns.
end