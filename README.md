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
First we must make sure you have rspec installed on your system, for that you are going to need to run:
	
	$ gem install rspec

To run the test suite navigate to the program directory and enter:

	$ rspec

You should see all the tests (58) have passed and displayed in green.

##  Overview of Design Decisions
I chose to use BDD with RSpec because it makes it easy to ensure all the requirements for the software have been implemented in the code.

I divided the program into Accounts and Transactions with an interpreter model (main and CCProcApp) to help execute the client commands.

The transactions can be of type credit or charge and are stored in an array in the Account. The Account is responsible for calculating the balance by iterating over the transactions and summing up the charges as positive and credits as negative.

Ideally, I would separate the CCProcApp into an accounts_controller which will contain the add, charge, credit and summary function. However, for the sake of simplicity and time I decided to put them in one. 

## Why Ruby
1. Lightweight
2. Elegant syntax
3. Does not require to compile each time
4. Powerful bdd framework (RSpec)
5. Works great on Mac
6. Gems are really helpful and time saving (e.g. Luhn 10 gem)
7. Braintree works with Ruby on Rails so this project is a good opportunity to showcase my skills 
