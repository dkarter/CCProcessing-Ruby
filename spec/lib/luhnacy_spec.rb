require "spec_helper"
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

  context "detects valid cards" do
	  # cc nums from http://www.getcreditcardnumbers.com/
	  
	  it "detects Visa cards" do    
		cards = ["4556901563769131",
				 "4121277443502299",
				 "4916444426715657",
				 "4024007195099790",
				 "4024007154225758",
				 "4232186631466",
				 "4514386983999",
				 "4485187130991",
				 "4532244819916",
				 "4532056159302"]
		cards.each do |card|
		  expect(Luhnacy.valid?(card)).to be_true
		end
	  end
	  
	  it "detects Mastercard cards" do    
		cards = ["5534042043980859",
				 "5560181367900791",
				 "5329201577198960",
				 "5165710228198226",
				 "5390578404244826"]
		cards.each do |card|
		  expect(Luhnacy.valid?(card)).to be_true
		end
	  end
	end

	it "detects invalid cards" do
		cards = ["4556931",
				 "412127744350229234329",
				 "4234443234553",
				 "0024007195099790",
				 "1111111111111111",
				 "3",
				 "4516386983990",
				 "4485197130991",
				 "4532244819992",
				 "4532056153303"]
		cards.each do |card|
		  expect(Luhnacy.valid?(card)).to be_false
		end
	end
end