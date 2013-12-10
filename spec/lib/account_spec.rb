require "spec_helper"
require "account"

describe Account do
  context "has no initial data" do
    its (:name) { should be_empty }
    its (:balance) { should be 0 }
    its (:cc) { should be_empty }
    its (:limit) { should be 0 }
    #its (stub!(:transactions)) { should be_empty }
  end

  context "responds to methods and accessors" do
    it { should respond_to :balance }
    it { should respond_to :name }
    it { should respond_to :cc }
    it { should respond_to :valid? }
    it { should_not respond_to :transactions }
  end

  context "allows changing values for accessors" do
    it "name" do
      subject.name.should be_empty
      subject.name = "Tester"
      subject.name.should == "Tester"
    end
  end

  
  context "can be initialized with a name, credit card, and a limit" do
    it "can be initialized with invalid card" do
      acct = Account.new("Test", "1234567890000000", 1000)
      puts acct.name
      acct.name.should == "Test"
      acct.cc.should == "1234567890000000"
      acct.limit.should == 1000
      acct.should_not be_valid
      acct.balance.should be 0
    end

    it "can be initialized with a valid card" do
      acct = Account.new("Test", "4111111111111111", 1000)
      acct.name.should == "Test"
      acct.cc.should == "4111111111111111"
      acct.limit.should == 1000
      acct.should be_valid
      acct.balance.should == 0
    end

    
  end
      
  context "transactions" do
    it "can add a charge transaction"
    it "can add a credit transaction"
  end 


end