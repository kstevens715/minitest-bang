require "coveralls"
Coveralls.wear!

require "minitest/autorun"
require_relative "../lib/minitest/bang"

describe Minitest::Spec, :let! do

  describe "basic case" do

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
  end

  describe "let! is evaluated before before blocks" do
    let!(:available) { @available = true }

    before do
      @available.must_equal true
    end
  end

  describe "multiple definitions" do
    let!(:last) { @last ||= 0; @last += 1 }
    let!(:last) { @last ||= 0; @last += 4 }

    it "only uses last definition" do
      @last.must_equal 4
      last.must_equal 4
    end

    describe "nested blocks" do
      let!(:last) { @last ||= 0; @last += 99 }
      it "overrides top level let!" do
        @last.must_equal 99
      end
    end
  end

  describe "multiple (mixed) definitions" do
    let!(:mixed) { "with bang" }
    let(:mixed) { 'without bang' }

    it "can be overridden by non-bang lets" do
      mixed.must_equal "without bang"
    end
  end

  describe "nested describes" do
    let!(:higher_level) { @higher_level = true }

    describe "nested" do
      it "gets higher level lets!" do
        @higher_level.must_equal true
      end
      describe "even deeper" do
        it "gets higher level lets!" do
          @higher_level.must_equal true
        end
      end
    end
  end

  describe "nested describes with before blocks" do
    let!(:top_let) { append_symbol(:top_let) }

    before do
      append_symbol(:top_before)
    end

    specify { @order.must_equal [:top_let, :top_before] }

    describe "nested" do
      let!(:nested_let) { append_symbol(:nested_let) }

      before do
        append_symbol(:nested_before)
      end

      specify { @order.must_equal [:top_let, :top_before, :nested_let, :nested_before] }
    end
  end

  describe "before then let" do
    before do
      append_symbol(:before)
    end

    let!(:let) { append_symbol(:let) }

    specify { @order.must_equal [:before, :let] }
  end

  describe "let then before" do
    let!(:let) { append_symbol(:let) }

    before do
      append_symbol(:before)
    end

    specify { @order.must_equal [:let, :before] }
  end

  describe "lots of random let and before blocks" do
    let!(:let1) { append_symbol(:let1) }
    let!(:let2) { append_symbol(:let2) }

    before do
      append_symbol(:before1)
    end

    let!(:let3) { append_symbol(:let3) }

    describe "inner" do
      let!(:let4) { append_symbol(:let4) }

      before do
        append_symbol(:before2)
      end

      let!(:let5) { append_symbol(:let5) }

      specify { @order.must_equal [:let1, :let2, :before1, :let3, :let4, :before2, :let5] }
    end
  end

  describe 'before block with let in nested block' do
    before do
      append_symbol(:before)
    end

    describe 'inner 2' do
      let!(:let) { append_symbol(:let) }

      specify { @order.must_equal [:before, :let] }
    end
  end

  describe 'outer' do
    let!(:let) { append_symbol(:let) }

    describe 'inner1' do

      before { append_symbol(:before) }

      describe 'inner2' do
        specify { @order.must_equal [:let, :before] }
      end
    end
  end

  def append_symbol(symbol)
    @order ||= []
    @order << symbol
  end
end
