require_relative "lib/account"

class CCProcApp
  @accounts = nil

  def initialize(app_output = $stdout, app_input = $stdin)
    @app_output = app_output
    @app_input = app_input
    @accounts = Hash.new  
  end
  
  def prompt(*args)
    @app_output = *args
    gets
  end

  def app_output
    @app_output
  end

  def out=(txt)
    @app_output = txt
  end

  def process_file(filename)
    begin
      file = File.new(filename, "r")
      while (line = file.gets)
          process_command(line)
      end
      file.close
      
      print_summary
      
    rescue => err
        puts "Exception: #{err}"
        err
    end
  end


  def start(filename = nil)
    if filename
      
      abort
    else
      prompt_for_commands
    end
  end

  def print_instructions
    out "Please enter a command followed by space delimited parameters.\n"
    out "Commands include:\n"
    out "1. Add <name> <cc number> $<amount>\n"
    out "2. Charge <name> $<amount>\n"
    out "3. Credit <name> $<amount>\n"
    out "4. Summary\n"
    out "5. Quit"
  end


  def prompt_for_commands
    print_instructions

    quitting = false

    while !quitting
      command = prompt("> ")
      
      result = process_command(command)

      quitting = true if result == :quit
    end
  end

  def process_command(command)
    command_args = command.split
    command_name = command_args[0].downcase
    

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

  def print_summary
    
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