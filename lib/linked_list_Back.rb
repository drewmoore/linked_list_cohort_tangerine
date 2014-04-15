class LinkedList
  attr_reader :size

  attr_reader :last_item

  def initialize(*items)
    @size = 0
    @first
    @previous
    @last_item

    if items
      items.each do |item|
        add_item(item)
      end
    end
  end

  def last
    if @size > 0
      @last_item.payload
    else
      return nil
    end
  end

  def [](index)
    get(index)
  end

  def []= (index, arg)
    to_change = get(index, :want_obj)
    to_change.payload = arg
  end

  def add_item(payload)
    @new_item = LinkedListItem.new(payload, @size)
    if @size == 0
      @first = @new_item
      @previous = @new_item
    end

    if @size > 0
      @previous = @last_item
      @previous.next_list_item = @new_item
    end
    @last_item = @new_item
    @size += 1
  end

  def get(*args)

    index = args[0]
    want_pay = false
    want_obj = false

    if args.size == 1
      want_pay = true
    elsif args.size > 1
      want_obj = true
    end

    if index < 0
      raise IndexError
    end

    if @size < index
      raise IndexError
    end

    if index == 0 && want_pay
      return @first.payload
    elsif index == 0 && want_obj
      return @first
    else
      if want_pay
        iterate_it(@first, index)
      elsif want_obj
        iterate_it(@first, index, :want_obj)
      end
    end
  end

  def iterate_it(*args)
    starter = args[0]
    index = args[1]
    want_pay = false
    want_obj = false

    if args.size == 2
      want_pay = true
    end
    if args.size == 3
      want_obj = true
    end

    if starter.next_list_item
      if starter.next_list_item.index == index && want_pay
        return starter.next_list_item.payload
      elsif starter.next_list_item.index == index && want_obj
        return starter.next_list_item
      elsif starter.next_list_item.index != index && want_pay
        iterate_it(starter.next_list_item, index)
      elsif starter.next_list_item.index != index && want_obj
        iterate_it(starter.next_list_item, index, :want_obj)
      end
    end
  end

  def to_s
    @return_string = "| "
    @connector = ", "

    for i in (0..(@size - 1))
      if i == (@size - 1)
        @connector = " "
      end
      item = get(i)
      @return_string += (item.to_s + @connector)
    end

    @return_string += "|"
    @return_string
  end

  def remove(index)
    if index >= @size
      raise IndexError
    end
    to_remove = get(index, :want_obj)
    to_remove.index = :in_limbo
    if index < (@size - 1)
      for i in ((index + 1)..(@size - 2))
        to_change = get(i, :want_obj)
        to_change_next = get((i + 1), :want_obj)
        to_change.index -= 1
        to_change_next.index -= 1

        if index == 0
          @first = to_change
        end
      end
    end
    @size -= 1
  end

  def indexOf(payload)
    for i in 0..(@size - 1)
      to_test = get(i, :want_obj)
      if to_test.payload == payload
        return to_test.index
      end
    end
    return nil
  end

  def sort
    if self.sorted?
      return self.to_s
    else
      until self.sorted?
        item_swap = nil
        item_0 = nil

        for i in 0..(@size - 2)
          item_1 = get(i)
          item_2 = get(i + 1)

          if ((item_1.to_s > item_2.to_s) && (item_1.class == item_2.class)) or (item_1.class.to_s > item_2.class.to_s)
            item_swap = item_1
            item_1 = item_2
            item_2 = item_swap

            self[i] = item_1
            self[i + 1] = item_2
          end
        end
      end

      return self.to_s
    end
  end

  def sorted?
    true_false = true

    if @size < 2
      true_false = true
    end

    item_0 = nil
    for i in 0..(@size - 2)
      item_1 = get(i)
      item_2 = get(i + 1)

      if (item_1.to_s > item_2.to_s) && (item_1.class == item_2.class)
        true_false = false
      end

      if item_0
        if (item_0.class == item_2.class) && (item_0.class != item_1.class)
          true_false = false
        end
      end
      item_0 = item_1
    end

    true_false
  end

end






















