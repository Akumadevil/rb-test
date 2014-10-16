# About

Simple homework exercise and one of my first forays into Ruby.
Supplied with an XML file containing photos from various camera makes and models, create a batch processor to generate a
static HTML file for each make and model -- plus an index page. Each static page contains relevant thumbnails plus
navigation. Batch processor should take the location of the input file and the output directory as parameters.

See it running in action at: https://dl.dropboxusercontent.com/u/27314354/rb2/index.htm

## Features

* Bundler with Gemfile for dependency management:
 * Nokogiri (requires XCode CLI which requires OSX 10.x)
 * Slim templating engine
 * Stringex string extensions for friendly URLs
 * Settingslogic for global constants
 * Minitest and Mocha for unit testing
* Logger for main class
* Processor and renderer factory pattern for extensible architecture (over-engineered but good experience) as opposed to
the more simplistic:
 * processor.open(in).writeIndex(out).writeMakes(out).writeModels(out)
* Extended Nokogiri classes to better support functional programming through method chaining
* Recursion used for rendering levels (makes > models)
* Arguments (input and output paths) configured in config/application.yml
* Version control on GitHub
* Unit test suite run from /test/test_suite.rb. 100% code coverage.
* Use of singleton methods, method readability (suffixes ! and ?) and functional programming techniques
* Full code comments and Rdoc documentation in the /doc directory

## Design Decisions

* Rails directory structure over Ruby because:
 * More familiar to developers
 * Easier to port
 * Designed with a web application background
 * The /data directory for input XML
 * The /out directory for generated HTML (currently wired to my Dropbox folder)
 * The /bin directory for command line execution
* No access modifiers in classes due to unit testing directly on methods
* No cleanup (i.e. deleting input file after picking up) for re-running purposes
* Many 'theoretical' improvements for a real system:
** Move to a web application (i.e. Rails)
** Multiple jobs running on different threads
** Leverage a queuing system (e.g. Amazon STS)
* No tests for main.rb as it resides outside the /app directory of the project
* Controller as a module to be called from main.rb (or a shell script)
* Minimalist template (not about my front-end design skills). External Javascript (my dropbox).

## Failed to...

* Getting a Rakefile to work instead of test_suite.rb (ran with no output)
* Encapsulate xml_processor_test.rb test data into a separate fixtures file (Rails only?)
* Mock the factory classes without unnecessary getter/setter for properties (otherwise no ability to mock)
* Path to input XML relative to the test_suite and breaks if run xml_processor_test.rb directly (can't set base path)
* Mixed Minitest and Mocha mocks depending on my needs (bad?)
* Enforce abstract inheritance (Java thinking not Ruby -- since you can add methods on the fly)
* Use ActiveSupport for tests outside of Rails
* Get Bundler to work for unit tests (not important)