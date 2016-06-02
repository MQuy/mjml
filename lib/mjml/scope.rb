module Mjml
  class Scope < SimpleDelegator

    def initialize(target, args)
      super(target)

      args.each do |key, value|
        define_singleton_method key, lambda { value }
      end
    end
  end
end
