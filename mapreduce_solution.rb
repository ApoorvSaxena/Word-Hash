#!/usr/bin/ruby

require 'pathname'

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

def $word_hash.write_to_file
	output_file_path = Pathname.getwd.to_s + "/output/output.txt"
	if File.file?(output_file_path)
		File.open(output_file_path, 'w+') do |file|
			self.each do |key, value|
				file.write("#{key}\t#{value}\n")
			end
		end	
	else
		p "Output file not found"
	end
end

def perform_job
	input_file_path = Pathname.getwd.to_s + "/input"
	Dir.foreach(input_file_path) do |file|
		file_path = input_file_path + "/" + file
		if File.file?(file_path)
			File.open(file_path, 'r') do |file_content|
				file_content.each do |line|
					tmp_array = line.split(" ")
					tmp_array.each do |word|
						if word.scan(/[^a-zA-Z]/).empty?
							$word_count += 1
							$word_hash_array.mapper(word)
						end
					end
				end
			end
		end
	end
	$word_hash_array.reducer
end

start_time = Time.now.to_i
perform_job
end_time = Time.now.to_i

total_time_spent = end_time - start_time

p "Total number of words: " + $word_count.to_s
p total_time_spent.to_s + " seconds"

$word_hash.write_to_file
