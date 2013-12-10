require "rubygems"
require "thor"
require_relative "lib/account"

class CCProcApp < Thor
  include Thor::Actions
  no_commands do
    @accounts = nil

    def initialize
      @accounts = Hash.new  
    end
    
    # def prompt(args)
    #   print args
    #   gets
    # end

    def process_file(filename)
      begin
        File.open(filename, "r") do |infile|
          while (line = infile.gets)
              process_command line
          end
        end
        
        print_summary

      rescue => err
          puts "Exception: #{err}"
          err
      end
    end


    def start(filename = nil)
      if filename
        process_file filename
      else
        prompt_for_commands
      end
    end

    def print_instructions
      puts "Please enter a command followed by space delimited parameters.\n"
      puts "Commands include:\n"
      puts "1. Add <name> <cc number> $<amount>\n"
      puts "2. Charge <name> $<amount>\n"
      puts "3. Credit <name> $<amount>\n"
      puts "4. Summary\n"
      puts "5. Quit"
    end


    def prompt_for_commands
      print_instructions

      quitting = false

      while !quitting
        command = ask("> ")
        
        result = process_command(command)

        quitting = true if result == :quit
      end
    end

    def process_command(command)
      command_args = command.split
      command_name = command_args[0].downcase if command_args[0]
      

      case command_name
      when "quit"
        :quit

      when "add"
        if /^[aA]{1}dd \w+ \d+ \$\d+$/.match(command)
          add_account(command_args[1], command_args[2], command_args[3].tr('$','').to_i)
          :add
        else
          :invalid_command
        end

      when "credit"
        if /^[cC]{1}redit \w+ \$\d+$/.match(command)
          credit_account(command_args[1], command_args[2].tr('$','').to_i)
          :credit
        else
          :invalid_command
        end

      when "charge"
        if /^[cC]{1}harge \w+ \$\d+$/.match(command)
          charge_account(command_args[1], command_args[2].tr('$','').to_i)
          :charge
        else
          :invalid_command
        end

      when "summary"
        print_summary
        :summary

      else
        :invalid_command

      end
    end

    def summary
      sum = ''
      sorted_accts = @accounts.sort_by { |k, v| k}
      # raise sorted_accts.to_s
      sorted_accts.each do |v| 
        acct = @accounts[v[0]]
        sum += acct.name + ': '
        sum += (acct.valid? ? '$' + acct.balance.to_s : 'error') + "\n"
      end
      return sum.chomp
    end

    def print_summary
      puts summary
    end
    
    def add_account(name, cc, limit)
      if !@accounts.has_key? name
        @accounts[name] = Account.new(name, cc, limit)
      end
    end

    def credit_account(name, amount)
      if @accounts.has_key? name
        @accounts[name].credit(amount)
      end
    end

    def charge_account(name, amount)
      if @accounts.has_key? name
        @accounts[name].charge(amount)
      end
    end

    def get_accounts
      @accounts
    end
  end

end