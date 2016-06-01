class PricingRules

  def apply!(items)
    rules.each do |rule|
      send(rule, items)
    end
    items
  end

  def apply_marketing_rule!(items)
    voucher_items = items.select{ |item| item.code == 'VOUCHER' }
    voucher_items.each_slice(2) do |slice|
      if slice.count == 2
        slice.last.price = 0.0 
      end
    end
    items
  end

  def apply_cfo_rule!(items)
    tshirt_items = items.select{ |item| item.code == 'TSHIRT' }
    if tshirt_items.count >= 3
      tshirt_items.map do |item|
        item.price = 19.0
      end
    end
    items
  end

  def rules
    PricingRules.new.methods.select { |method| method.match(/_rule/) }
  end
end
