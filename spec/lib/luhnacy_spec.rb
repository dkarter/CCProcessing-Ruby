require 'spec_helper'
require "Luhnacy"

describe "Luhnacy" do
  it "should be able to identify if a number satisfies Luhn" do
    valid_number = '49927398716'
    Luhnacy.valid?(valid_number).should be_true
  end

  it "should be able to identify if a number does not satisfy Luhn" do
    invalid_number = '49927398715'
    Luhnacy.valid?(invalid_number).should be_false
  end
end