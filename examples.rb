require 'store'

pricing_rules = PricingRules.new

co = Checkout.new(pricing_rules)
co.scan("VOUCHER")
co.scan("TSHIRT")
co.scan("MUG")
co.total

co = Checkout.new(pricing_rules)
co.scan("VOUCHER")
co.scan("TSHIRT")
co.scan("VOUCHER")
co.total

co = Checkout.new(pricing_rules)
co.scan("TSHIRT")
co.scan("TSHIRT")
co.scan("TSHIRT")
co.scan("VOUCHER")
co.scan("TSHIRT")
co.total

co = Checkout.new(pricing_rules)
co.scan("VOUCHER")
co.scan("TSHIRT")
co.scan("VOUCHER")
co.scan("VOUCHER")
co.scan("MUG")
co.scan("TSHIRT")
co.scan("TSHIRT")
co.total
