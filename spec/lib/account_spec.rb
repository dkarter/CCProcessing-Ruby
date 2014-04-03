require "spec_helper"
require_relative "../../lib/account"

describe Account do
	let(:validator) { double("validator") }
	let(:mock_cc) { "4111111111111111" }
	let(:transaction) { double("Transaction") }
	let(:transactions) { [] }
	let(:account) { Account.new name: "Test", 
								  cc: mock_cc , 
							   limit: 1000, 
						   validator: validator,
						 transaction: transaction,
						transactions: transactions }
	
	context "new account" do
		let(:account) { Account.new validator: validator, transaction: transaction }
		it "has no initial data" do
			expect(account.name).to be_empty
			expect(account.balance).to eq(0)
			expect(account.cc).to be_empty
			expect(account.limit).to eq(0)
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
				transaction.stub(:new).and_return(transaction)
			end      

			it "can add a charge transaction" do
				transaction.should_receive(:new).with(:charge, 325)
				account.charge(325)
				expect(transactions[0]).to eq(transaction)
			end

			it "can add a credit transaction" do
				transaction.should_receive(:new).with(:credit, 325)
				account.credit(325)
				expect(transactions[0]).to eq(transaction)
			end
			

			context "limit calculation" do
				it "ignores charges that would raise the balance over the limit as if they were declined" do
					transaction.should_not_receive(:new)
					expect(account.limit).to eq(1000)
					account.stub(:balance).and_return(900)
					account.charge(101)
				end

				it "allows charges that are within the limit amount" do
					transaction.should_receive(:new).twice
					expect(account.limit).to eq(1000)
					account.stub(:balance).and_return(900)
					account.charge(90)
					account.charge(100)
				end

			end
		end

		context "balance" do
			context "negative balance" do
				let(:transactions) { [double("Transaction", transaction_type: :credit, amount: 300),
									  double("Transaction", transaction_type: :charge, amount: 200),
								      double("Transaction", transaction_type: :credit, amount: 121)] }				
				let(:account) { Account.new transactions: transactions, validator: validator, transaction: transaction }
				
				it "calculates a negative balance for transactions that would drop the balance below 0" do			
					expect(account.balance).to eq(-221)
				end
			end
			
			context "positive balance" do
				let(:transactions) { [double("Transaction", transaction_type: :charge, amount: 300),
									  double("Transaction", transaction_type: :credit, amount: 200),
								      double("Transaction", transaction_type: :charge, amount: 121)] }				
				let(:account) { Account.new transactions: transactions, validator: validator, transaction: transaction }
				
				it "calculates a positive balance with mixed transactions" do			
					expect(account.balance).to eq(221)
				end
			end


			context "balance string" do
				it "returns a positive balance string for valid cards and positive balance" do
					validator.stub(:valid?).and_return(true)
					account.stub(:balance).and_return(555)
					expect(account.balance_string).to eq("$555")
				end

				it "returns error when the account (card) is not valid" do
					validator.stub(:valid?).and_return(false)
					account.stub(:balance).and_return(555)
					expect(account.balance_string).to eq("error")
				end

				it "returns a negative balance string with the dollar sign before the minus sign" do
					validator.stub(:valid?).and_return(true)
					account.stub(:balance).and_return(-555)
					expect(account.balance_string).to eq("$-555")
				end			  
			end

		end
		
		context "invalid card behavior" do
			before(:each) do
				validator.stub(:valid?).and_return(false)
			end

			it "ignores charges" do
				transaction.should_not_receive(:new)
				account.charge 300
			end

			it "ignores credits" do
				transaction.should_not_receive(:new)
				account.credit 300
			end
		end
		
	end 


end