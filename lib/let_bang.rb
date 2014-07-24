require 'set'

module Minitest::Spec::DSL
  def bangs
    @bangs ||= Set.new
  end

  def let!(name, &block)
    let(name, &block)
    bangs << name
  end
end

module LetBang
  def setup
    self.class.bangs.each do |bang|
      send(bang)
    end
  end
end

class MiniTest::Test
  include LetBang
end

