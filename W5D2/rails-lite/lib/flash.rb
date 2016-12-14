require 'json'

class Flash
  attr_reader :now

  def initialize(req)
    cookie = req.cookies["_rails_lite_app_flash"]
    old_data = cookie.nil? ? {} : JSON.parse(cookie)
    @now = {}
    old_data.each { |k, v| @now[k.to_sym] = v }
    @data = {}
  end

  def [](key)
    @data[key.to_sym] || @now[key.to_sym]
  end

  def []=(key, value)
    @data[key.to_sym] = value
  end

  def store_flash(res)
    res.set_cookie(
      "_rails_lite_app_flash",
      { path: '/', value: @data.to_json }
    )
  end
end
