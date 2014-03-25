# require "spec_helper"
# require 'rspec/mocks/standalone'
# require_relative "../ccprocapp"



# describe CCProcApp do


#   it "has no accounts on start" do
#     subject.get_accounts.length.should be 0
#     subject.get_accounts.should be {}
#   end


#   #it "shows instructions and prompts if run without a filename" do
#     # could not get this to work
#     # STDOUT.should_receive(:puts).with "Please enter"
#     # STDIN.should_receive(:read).and_return("quit")
#   #end


  

#   context "perform account actions" do
#     it "Add" do
#       subject.process_command("add Tom 4111111111111111 $1000")
#       subject.get_accounts.should include "Tom"
#       subject.get_accounts["Tom"].cc.should == "4111111111111111"
#       subject.get_accounts["Tom"].limit.should == 1000
#       subject.get_accounts["Tom"].name.should == "Tom"

#       subject.process_command("add Lisa 5454545454545454 $3000")
#       subject.get_accounts.should include "Lisa"
#       subject.get_accounts["Lisa"].cc.should == "5454545454545454"
#       subject.get_accounts["Lisa"].limit.should == 3000
#       subject.get_accounts["Lisa"].name.should == "Lisa"

#       subject.process_command("add Quincy 1234567890123456 $2000")
#       subject.get_accounts.should include "Quincy"
#       subject.get_accounts["Quincy"].cc.should == "1234567890123456"
#       subject.get_accounts["Quincy"].limit.should == 2000
#       subject.get_accounts["Quincy"].name.should == "Quincy"
#     end

#     it "does not add an account if one with the same name already exists" do
#       subject.get_accounts.length.should be 0

#       subject.process_command("add Quincy 1234567890123456 $2000")
#       subject.get_accounts.should include "Quincy"
#       subject.get_accounts["Quincy"].cc.should == "1234567890123456"
#       subject.get_accounts["Quincy"].limit.should == 2000
#       subject.get_accounts["Quincy"].name.should == "Quincy"

#       subject.get_accounts.length.should be 1

#       subject.process_command("add Quincy 5454545454545454 $3000")
#       subject.get_accounts["Quincy"].cc.should == "1234567890123456"
#       subject.get_accounts["Quincy"].limit.should == 2000
#       subject.get_accounts["Quincy"].name.should == "Quincy"

#       subject.get_accounts.length.should be 1
#     end

#     it "Charge" do
#       subject.add_account("Test", "5451448349471932", 1999)
#       subject.add_account("Test1", "342799678717939", 500)
#       subject.get_accounts.should include "Test"
#       subject.get_accounts.should include "Test1"
#       subject.get_accounts["Test"].balance.should be 0
#       subject.get_accounts["Test1"].balance.should be 0
#       subject.process_command("charge Test $300")
#       subject.get_accounts["Test"].balance.should be 300
#       subject.get_accounts["Test1"].balance.should be 0
#       subject.process_command("charge Test1 $401")
#       subject.get_accounts["Test"].balance.should be 300
#       subject.get_accounts["Test1"].balance.should be 401
#     end  

#     it "Credit" do
#       #prep
#       subject.add_account("Test", "5451448349471932", 1999)
#       subject.add_account("Test1", "342799678717939", 500)
#       subject.get_accounts.should include "Test"
#       subject.get_accounts.should include "Test1"
#       subject.get_accounts["Test"].balance.should be 0
#       subject.get_accounts["Test1"].balance.should be 0
#       subject.process_command("charge Test $300")      
#       subject.get_accounts["Test"].balance.should be 300
#       subject.get_accounts["Test1"].balance.should be 0
#       subject.process_command("Charge Test1 $401")
#       subject.get_accounts["Test"].balance.should be 300
#       subject.get_accounts["Test1"].balance.should be 401

#       subject.process_command("Credit Test1 $100")
#       subject.get_accounts["Test"].balance.should be 300
#       subject.get_accounts["Test1"].balance.should be 301

#       subject.process_command("Credit Test $299")
#       subject.get_accounts["Test"].balance.should be 1
#       subject.get_accounts["Test1"].balance.should be 301
#     end
#   end
  
  
#   context "validation" do
#       context "accepts and parses command" do
#         context "with space delimited arguments" do
#           it "Add" do
#             subject.process_command("Add Test 4111111111111111 $100").should == :add
#             subject.process_command("add Test1 5152234410912323 $99").should == :add
#           end
          
#           it "Charge" do
#             subject.process_command("Charge Test $400").should == :charge
#             subject.process_command("charge Test $400").should == :charge
#           end

#           it "Credit" do
#             subject.process_command("Credit Test $10").should == :credit
#             subject.process_command("credit Test $10").should == :credit
#           end
#         end

#         context "with no arguments" do
#           it "Summary" do
#             subject.process_command("Summary").should == :summary
#             subject.process_command("summary").should == :summary
#           end
#           it "Quit" do
#             subject.process_command("Quit").should == :quit
#             subject.process_command("quit").should == :quit
#           end

#         end
#       end 

#       context "does not accept commands" do
#         it "recognizes invalid command" do
#           subject.process_command("debit card transaction 1000").should == :invalid_command
#           subject.process_command("addsome Test 324234234234234 $100") == :invalid_command
#           subject.process_command("") == :invalid_command
#         end

#         it "with wrong arguments" do
#           subject.process_command("add Test1 5152234410912323 $99 argextra argextra").should_not == :add
#           subject.process_command("add nolimit 5152234410912323").should_not == :add
#           subject.process_command("add nolimit $199").should_not == :add
#           subject.process_command("add nolimit $001").should_not == :add

#           subject.process_command("charge $400").should_not == :charge
#           subject.process_command("charge Test 100").should_not == :charge
#           subject.process_command("charge Test").should_not == :charge
#           subject.process_command("charge Test bla").should_not == :charge
#           subject.process_command("charge Test $100 extra1 1").should_not == :charge
#           subject.process_command("charge Test $100 1").should_not == :charge

#           subject.process_command("credit $400").should_not == :credit
#           subject.process_command("credit Test 100").should_not == :credit
#           subject.process_command("credit Test").should_not == :credit
#           subject.process_command("credit Test bla").should_not == :credit
#           subject.process_command("credit Test $100 extra1 1").should_not == :credit
#           subject.process_command("credit Test $100 1").should_not == :credit
#         end

        
#       end
#   end

#   context "displays summary" do
#     it "contains a list of all account names and balances and error where card is not valid" do
#       subject.start(Dir.pwd + '/spec/test.in')
#       subject.summary.should == "Lisa: $-93\nQuincy: error\nTom: $500"
#     end
#   end
  
#   it "reads and parses a file with commands" do
#     subject.start(Dir.pwd + '/spec/test.in')
#     subject.get_accounts.length.should be 3

#     subject.get_accounts.should include "Tom"
#     subject.get_accounts["Tom"].cc.should == "4111111111111111"
#     subject.get_accounts["Tom"].limit.should == 1000
#     subject.get_accounts["Tom"].name.should == "Tom"

    
#     subject.get_accounts.should include "Lisa"
#     subject.get_accounts["Lisa"].cc.should == "5454545454545454"
#     subject.get_accounts["Lisa"].limit.should == 3000
#     subject.get_accounts["Lisa"].name.should == "Lisa"

    
#     subject.get_accounts.should include "Quincy"
#     subject.get_accounts["Quincy"].cc.should == "1234567890123456"
#     subject.get_accounts["Quincy"].limit.should == 2000
#     subject.get_accounts["Quincy"].name.should == "Quincy"

#     subject.get_accounts["Tom"].balance.should == 500
#     subject.get_accounts["Lisa"].balance.should == -93
#     subject.get_accounts["Quincy"].balance.should == 0
#   end    
  
  

# end