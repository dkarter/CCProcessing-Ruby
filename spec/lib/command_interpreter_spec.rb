require "spec_helper"
require_relative "../../lib/command_interpreter"

describe CommandInterpreter do
	let(:owner) { double("owner") }
	let(:account_manager) { double("account_manager") }
	let(:interpreter) { CommandInterpreter.new owner, account_manager }


	it "can interpret a command" do
		expect(interpreter).to respond_to(:interpret_command)
	end

	context "valid commands" do
		context "commands to owner" do
			it "interprets quit" do
				owner.should_receive(:quit)
				interpreter.interpret_command("quit")
			end

			it "interprets summary" do
				owner.should_receive(:print_summary)
				interpreter.interpret_command("summary")
			end

			it "interprets help" do
				owner.should_receive(:show_help)
				interpreter.interpret_command("help")
			end  
		end
		
		context "commands to account manager" do
			it "interprets add" do
				account_manager.should_receive(:add_account).with("John", "4111111111111111", 1000)
				interpreter.interpret_command("add John 4111111111111111 $1000")
		  	end

		  	it "interprets charge" do
				account_manager.should_receive(:charge_account).with("Test", 1234)
				interpreter.interpret_command("charge Test $1234")
		  	end

		  	it "interprets credit" do
				account_manager.should_receive(:credit_account).with("Doe", 1234)
				interpreter.interpret_command("credit Doe $1234")
		  	end  
		end

		
	end


	
  	context "invalid commands" do
  	  it "detects invalid commands" do
  	  	invalid_commands = ["add name cc limit", 
  	  						"charge name $$1000",
  	  						"charge name 1000",
  	  						"credit name 1000$",
  	  						"credit  $1000",
  	  						"summary all",
  	  						"help me",
  	  						"1quit",
  	  						"add", "credit", "charge"]

  	  	invalid_commands.each do |cmd|
  	  		expect(interpreter.interpret_command(cmd)).to eq(:invalid_command)
  	  	end

  	  end
  	end

end