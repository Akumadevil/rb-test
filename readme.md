# About

Simple homework exercise and one of my first forays into Ruby.

## Brief

Supplied with an XML file containing photos from various camera makes and models, create a batch processor to generate a
static HTML file for each make and model -- plus an index page. Each static page contains relevant thumbnails plus
navigation. Batch processor should take the location of the input file and the output directory as parameters.

## Features

* Dependencies
 * Logger
 * Nokogiri (requires XCode CLI which requires OSX 10.x)
 * Slim templating engine
 * Stringex string extensions for friendly URLs
 * Settingslogic for global constants
* Processor and renderer factory pattern for extensible architecture
* Extended Nokogiri classes to better support functional programming through method chaining
* Recursion used for rendering levels (makes > models)
* Arguments (input and output paths) configured in config/application.yml
* Version control on GitHub

## Design Decisions

* Rails directory structure over Ruby because
 * More familiar to developers
 * Easier to port
 * Designed with a web application background
 * The /data directory for input XML
 * The /out directory for generated HTML (currently wired to my Dropbox folder)
 * The /bin directory for command line execution

## To Do

* Access levels (private, protected etc.)
* Unit tests > test "the truth"
* Code comments
* No way to force processor/renderer to implement inherited methods?
* Namespacing with module wrappers
* Rubydoc generation
* Cleanup HTML (possible reverse-engineer slim template?)
* Main.rb take arguments and fallback to settings
* Gemfile for dependencies