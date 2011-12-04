class Array2D
  def initialize(rows, cols, default=nil)
    @stuff = Array.new(rows, []) {Array.new(cols, nil)}
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
end