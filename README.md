CCProcessing
============

CCProcApp is a Demo App build for the interview process for Braintree

## Usage Instructions
To use open a terminal window on your Mac OSX.

### Install
Extract the files from the supplied zip file, keeping the directory structure intact. Navigate to the program directory and enter the following:

	$ bundle install

This will install the Thor and RSpec gems.

### Run
To view available commands

	$ ruby main.rb help

To run the program in interactive mode:

	$ ruby main.rb interactive

To load a file and process each line as a command:

	$ ruby main.rb file <filename>
	
##### Interactive mode
When entering interactive mode you will see the following prompt:
	
	Please enter a command followed by space delimited parameters.
	Commands include:
	1. Add <name> <cc number> $<amount>
	2. Charge <name> $<amount>
	3. Credit <name> $<amount>
	4. Summary
	5. Quit
	> 

Enter a command and press the {return} button on your keyboard to submit the command and enter a new one. The interactive mode works in a similar manner to the terminal. To stop type “quit” and you will return to the terminal.

Please note that the “quit” command does not write the summary, you will have to type “Summary” to view the summary.

Commands are not case sensitve but account names are. You cannot add an account with the same name twice.

#### File mode
I have provided a file with the application for easy testing. This file contains the example from the instructions file and is used in one of the tests for verification. To load the test file navigate to the program directory and type:

	$ ruby main.rb file spec/test.in


### Test
To run the test suite navigate to the program directory and enter:

	$ rspec
	
You should see all the tests (58) have passed and displayed in green.

##  Overview of Design Decisions

## Why Ruby
lightweight, elegant syntax, braintree works with ruby on rails, does not require to compile each time, powerful bdd framework, I work on a mac and ruby works great in the terminal.
gems are really helpful for saving time
