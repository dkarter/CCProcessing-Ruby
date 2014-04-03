require "rubygems"
require_relative "lib/account"
require_relative "lib/account_manager"
require_relative "lib/command_interpreter"
require_relative "lib/luhnacy"
require_relative "lib/transaction"

class CCProcessingClient

    def initialize
      @account_manager = AccountManager.new account: Account, validator: Luhnacy, transaction: Transaction
      @interpreter = CommandInterpreter.new self, @account_manager
    end

    def process_file(filename)
      begin
        File.open(filename, "r") do |infile|
          while (line = infile.gets)
              @interpreter.interpret_command line
          end
        end
        
        print_summary

      rescue => err
          puts "Exception: #{err}"
          err
      end
    end

    def prompt_for_commands
      puts instructions

      @quit_requested = false

      until @quit_requested
        command = prompt("> ")
        @interpreter.interpret_command command
      end

      print_summary
    end
    

    def show_help
      puts instructions
    end

    def quit
      @quit_requested = true
    end

    def print_summary
      puts @account_manager.summarize_accounts
    end
        
    private
    def prompt(*args)
      print(*args)
      $stdin.gets.chomp
    end
    
    def instructions
      res = "Please enter a command followed by space delimited parameters.\n"
      res += "Commands include:\n"
      res += "1. Add <name> <cc number> $<amount>\n"
      res += "2. Charge <name> $<amount>\n"
      res += "3. Credit <name> $<amount>\n"
      res += "4. Summary\n"
      res += "5. Help\n"
      res += "6. Quit"
      return res
    end    

end