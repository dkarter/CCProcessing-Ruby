require "thor"

class CCProc < Thor
  package_name "CCProc"
  
  desc "hello NAME", "say hello to NAME"
  def hello(name)
    puts "Hello #{name}!"
  end
  
end

CCProc.start(ARGV)