require 'logger'
require '../app/models/processor/processor_factory'
require '../app/models/renderer/renderer_factory'
require '../app/models/settings'

# Entry point into processor execution -- shell only. Can be easily called from a web application or scheduler
# if required.
module Main
  @log = Logger.new(STDOUT)

  # Validates the program arguments and calls the process method to generate the static HTML.
  def self.makeRocketGoNow
    if validateArguments ARGV

      processor = ProcessorFactory.new(:xml)
      processor.renderer = RendererFactory.new(:html)
      processor.process

      #XmlToStaticHtmlProcessor.process ARGV[0], ARGV[1]
    else
      @log.warn "Please specify two arguments:" +
                    "\n1. The location of the input XML" +
                    "\n2. Static HTML output directory"
    end
  end

  # Returns TRUE if there are two arguments passed in.
  def self.validateArguments(args)
    if args.nil? or args.length != 2
      false
    end

    true
  end
end

# With no default accessor (besides method_missing) let's execute the program
Main.makeRocketGoNow