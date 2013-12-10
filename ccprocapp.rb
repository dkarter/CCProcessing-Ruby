require_relative "lib/account"

class CCProcApp
  @accounts = nil

  def initialize
    @accounts = Hash.new  
  end
  
  def prompt(*args)
    print(*args)
    gets
  end


  def start(file = nil)
    if file
      puts "Got file..."
      abort
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
      command = prompt("> ")
      command_name = command.downcase.split[0]

      result = process_command(command_name, command)

      quitting = true if result == :quit
    end
  end

  def process_command(command_name, command_string)
    case command_name
    when "quit"
      :quit
    when "add"
      command_args = command_string.split
      #validate with regex matcher
      add_account(name: command_args[1], cc: command_args[2], limit: command_args[3])
      :add
    when "credit"
      :credit
    when "charge"
      :charge
    when "summary"
      :summary
    else
      :invalid_command
      #puts "Invalid Command"
    end
  end

  def print_summary
    puts "not implemented"
  end
  
  def add_account(name, cc, limit)
    if !@accounts.has_key? name
      @accounts[name] = Account.new(name, cc, limit)
    end
  end

  def get_accounts
    @accounts
  end
end