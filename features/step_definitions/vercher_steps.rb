require 'time'
require 'rspec/expectations'

Then(/^the file "([^"]*)" should be update$/) do |file_name|
    puts "file name: #{file_name}"
    with_file_content file_name do |line|#only one line in file
        puts "line: #{line}"
        version = line.slice(/(?<=v=).*$/)
        puts "version info: #{version}"
        expect(version.nil?).to eq(false)
        version_time = Time.parse version
        puts "version to_s: #{version_time}"
        version_time_early = Time.now - 60
        puts "version_early to_s: #{version_time_early}"
        expect(version_time > version_time_early).to eq(true)
    end
end
# Add more step definitions here
