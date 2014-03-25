module TransactionMockHelpers 
	def credit_tran(amount)
		tran :credit, amount
	end

	def charge_tran(amount)
		tran :charge, amount
	end

	def tran(tran_type, amount)
		double("Transaction", transaction_type: tran_type, amount: amount)
	end
end

RSpec.configure do |c|
	c.include TransactionMockHelpers
end