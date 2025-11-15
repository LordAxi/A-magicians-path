require "sys/cpu"
require "pp"

puts "VERSION: " + Sys::CPU::VERSION
puts "========"

puts "Load Average: " + Sys::CPU.load_avg.join(", ")

puts "Processor Info:"
puts "==============="
pp Sys::CPU.processors

puts "CPU STATS:"
puts "=========:"

pp Sys::CPU.cpu_stats