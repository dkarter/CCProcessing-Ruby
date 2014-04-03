require "spec_helper"
require_relative "../../lib/transaction"

describe Transaction do

  context "defaults" do
    let(:transaction) { Transaction.new :credit }
    it "has no initial amount" do
      expect(transaction.amount).to eq(0)
    end  
  end
  
  it "can be initialized with an amount and a transaction type" do
    trans = Transaction.new(:credit, 100)
    trans.transaction_type.should be :credit
    trans.amount.should be 100

    trans = Transaction.new(:charge, 1234)
    trans.transaction_type.should be :charge
    trans.amount.should be 1234
  end

  context "responds to methods and accessors" do
    let(:transaction) { Transaction.new(:credit, 1200) }
    it "should respond to amount" do
       expect(transaction).to respond_to :amount
    end
    it "should respond to transaction_type" do
      expect(transaction).to respond_to :transaction_type
    end
  end
end