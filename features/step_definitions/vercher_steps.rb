require 'time'
require 'rspec/expectations'

Then(/^the file "([^"]*)" should be update$/) do |file_name|
    puts "file name: #{file_name}"
    with_file_content file_name do |line|#only one line in file
        version = line.slice(/(?<=v=).*$/)
        expect(version.nil?).to eq(false)
        version_time = Time.parse version
        version_time_early = Time.now - 60
        expect(version_time > version_time_early).to eq(true)
    end
end
# Add more step definitions here
