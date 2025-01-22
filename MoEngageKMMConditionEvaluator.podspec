require 'fileutils'
require 'json'
require 'ostruct'

Pod::Spec.new do |s|
    podspec_path = caller.find do |trace|
      File.extname(trace.split(":")[0]).eql?('.podspec')
    end.split(":")[0]
    podspec = File.basename(podspec_path, File.extname(podspec_path))
    package_file = 'package.json'
    config = JSON.parse(File.read(package_file), {object_class: OpenStruct})

    s.name         = podspec
    s.version      = config.version
    s.summary      =  "#{s.name} for iOS"
    s.description  = <<-DESC
                       #{s.name} contains conditional evaluator code in Kotlin Multi-platform format.
                     DESC
    s.homepage          = 'https://www.moengage.com'
    s.documentation_url = 'https://developers.moengage.com'
    s.license           = { :type => 'Commercial', :text => File.read('LICENSE') }
    s.author            = { 'MobileDev' => 'mobiledevs@moengage.com' }
    s.social_media_url  = 'https://twitter.com/moengage'

    s.source       = {
      :http => "https://github.com/moengage/kmm-apple-sdk/releases/download/#{s.version}/#{s.name}.xcframework.zip",
      :sha256 => config[:hash]
    }

    s.ios.deployment_target = '12.0'
    s.tvos.deployment_target = '12.0'
    s.swift_versions = '5.0'
    s.requires_arc = true
    s.vendored_frameworks = "#{s.name}.xcframework"
  end