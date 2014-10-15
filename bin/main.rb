require 'logger'
require '../app/models/processor/processor_factory'
require '../app/models/renderer/renderer_factory'
require '../app/models/settings'

# Entry point into processor execution -- script only executed from command-line
module Main
  @log = Logger.new(STDOUT)

  # Validates the program arguments and calls the process method to generate the static HTML.
  def self.makeRocketGoNow
    validateArguments! ARGV

    # Initialise an XML processor and attach a HTML renderer, then process the batch
    processor = ProcessorFactory.new(:xml)
    processor.renderer = RendererFactory.new(:html)
    processor.process(ARGV[0], ARGV[1])
  end

  # Checks for correct run arguments -- otherwise reverts to application.yml defaults
  def self.validateArguments!(args)
    if args.nil? or args.length != 2
      @log.warn "Incorrect arguments found, using defaults. Should be (input path, export path), was: " + args.to_s
      args[0] = Settings.input_path
      args[1] = Settings.output_path
    end
  end
end

# With no default accessor (besides method_missing) let's execute the program
Main.makeRocketGoNow