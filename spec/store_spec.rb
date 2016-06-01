require 'spec_helper'

describe Checkout do
  it 'has a version number' do
    expect(Store::VERSION).not_to be nil
  end

  let(:pricing_rules) { PricingRules.new }
  subject { described_class.new(pricing_rules)}

  it "responds to scan and total public interfaces" do
    expect(subject).to respond_to :scan
    expect(subject).to respond_to :total
  end

  specify "scanning a item" do
    expect {
      subject.scan("VOUCHER")
    }.to change(subject.items, :count).by(1)
  end

  it "scannig VOUCHER, TSHIRT, MUG" do
    subject.scan("VOUCHER")
    subject.scan("TSHIRT")
    subject.scan("MUG")
    expect(subject.total).to eq '32.50€'
  end

  it "scannig VOUCHER, TSHIRT, VOUCHER" do
    subject.scan("VOUCHER")
    subject.scan("TSHIRT")
    subject.scan("VOUCHER")
    subject.total
    expect(subject.total).to eq '25.00€'
  end

  it "scannig previous items with different order" do
    subject.scan("TSHIRT")
    subject.scan("VOUCHER")
    subject.scan("VOUCHER")
    subject.total
    expect(subject.total).to eq '25.00€'
  end

  it "scannig TSHIRT, TSHIRT, TSHIRT, VOUCHER, TSHIRT" do
    subject.scan("TSHIRT")
    subject.scan("TSHIRT")
    subject.scan("TSHIRT")
    subject.scan("VOUCHER")
    subject.scan("TSHIRT")
    expect(subject.total).to eq '81.00€'
  end

  it "scannig previous items with different order" do
    subject.scan("VOUCHER")
    subject.scan("TSHIRT")
    subject.scan("TSHIRT")
    subject.scan("TSHIRT")
    subject.scan("TSHIRT")
    expect(subject.total).to eq '81.00€'
  end

  it "scannig VOUCHER, TSHIRT, VOUCHER, VOUCHER, MUG, TSHIRT, TSHIRT" do
    subject.scan("VOUCHER")
    subject.scan("TSHIRT")
    subject.scan("VOUCHER")
    subject.scan("VOUCHER")
    subject.scan("MUG")
    subject.scan("TSHIRT")
    subject.scan("TSHIRT")
    expect(subject.total).to eq '74.50€'
  end

  it "scannig previous items with different order" do
    subject.scan("TSHIRT")
    subject.scan("MUG")
    subject.scan("TSHIRT")
    subject.scan("VOUCHER")
    subject.scan("VOUCHER")
    subject.scan("TSHIRT")
    subject.scan("VOUCHER")
    expect(subject.total).to eq '74.50€'
  end
end
