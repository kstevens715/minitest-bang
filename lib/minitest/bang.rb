require 'minitest/spec'
require_relative 'dsl'

module Minitest
  module Bang
    def before_setup
      super
      self.class.bangs_from_parent_scope.each(&method(:send))
    end

    def after_setup
      super
      self.class.bangs.each(&method(:send))
    end
  end

  if defined?(Unit::TestCase)
    class Unit::TestCase
      include Bang
    end
  end

  if defined?(Test)
    class Test
      include Bang
    end
  end
end
