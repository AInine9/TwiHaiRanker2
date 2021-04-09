require "slim/erb_converter"

open(Rails.root.join("tmp/compiled.html.erb"), "a+") do |compiled|
  Dir.glob(Rails.root.join("app/views/**/*.html.slim")).each do |slim_template|
    open slim_template do |f|
      slim_code = f.read
      erb_code = Slim::ERBConverter.new.call(slim_code)
      compiled.puts erb_code
    end
  end
end
