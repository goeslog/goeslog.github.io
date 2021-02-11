Gem::Specification.new do |spec|
	spec.name          = "goesThink"
	spec.version       = "2.5.0"
	spec.authors       = ["Wonseog Choi"]
	spec.email         = ["goesnow831@gmail.com"]

	spec.summary       = "A minimalist Jekyll theme"
	spec.homepage      = "https://github.com/1seok2"
	spec.license       = "MIT"

	spec.metadata["plugin_type"] = "theme"

	spec.files         = `git ls-files -z`.split("\x0").select { |f| f.match(%r!^(assets|_layouts|_includes|_sass|(LICENSE|README)((\.(txt|md|markdown)|$)))!i) }

	spec.add_runtime_dependency "jekyll", "~> 4.0.0"

	#spec.add_development_dependency "bundler", "~> 2.0.1"
	spec.add_development_dependency "rake", "~> 12.0"
end

