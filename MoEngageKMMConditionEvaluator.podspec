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
  package_index = config.packages.find_index { |package| package.name == podspec }
  package = config.packages[package_index]

  s.name         = podspec
  s.version      = package.version
  s.summary      =  "#{s.name} for iOS"
  s.description  = <<-DESC
                      #{s.name} contains conditional evaluator code in Kotlin Multi-platform format.
                    DESC
  s.homepage          = 'https://www.moengage.com'
  s.documentation_url = 'https://developers.moengage.com'
  s.license           = { :type => 'Commercial', :text => File.read('LICENSE') }
  s.author            = { 'MobileDev' => 'mobiledevs@moengage.com' }
  s.social_media_url  = 'https://twitter.com/moengage'

  s.source       = { :http => package.url, :sha256 => package[:hash] }

  s.ios.deployment_target = '12.0'
  s.tvos.deployment_target = '12.0'
  s.swift_versions = '5.0'
  s.requires_arc = true
  s.vendored_frameworks = "#{s.name}.xcframework"
  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=*simulator*]' => '$(inherited) x86_64' }

  unsupported_arch_doc_url = 'https://developers.moengage.com/hc/en-us/articles/43255588673684-Configuring-Project-for-Architecture-Compatibility#h_01K9VWV2EDFWNSHQK02R7CP7WT'
  headers_script = <<-SCRIPT
if [[ "$EFFECTIVE_PLATFORM_NAME" == *"simulator"* && "$ARCHS" != *"arm64"* ]]; then
  echo "Unsupported architecture ${ARCHS} for simulator, see: #{unsupported_arch_doc_url}"
  exit 1
fi
SCRIPT
  s.script_phase = {
    :name => 'Architecture Verification',
    :script => headers_script,
    :execution_position => :after_headers,
    :always_out_of_date => '1'
  }
end
