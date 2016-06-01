require 'erb'
require 'securerandom'

require "mjml/version"
require "mjml/render"
require "mjml/config"

module Mjml
  def self.render(path, args, instance = nil)
    Render.new(path, args, instance).execute
  end

  def self.configure
    yield Config
  end
end
