require "spec_helper"
require "rubygems"
require "account"

describe Account do
  context "new account" do
    it "has no initial data" do
      subject.name.should be_empty
      subject.balance.should be 0
      subject.cc.should be_empty
      subject.limit.should be 0
    end
  end

  context "responds to methods and accessors" do
    it { should respond_to :balance }
    it { should respond_to :name }
    it { should respond_to :cc }
    it { should respond_to :valid? }
    it { should_not respond_to :transactions }
    it { should respond_to :charge }
    it { should respond_to :credit }
  end

  context "allows changing values for accessors" do
    it "name" do
      subject.name.should be_empty
      subject.name = "Tester"
      subject.name.should == "Tester"
    end
  end

  context "checks cards for validity" do
    context "detects valid cards" do
      # cc nums from http://www.getcreditcardnumbers.com/
      
      it "by Visa" do    
        cards = ["4556901563769131",
                 "4121277443502299",
                 "4916444426715657",
                 "4024007195099790",
                 "4024007154225758",
                 "4232186631466",
                 "4514386983999",
                 "4485187130991",
                 "4532244819916",
                 "4532056159302"]
        cards.each do |card|
          subject.cc = card
          subject.should be_valid        
        end
      end
      
      it "by Mastercard" do    
        cards = ["5534042043980859",
                 "5560181367900791",
                 "5329201577198960",
                 "5165710228198226",
                 "5390578404244826"]
        cards.each do |card|
          subject.cc = card
          subject.should be_valid        
        end
      end
    end

    it "detects invalid cards" do
        cards = ["4556931",
                 "412127744350229234329",
                 "4234443234553",
                 "0024007195099790",
                 "1111111111111111",
                 "3",
                 "4516386983990",
                 "4485197130991",
                 "4532244819992",
                 "4532056153303"]
        cards.each do |card|
          subject.cc = card
          subject.should_not be_valid        
        end
      end
  end


  context "can be initialized" do
    it "with invalid card" do
      acct = Account.new("Test", "1234567890000000", 1000)
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
    context "to an account with a valid card" do
      subject { Account.new("Test", "4111111111111111", 1000) }
      it { should be_valid  }
      it "can add a charge to increase balance" do
        subject.balance.should be 0
        subject.charge 500
        subject.balance.should be 500
        subject.charge 23
        subject.balance.should be 523
      end
      
      it "ignores charges that would raise the balance over the limit as if they were declined" do
        subject.limit.should be 1000
        subject.balance.should be 0
        subject.charge 1203
        subject.balance.should be 0
        subject.charge 350
        subject.balance.should be 350
        subject.charge 651
        subject.balance.should be 350
      end

      it "allows charges that are the limit amount" do
        subject.balance.should be 0
        subject.limit.should be 1000
        subject.charge 1000
        subject.balance.should be 1000
      end

      it "can add a credit" do
        subject.charge 350
        subject.balance.should be 350
        subject.credit 50
        subject.balance.should be 300
        subject.credit 300
        subject.balance.should be 0
      end


      it "will create a negative balance for credits that would drop the balance below $0" do
        subject.balance.should be 0
        subject.credit 300
        subject.balance.should == -300
        subject.credit 120
        subject.balance.should == -420
      end
    end

    context "to an account with an invalid card" do
      subject { Account.new("Test", "1234567890123456", 1000) }
      it "ignores charges" do
        subject.balance.should be 0
        subject.charge 300
        subject.balance.should be 0
      end

      it "ignores credits" do
        subject.balance.should be 0
        subject.credit 300
        subject.balance.should be 0
      end
    end
    
  end 


end