#!/usr/bin/ruby
require "rubygems"
require "thor"
require_relative "ccprocapp"

class Main < Thor
  include Thor::Actions
  
  desc "interactive", "Starts the interactive command mode"
  def interactive
    app = CCProcApp.new
    app.start(nil)
  end

  desc "file <filename>", "loads and processes a file in which each line is a command"
  def file(filename)
    if filename
      app = CCProcApp.new
      app.start(filename)
    else
      puts "please provide a file name"
    end
  end
end

Main.start(ARGV)