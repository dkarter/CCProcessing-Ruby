require "spec_helper"
require_relative "../ccprocapp"

describe CCProcApp do
  it "has no accounts on start"
  it "shows instructions and prompts if run without a filename" do
    # STDOUT.should_receive(:puts).with "Please enter"
    # STDIN.should_receive(:read).and_return("quit")
  end

  context "accepts command" do
    context "with space delimited arguments" do
      it "Add" do
        subject.process_command("add", "Add Test 4111111111111111 $100").should == :add
      end

      it "Charge" do
        subject.process_command("charge", "Charge Test $400").should == :charge
      end

      it "Credit" do
        subject.process_command("credit", "Credit Test $10").should == :credit
      end
    end

    context "with no arguments" do
      it "Summary" do
        subject.process_command("summary", "Summary").should == :summary
      end
      it "Quit" do
        subject.process_command("quit", "Quit").should == :quit
      end

    end
  end
  
  it "adds an account" do
    subject.process_command("add", "add Test 4111111111111111 $1000")
    subject.get_accounts.should include "Test"

  end
  

  it "accepts inputs with dollar sign for amount and parses the amount correctly"
  
  
  it "reads a file if started using the -f parameter"
  it "generates and writes a summary to stdout when all input has been read and processed"
  it "displays error instead of an account balance if invalid cc is provided"

end