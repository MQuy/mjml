require 'erb'
require 'tilt'
require 'securerandom'

require "mjml/version"
require "mjml/mailer"
require "mjml/scope"
require "mjml/render"
require "mjml/config"

module Mjml
  def self.render(path, args = {}, instance = nil, &block)
    scope = Scope.new(instance, args)
    Render.new(path, scope, block).execute
  end

  def self.template(template_mjml)
    mjml_path = "#{Dir.pwd}/tmp/template-#{SecureRandom.uuid}.mjml"
    File.write(mjml_path, template_mjml)
    render(mjml_path)
  end

  def self.configure
    yield Config
  end
end
