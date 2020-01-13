#!/user/bin/ruby
require './lib/setup.rb'
require 'colorize'
input = {}

system "#{(Gem.win_platform?) ? 'cls' : 'clear'}"
puts ""

puts " What would you like you to call your project?"
print "    ➢ ".blink
input[:project_name] = gets.chomp
puts ""

puts " What Gems do you want?"
print "    ➢ ".blink
input[:gems] = gets.chomp
puts ""

puts " What tables would you like?"
print "    ➢ ".blink
input[:tables] = gets.chomp
puts ""

SetupWizard.new(input).run
