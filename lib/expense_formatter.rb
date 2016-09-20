module ExpenseFormatter
  def format_expense(message)
    expense = {
      amount: parse_amount(message),
      item: parse_item(message),
      location: parse_location(message),
      category: parse_category(message)
    }
    
    if expense[:item] == '' || !(expense[:amount] =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/)
      return nil
    else
      return expense
    end
  end

  private

  def parse_amount(message)
    text = message['text']

    return text.split(' ')[0]
  end

  def parse_item(message)
    text = message['text']

    parsed_text = text.split(' ')
    parsed_text.shift
    text = parsed_text.join(' ')

    location_index = text.index('@')
    category_index = text.index('#')

    if location_index != nil && category_index != nil
      if location_index < category_index
        index = location_index
      else
        index = category_index
      end
    elsif location_index != nil && category_index == nil
      index = location_index
    elsif location_index == nil && category_index != nil
      index = category_index
    else
      index = text.length
    end

    return text.slice(0, index).squish
  end

  def parse_location(message)
    text = message['text']

    location_index = text.index('@')
    category_index = text.index('#')

    if location_index != nil && category_index != nil
      if location_index < category_index
        index = category_index - 1
      else
        index = text.length
      end
    elsif location_index != nil && category_index == nil
      index = text.length
    elsif location_index == nil
      return nil
    end

    return text.slice(location_index + 1, index - location_index - 1)
  end

  def parse_category(message)
    text = message['text']

    location_index = text.index('@')
    category_index = text.index('#')

    if location_index != nil && category_index != nil
      if category_index < location_index
        index = location_index - 1
      else
        index = text.length
      end
    elsif category_index != nil && location_index == nil
      index = text.length
    elsif category_index == nil
      return nil
    end

    return text.slice(category_index + 1, index - category_index - 1)
  end
end
