require "spec_helper"
require "transaction"

describe Transaction do
  it "has no initial amount" do
    trans = Transaction.new(:credit)
    trans.amount.should be 0
  end
  
  it "can set amount" do
    trans = Transaction.new(:credit)
    trans.amount.should be 0
    trans.amount = 500
    trans.amount.should be 500
    trans.amount = 251
    trans.amount.should be 251
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
    subject { Transaction.new(:credit, 1200) }
    it { subject.should respond_to :amount }
    it { subject.should respond_to :transaction_type }
  end
end