require 'rubygems'
require_relative 'luhnacy'
require_relative 'transaction'

class Account
  attr_accessor :name, :cc, :limit
  
  

  def initialize(name = "", cc = "", limit = 0)
    @name = name
    @limit = limit
    @cc = cc
    @transactions = Array.new
  end

  def charge(amount)
    @transactions << Transaction.new(:charge, amount) if valid? && (balance + amount) <= limit
  end

  def credit(amount)
    @transactions << Transaction.new(:credit, amount) if valid?
  end

  def balance
    sum = 0
    @transactions.each do |trans| 
      if trans.transaction_type == :credit
        sum += (0 - trans.amount)
      elsif trans.transaction_type == :charge
        sum += trans.amount
      end
    end

    return sum
  end

  def valid?
    Luhnacy.valid?(cc)
  end
  
end