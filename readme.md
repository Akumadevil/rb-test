# About

Simple homework exercise and one of my first forays into Ruby.

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
 * The /bin directory for command line execution

## Enhancements

* access levels (private, protected etc.)
* unit tests
* code comments
* No way to force processor/renderer to implement inherited methods?
* Namespacing with module wrappers
* move code to the app directory
* Rubydoc generation