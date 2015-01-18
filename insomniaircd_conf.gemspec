require 'rake'

Gem::Specification.new do |s|
  s.name        = 'insomniaircd_conf'
  s.version     = '1.0.0'
  s.date        = '2015-01-17'
  s.summary     = "InsomniaIRC IRC Configs"
  s.description = "Config generation logic for Insnomnia IRC."
  s.authors     = ["Jesse Morgan"]
  s.email       = 'jesterpm@insomniairc.net'
  s.require_paths = ["lib"]
  s.files       = FileList['lib/*.rb'].to_a
  s.homepage    = 'https://github.com/insomniairc/insomniaircd_conf'
  s.license     = 'MIT'
end
