class Static
  attr_reader :app

  def initialize(app)
    @app = app
  end

  def call(env)
    req = Rack::Request.new(env)
    if /^\/public*/ =~ req.path
      file_ext = req.path.match(/\.(.*)/)[1]
      res = Rack::Response.new
      res.status = 300
      res['Content-type'] = "image/#{file_ext}"
      res.write(File.read(req.path[1..-1]))
      res.finish
    else
      app.call(env)
    end

  rescue
    res.status = 404
    res.finish
  end
end
