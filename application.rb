#!/usr/bin/ruby

# To count words in a file and create a word hash with
# words and their frequency

#Usage: ruby application.rb <filename>

$word_count = 0
$word_hash = Hash.new

def $word_hash.to_s
	self.each do |key, value|
		p "#{key}" + "         " + "#{value}"
	end
end

def perform_job
	if File.file?(ARGV[0])
		File.open(ARGV[0], 'r') do |file|
			file.each do |line|
				tmp_array = line.split(" ")
				tmp_array.each do |word|
					if word.scan(/[^a-zA-Z]/).empty?
						$word_count += 1
						$word_hash.key?(word) ? $word_hash[word] += 1 : $word_hash[word] = 1
					end
				end
			end
		end
	else
		p "File does not exist: " + ARGV[0]
		exit
	end
end

start_time = Time.now.to_i
perform_job
end_time = Time.now.to_i

total_time_spent = end_time - start_time

p "Total number of words: " + $word_count.to_s
p total_time_spent.to_s + " seconds"
$word_hash.to_s
