require "spec_helper"
require_relative "../../lib/account"

describe Account do
	let(:validator) { double("validator") }
	let(:mock_cc) { "4111111111111111" }
	let(:account) { Account.new name: "Test", cc: mock_cc , limit: 1000, validator: validator }
	
	context "new account" do
		let(:account) { Account.new validator: validator }
		it "has no initial data" do
			expect(account.name).to be_empty
			expect(account.balance).to eq(0)
			expect(account.cc).to be_empty
			expect(account.limit).to eq(0)
		end
	end

	context "responds to methods and accessors" do
		it "should respond to balance" do
			 expect(account).to respond_to :balance
		end
		it "should respond to name" do
			expect(account).to respond_to :name
		end

		it "should respond to cc" do
			expect(account).to respond_to :cc
		end

		it "should respond to valid?" do
			expect(account).to respond_to :valid?
		end

		it "should respond to charge" do
			expect(account).to respond_to :charge
		end

		it "should respond to credit" do
			expect(account).to respond_to :credit
		end

	end


	it "checks cards for validity" do
		validator.should_receive(:valid?).with(mock_cc)
		account.valid?
	end

	context "transactions" do
		context "creates transactions for charges and credits" do
				
		end

		context "account with a valid card" do
			before(:each) do
				validator.stub(:valid?).and_return(true)
			end      

			it "can add a charge to increase balance" do
				expect(account.balance).to eq(0)
				account.charge 500
				expect(account.balance).to eq(500)
				account.charge 23
				expect(account.balance).to eq(523)
			end
			
			it "ignores charges that would raise the balance over the limit as if they were declined" do
				account.charge 1203
				account.balance.should be 0
				account.charge 350
				account.balance.should be 350
				account.charge 651
				account.balance.should be 350
			end

			it "allows charges that are the limit amount" do
				account.limit.should be 1000
				account.charge 1000
				account.balance.should be 1000
			end

			it "can add a credit" do
				account.charge 350
				account.balance.should be 350
				account.credit 50
				account.balance.should be 300
				account.credit 300
				account.balance.should be 0
			end

			context "negative balance" do
				let(:account) { Account.new transactions: [ credit_tran(300), credit_tran(120) ], validator: validator }
				
				it "calculates a negative balance for transactions that would drop the balance below 0" do			
					expect(account.balance).to eq(-420)
				end
			end
			
		end

		context "invalid card behavior" do
			before(:each) do
				validator.stub(:valid?).and_return(false)
			end

			it "ignores charges" do
				account.charge 300
				expect(account.balance).to eq(0)
			end

			it "ignores credits" do
				account.credit 300
				expect(account.balance).to eq(0)
			end
		end
		
	end 


end