class Checkout
  attr_reader :items

  CURRENCY = '€'

  def initialize(pricing_rules)
    @items = []
    @pricing_rules = pricing_rules
  end

  def scan(item)
    product = Product.find(item)
    @items << product
  rescue
    puts "Product dont registered!!!"
  end

  def total
    @items = @pricing_rules.apply!(@items)
    total = @items.map(&:price).inject :+
    "#{'%.02f' % total}#{CURRENCY}"
  end
end
