#!/usr/bin/ruby

# To count words in a file and create a word hash with
# words and their frequency using MapReduce approach

#Usage: ruby mapreduce_solution.rb <filename>

$word_count = 0
$word_hash_array = Array.new
$word_hash = Hash.new

def $word_hash_array.mapper(word)
	self.push({word => 1})
end

def $word_hash_array.reducer
	self.each do |hash|
		hash.each do |key, value|
			$word_hash.key?(key) ? $word_hash[key] += 1 : $word_hash[key] = 1
		end
	end
end

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
						$word_hash_array.mapper(word)
					end
				end
			end
		end
		$word_hash_array.reducer
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
