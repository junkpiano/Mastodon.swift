Pod::Spec.new do |spec|
  spec.name         = 'Mastodon.swift'
  spec.version      = '1.0.0'
  spec.license      = { :type => 'BSD' }
  spec.homepage     = 'https://github.com/junkpiano/Mastodon.swift'
  spec.authors      = { 'Yusuke Ohashi' => 'github@junkpiano.me' }
  spec.summary      = 'Mastodon Swift Client SDK'
  spec.source       = { :git => 'https://github.com/junkpiano/Mastodon.swift.git', :tag => spec.version.to_s }
  spec.source_files = 'Sources/**/*.swift'
  spec.dependency "Kiri", "~> 1.0.2"
  spec.ios.deployment_target  = '10.0'
end
