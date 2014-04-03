class Account
  attr_accessor :name, :cc, :limit

  def initialize(attr = {})
    @name = attr.fetch(:name, "")
    @limit = attr.fetch(:limit, 0)
    @cc = attr.fetch(:cc, "")
    @transactions = attr.fetch(:transactions, [])
    @validator = attr.fetch(:validator)
    @transaction = attr.fetch(:transaction)
  end

  def charge(amount)
    @transactions << @transaction.new(:charge, amount) if valid? && (balance + amount) <= limit
  end

  def credit(amount)
    @transactions << @transaction.new(:credit, amount) if valid?
  end

  def balance
    sum = 0
    @transactions.each do |trans| 
      if trans.transaction_type == :credit
        sum -= trans.amount
      elsif trans.transaction_type == :charge
        sum += trans.amount
      end
    end

    return sum
  end

  def balance_string
    valid? ? '$' + balance.to_s : 'error'
  end

  def valid?
    @validator.valid? cc
  end
  
end