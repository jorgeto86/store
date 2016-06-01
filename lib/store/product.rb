require 'yaml'

class Product
  attr_accessor :price
  attr_reader :name
  attr_reader :code

  def initialize(name, price, code)
    @name = name
    @price = price.to_f/100
    @code = code
  end

  def self.find(code)
    product = all_products["#{code}"]

    unless product
      error = ProductNotFound.new
      raise error, error.message
    else
      self.new(
        product['name'],
        product['price'],
        code
      )
    end
  end

  def self.all_products
    YAML.load_file('db/database.yml')['products']
  end

  class ProductNotFound < StandardError
    # attr_reader :product

    # def initialize(product)
    #   @product = product
    # end
    def message
      "Product not found"
    end
  end
end
