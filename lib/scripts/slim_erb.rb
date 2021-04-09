require "slim/erb_converter"
require 'logger'

open(Rails.root.join("tmp/compiled.html.erb"), "a+") do |compiled|
  Dir.glob(Rails.root.join("app/views/**/*.html.slim")).each do |slim_template|
    open slim_template do |f|
      slim_code = f.read
      erb_code = Slim::ERBConverter.new.call(slim_code)
      compiled.puts erb_code
      logger = Logger.new(STDOUT)
      logger.info("slim files are converted to erb files to indentfy html class")
    end
  end
end
