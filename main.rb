#!/usr/bin/ruby
require "rubygems"
require "thor"
require_relative "cc_processing_client"

class Main < Thor
  include Thor::Actions
  
  desc "interactive", "Starts the interactive command mode"
  def interactive
      app = CCProcessingClient.new
      app.prompt_for_commands
  end

  desc "file <filename>", "loads and processes a file in which each line is a command"
  def file(filename)
    if filename
        app = CCProcessingClient.new
        app.process_file(filename)
    else
      puts "please provide a file name"
    end
  end
end

Main.start(ARGV)