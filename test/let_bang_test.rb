require 'minitest/autorun'

module Minitest::Spec::DSL
  def bangs
    @bangs ||= []
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

describe Minitest::Spec, :let! do

  i_suck_and_my_tests_are_order_dependent!
  def _count
    $let_count ||= 0
  end

  let! :count do
    $let_count ||= 0
    $let_count += 1
    $let_count
  end

  it "is evaluated before it's called" do
    _count.must_equal 1
  end

  it "is evaluated once per example" do
    _count.must_equal 2

    count.must_equal 2
    count.must_equal 2

    _count.must_equal 2
  end

end
