require 'erb'
require 'byebug'

class ShowExceptions
  attr_reader :app

  def initialize(app)
    @app = app
  end

  def call(env)
    app.call(env)
  rescue => e
    render_exception(e)
    # ['500', {'Content-type' => 'text/html'}, [e.to_s]]
  end

  private

  def render_exception(e)
    @e = e
    first_trace = e.backtrace.first
    error_file = first_trace.match(/^(?<file_name>[^:]*):(?<line>\d+)/)
    @file_name = error_file[:file_name]
    line = error_file[:line].to_i

    @code = render_code_block(@file_name, line)
    res = Rack::Response.new
    res.status = 500
    res['Content-type'] = 'text/html'
    template = ERB.new(File.read("lib/template/rescue.html.erb"))
    template_result = template.result(binding)
    res.write(template_result)
    res.finish
  end

  def render_code_block(file_name, line_number)
    result = ""

    File.open(file_name, "r").each_with_index do |line, i|
      next unless i.between?(line_number - 5, line_number + 5)
      result << "#{i + 1}: #{line}\n"
    end

    result
  end

end
