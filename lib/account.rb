require 'rubygems'
require 'luhnacy'

class Account
  attr_accessor :name, :cc, :limit
  
  

  def initialize(name = "", cc = "", limit = 0)
    @name = name
    @limit = limit
    @cc = cc
    @transactions = Array.new
  end

  def balance
    return 0
  end

  def valid?
    Luhnacy.valid?(cc)
  end
  
end