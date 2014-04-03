require 'spec_helper'
require_relative '../../lib/account_manager'

describe AccountManager do
	let(:account) { double("account", new: nil) }
	let(:validator) { double("validator") }
	let(:transaction) { double("transaction") }
	let(:account_manager) { AccountManager.new account: account, validator: validator, transaction: transaction }

  	context "add account" do
  	  it "can add an account" do
	  	account.should_receive(:new).with({ name: "test_acct", cc: "cc_num", limit: 1000, validator: validator, transaction: transaction })
	  	account_manager.add_account("test_acct", "cc_num", 1000)
	  end

	  it "does not add an account if one with the same name already exists" do
	  	account.should_receive(:new).once.with(hash_including(name: "test_acct"))
	  	account_manager.add_account("test_acct", "test", 300)
	  	account_manager.add_account("test_acct", "testcard", 1300)	  	
	  end
	end

	context "account actions" do
		before(:each) do
			account.stub(:new).and_return(account)
			account_manager.add_account("test_acct", "test", 300)
		end
		it "can charge an account" do
			account.should_receive(:charge).with(20)
			account_manager.charge_account("test_acct", 20)
		end

		it "can credit an account" do
			account.should_receive(:credit).with(35)
			account_manager.credit_account("test_acct", 35)
		end
	end

	it "can get an account by name" do
		account.stub(:new).and_return(account)
		account_manager.add_account("test_acct", "test", 300)
		expect(account_manager.get_by_name("test_acct")).to eq(account) 
	end

	it "can summarize accounts and sort them by name" do
		accounts = { 
			"Quincy" => double("account", name: "Quincy", balance_string: "error"),
			"Tom" => double("account", name: "Tom", balance_string: "$500"),
			"Lisa" => double("account", name: "Lisa", balance_string: "$-93") 
		}

		account_manager = AccountManager.new account: account, validator: validator, accounts: accounts, transaction: transaction
		expect(account_manager.summarize_accounts).to eq("Lisa: $-93\nQuincy: error\nTom: $500")
	end
end