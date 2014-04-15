class LinkedListItem
  attr_reader :payload
  attr_reader :next_list_item

  def initialize(*items)
    @payload = items[0]
    @index = items[1]
  end

  def index
    @index
  end

  def index= arg
    @index = arg
  end

  def payload= arg
    @payload = arg
  end

  def next_list_item= arg
    if arg.object_id != self.object_id
      @next_list_item = arg
    else
      raise ArgumentError
    end
  end

  def last?
    if next_list_item
      false
    else
      true
    end
  end

  def > arg
    self.payload.to_s > arg.payload.to_s
  end

  def < arg
    arg.payload.to_s > self.payload.to_s
  end

  def === arg
    self.object_id == arg.object_id
  end

  def == arg
    self.payload == arg.payload
  end

end
