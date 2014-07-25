require 'set'
require 'minitest/spec'

module Minitest::Spec::DSL
  def bangs
    @bangs ||= Set.new
    @bangs = @bangs + bangs_from_parent_scope
  end

  def let!(name, &block)
    let(name, &block)
    bangs << name
  end

  private

  def bangs_from_parent_scope
    return Set.new unless defined? self.superclass.bangs
    self.superclass.bangs
  end
end

module Bang
  def before_setup
    super
    self.class.bangs.each do |bang|
      send(bang)
    end
  end
end

if defined?(MiniTest::Test)
  class MiniTest::Test
    include Bang
  end
end
if defined?(MiniTest::Unit::TestCase)
  class MiniTest::Unit::TestCase
    include Bang
  end
end
