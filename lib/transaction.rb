class Transaction
  attr_accessor :amount

  def initialize(transaction_type = 0, amount = 0)
    @amount = amount
    @transaction_type = transaction_type
  end

  def transaction_type
    @transaction_type
  end



end