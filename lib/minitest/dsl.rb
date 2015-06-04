require 'set'
require 'minitest/spec'

module Minitest
  module Spec::DSL

    def let!(name, &block)
      let(name, &block)
      bangs << name
    end

    def all_bangs
      return Set.new if @before_ran
      bangs + bangs_from_parent_scope
    end

    private

    def bangs
      @bangs ||= Set.new
    end

    def before_with_bangs(_type=nil, &block)
      @before_ran = true

      before_bangs = Set.new(bangs + bangs_from_parent_scope)
      bangs.clear
      after_bangs = bangs

      block_with_bangs = ->(arg) do
        before_bangs.each(&method(:send))
        self.instance_exec(arg, &block)
        after_bangs.each(&method(:send))
      end

      before_without_bangs(_type, &block_with_bangs)
    end

    alias_method :before_without_bangs, :before
    alias_method :before, :before_with_bangs

    def bangs_from_parent_scope
      return Set.new unless defined? self.superclass.all_bangs
      self.superclass.all_bangs
    end
  end
end
