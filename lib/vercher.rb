require 'vercher/version.rb'

# Add requires for other files you add to your project here, so
# you just need to require this one file in your bin file

require 'find'
require 'tempfile'
require 'logger'
require 'time'
require 'uri'

$logger = Logger.new STDOUT

class Versioner
    def self.refresh ver#...?v=....
        $logger.info('target file src: ' + ver)
        latest = Time.now.iso8601#TODO: a better time stamp
        if ver.index '?v='
            ver.sub!(/(?<=\?v=).*/, latest)
        else
            ver += '?v=' + latest.to_s
        end
        $logger.info('refresh result: ' + ver)
        ver
    end
end

class Differ   
    # files with query string
    def self.compare file1, file2
        $logger.info('comparing ' + file1 + ' and ' + file2)
        if file2.nil? or file1.nil?
            return false    
        end
        f1 = file1
        if file1.index('/')
            if file1.index('v=')
                css_or_js = /(?<=\/)[^\/]*(?=\?)/
                f1 = file1.slice(css_or_js)
                $logger.info('file1 has version')
            else
                css_or_js = /(?<=\/)[^\/]*$/
                    f1 = file1.slice(css_or_js) 
                if f1.nil?
                    f1=''
                end
                $logger.info('file1 has no version')
            end
        else
            if file1.index('v=')
                css_or_js = /[^\/]*(?=\?)/
                f1 = file1.slice(css_or_js)
                $logger.info('file1 has version')
            else
                css_or_js = /[^\/]*$/
                    f1 = file1.slice(css_or_js) 
                if f1.nil?
                    f1=''
                end
                $logger.info('file1 has no version')
            end
        end
        p 'what f1 is: ' + f1
        $logger.info('file2 compared: ' + file2)
        f1 == file2
    end
end

class Walker

    def self.walk
        Find.find('./') do |path|
            if File.basename(path) =~ /(\.html$)|(\.vm$)/
                #puts path
                yield path
            end
        end
    end  

end


def main filename
=begin
    $logger.info 'argv length: ' + String(ARGV.length)
    if ARGV.length == 0
        $logger.fatal('no file name')
        puts 'input file name please'  
        exit
=end
    if false#for gli use
    else
        Walker.walk do |path|
            f_tmp = Tempfile.new('.tmp_for_version');
            f = File.open path, 'r+'
            $logger.info("current file path: #{path}")
            f.readlines.each do |l|
                if l =~ /src|href/ and l =~ /<script|<link/
                    l  = l.gsub(/((?:src|href)\s*=\s*")([^"]*)(")/) do |m|
                    $logger.info('target line detail: ' + l)
                    $logger.info('target file src: ' + $2)
                    $logger.info('user file name: ' + $2)
                    if Differ.compare $2, filename
                        $1 + Versioner.refresh($2) + $3
                    else
                        $1 + $2 + $3 
                    end
                    end
                end
                f_tmp << l;
            end
            f_tmp.rewind#reset postion to begin of a file
            f.rewind
            f << f_tmp.read
        end
    end
    $logger.info('main method completed')
end
