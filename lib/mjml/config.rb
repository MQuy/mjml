module Mjml
  module Config

    mattr_accessor :exec_path
    @@exec_path = "#{Dir.pwd}/node_modules/mjml/bin/mjml"
  end
end
