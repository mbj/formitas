# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.name        = 'formitas'
  gem.version     = '0.0.1'
  gem.authors     = [ 'Markus Schirp', 'Firas Zaidan' ]
  gem.email       = [ 'mbj@seonic.net', 'firas.zaidan@seonic.net' ]
  gem.description = 'HTML form generation and input validation library.'
  gem.summary     = gem.description
  gem.homepage    = 'https://github.com/mbj/formitas'

  gem.require_paths    = [ 'lib' ]
  gem.files            = `git ls-files`.split("\n")
  gem.test_files       = `git ls-files -- spec`.split("\n")
  gem.extra_rdoc_files = %w[TODO]
  
  gem.add_runtime_dependency('adamantium',    '~> 0.0.6')
  gem.add_runtime_dependency('anima',         '~> 0.0.5')
  gem.add_runtime_dependency('abstract_type', '~> 0.0.4')
  gem.add_runtime_dependency('aequitas',      '~> 0.0.3')
  gem.add_runtime_dependency('equalizer',     '~> 0.0.4')
  gem.add_runtime_dependency('i18n',          '~> 0.6.1')
  gem.add_runtime_dependency('rack',          '~> 1.4.1')
  gem.add_runtime_dependency('html',          '~> 0.0.1')
  gem.add_runtime_dependency('inflecto',      '~> 0.0.2')
end
