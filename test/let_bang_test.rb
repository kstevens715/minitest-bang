require 'minitest/autorun'
require_relative '../lib/let_bang'

describe Minitest::Spec, :let! do

  i_suck_and_my_tests_are_order_dependent!

  def _count
    $let_count ||= 0
  end

  let!(:count) do
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

  let!(:dependent) { dependency + 1 }
  let!(:dependency) { 2 }

  it "resolves dependencies regardless of order" do
    dependent.must_equal 3
  end

  describe 'multiple definitions' do
    let!(:last) { $last ||= 0; $last += 1 }
    let!(:last) { $last ||= 0; $last += 4 }

    it "only uses last definition" do
      $last.must_equal 4
      last.must_equal 4
    end
  end
end
