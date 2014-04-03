class CommandInterpreter
	attr_reader :owner, :account_manager

	def initialize(owner, account_manager)
		@owner = owner
		@account_manager = account_manager
	end

	def interpret_command(command)
      	return :invalid_command unless valid_command?(command)
      
      
      	command_args = command_args(command)
		command_name = command_name(command_args)

		case command_name
		when "add"
			name, cc, limit = command_args[1], command_args[2], parse_amount(command_args[3])
			account_manager.add_account name, cc, limit

		when "credit"
			name, amount = command_args[1], parse_amount(command_args[2])
			account_manager.credit_account name, amount

		when "charge"
			name, amount = command_args[1], parse_amount(command_args[2])
			account_manager.charge_account name, amount

		when "summary"
			owner.print_summary
		when "help"
			owner.show_help
		when "quit"
			owner.quit
		end
    end

    private
    def command_name(command_args)
    	command_args[0].downcase if command_args[0]
    end

    def command_args(command)
    	command.split
    end


    def valid_command?(command)
    	command.match(/^(help|summary|quit|add \w+ \d{12,19} \$\d+|credit \w+ \$\d+$|charge \w+ \$\d+)$/i)
    end

    def parse_amount(arg_string)
    	arg_string.tr('$','').to_i
    end
end