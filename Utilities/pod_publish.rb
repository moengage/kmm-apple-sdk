#!/usr/bin/ruby

# Usage:
# Publish pods to CocoaPods

require 'fileutils'
require 'json'
require 'ostruct'

config = JSON.parse(File.read('package.json'), {object_class: OpenStruct})
derived_data = File.expand_path('~/Library/Developer/Xcode/DerivedData')
Dir.glob('*.podspec').each do |podspec_file|
  begin
    FileUtils.rm_rf(derived_data) if File.directory?(derived_data)
    system("pod trunk push \"#{podspec_file}\" --verbose --synchronous --allow-warnings --skip-import-validation", out: STDOUT, exception: true)
    sleep 1 # even with --synchronous flag push might fail for depending pods
  rescue => error
    puts "::warning::Pod published failed with #{error&.message}"
  end
end
