CCProcessing
============

CCProcessing is a demo app built by Dorian Karter for the Braintree Software Engineer interview process

## Dependencies
This application uses the following gems:
 
### Functional dependencies:

 - Thor - for command line tools and feature descriptions
 
### Development dependencies:

 - RSpec - for testing
 - Guard - for continuous testing workflow
 	+ Guard-rspec - integrates Guard and RSpec
 	+ terminal-notifier-guard - for guard notifications on Mac OSX

## Usage Instructions
To use open a terminal window on your Mac OS X or Linux.

### Install
Extract the files from the supplied zip file, keeping the directory structure intact. Navigate to the program directory and enter the following:

	$ bundle install

This will install the necessary gems.

### Run
To view available program modes

	$ ruby main.rb help

To run the program in interactive mode (stdin):

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
	5. Help
	6. Quit
	> 

Enter a command and press the {return} button on your keyboard to submit the command and enter a new one. The interactive mode works in a similar manner to the terminal. To stop type “quit” and you will return to the terminal.

Note that account names are *case-sensitive*. You cannot add an account with the same name twice.

#### File mode
I have provided a file with the application for easy testing. This file contains the example from the instructions file and is used in one of the tests for verification. To load the test file navigate to the program directory and type:

	$ ruby main.rb file spec/test.in


### Testing
First make sure you followed the installations steps (bundle install) and got the necessary version of RSpec.

To run the test suite navigate to the program directory and enter:

	$ rspec

You should see all the tests (41) have passed and displayed in green.

##  Overview of Design Decisions
While developing the application I tried to adhere as much as possible (without overcomplicating) to the **SOLID Principles of Object-Oriented Design**. I believe that adhering to those principles makes for loosely-coupled, flexible, healthy, and maintainable code. This design decision was inspired by a book called **Practical Object-Oriented Design in Ruby by Sandi Metz**, and by the **Clean Code series by Robert C. Martin**.

In order to make the code testable and mobile I used the **Dependency Injection/Inversion pattern**. This eliminated all couplings between the different components. The client code is the only exception to the rule and serves as an integration test which combines the different components together. 

I divided the program into the following parts: 

- **Account**: Stores the user's account (name, card, limit, transactions, calculates balance)
- **AccountManager**: manages a hash of the app's active accounts (add account, send actions to an active account, summarize accounts)
- **Transaction**: A simple model to store the type of a transaction (credit/charge) and the amount associated with it
- **CommandInterpreter**: A class which interprets textual commands and sends messages to it's dependencies to execute those commands
- **Luhnacy**: a validator model implementing Luhn 10 which I extracted from a gem named Luhnacy.
- **CCProcessingClient**: integrates the different components and provides user interfaces for accessing the program (file processing/interactive prompt) 
- **main** - Uses Thor to expose command-line options such as 'interactive' and 'file'


## Why Ruby
Ruby provides a great testing framework and tools to assist in TDD. RSpec provides with great mocking and stubbing tools which made testing the dependency injection design pattern a pleasure. Guard makes sure that after every change made to the code the tests immediately relevant to that code run.

Although I could have written this task in any object-oriented language fairly easily, I prefer to showcase my Ruby skills considering that Braintree uses Ruby for active development.

## Final Notes
Thank you for taking the time out of your busy day to read through this guide and evaluate my code! If you encounter any issues at all do not hesitate to contact me at (773) 470-6209 or [jobs@doriankarter.com](mailto:jobs@doriankarter.com)