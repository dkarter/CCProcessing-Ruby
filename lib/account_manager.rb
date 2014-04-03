require_relative 'luhnacy'

class AccountManager
	def initialize(attr = {})
		@accounts = attr.fetch(:accounts, Hash.new)
		@account = attr.fetch(:account)
		@validator = attr.fetch(:validator)
		@transaction = attr.fetch(:transaction)
	end

	def add_account(name, cc, limit)
		unless exists? name
			@accounts[name] = @account.new(name: name, cc: cc, limit: limit, validator: @validator, transaction: @transaction)
		end
	end

	def get_by_name(name)
		@accounts[name] if exists? name
	end

	def charge_account(name, amount)
		@accounts[name].charge(amount) if exists? name
	end

	def credit_account(name, amount)
		@accounts[name].credit(amount) if exists? name
	end


	def summarize_accounts
		sum = ''
		sorted_accts = @accounts.sort_by { |k, v| k }
		sorted_accts.each do |v| 
			acct = @accounts[v[0]]
			sum += "#{acct.name}: #{acct.balance_string}\n"
		end
		return sum.chomp
	end

	private
	def exists?(name)
		@accounts.has_key? name
	end
end