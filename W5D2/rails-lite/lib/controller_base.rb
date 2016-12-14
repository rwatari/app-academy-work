require 'active_support'
require 'active_support/core_ext'
require 'active_support/inflector'
require 'erb'
require_relative './session'
require_relative './flash'

class ControllerBase
  attr_reader :req, :res, :params

  # Setup the controller
  def initialize(req, res, route_params = {})
    @req, @res = req, res
    @params = req.params.merge(route_params)
  end

  # Helper method to alias @already_built_response
  def already_built_response?
    !!@already_built_response
  end

  # Set the response status code and header
  def redirect_to(url)
    raise "Double render" if already_built_response?
    res['Location'] = url
    res.status = 302
    @already_built_response = true

    session.store_session(res)
    flash.store_flash(res)
  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)
    raise "Double render" if already_built_response?
    res['Content-Type'] = content_type
    res.write(content)
    @already_built_response = true

    session.store_session(res)
    flash.store_flash(res)
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
    model_name = self.class.name.underscore
    template_path = "views/#{model_name}/#{template_name}.html.erb"
    template = ERB.new(File.read(template_path))
    template_result = template.result(binding)
    render_content(template_result, 'text/html')
  end

  # method exposing a `Session` object
  def session
    @session ||= Session.new(req)
  end

  def flash
    @flash ||= Flash.new(req)
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
    self.send(name)
    unless already_built_response?
      render(name)
    end
  end
end
