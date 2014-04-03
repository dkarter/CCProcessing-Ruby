require 'spec_helper'
require_relative '../cc_processing_client'

describe CCProcessingClient do
  let(:client) { CCProcessingClient.new }
  
  context "responds to command interpreter messages" do
	it "responds to quit" do
		expect(client).to respond_to(:quit)
	end
	it "responds to show_help" do
		expect(client).to respond_to(:show_help)
	end
	it "responds to print_summary" do
		expect(client).to respond_to(:print_summary)
	end
  end
  
  context "responds to client methods" do
	it "responds to process_file" do
		expect(client).to respond_to(:process_file)
	end
	it "responds to prompt_for_commands" do
		expect(client).to respond_to(:prompt_for_commands)
	end
  end

  

end