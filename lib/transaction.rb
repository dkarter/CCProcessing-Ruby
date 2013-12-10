class Transaction
  attr_accessor :amount, :timestamp

  def initialize(options = {})
    @amount = options[:amount]
    @transaction_type = options[:transaction_type]
    @timestamp = options[:timestamp]
  end

  def transaction_type
    return :unknown
  end



end