require 'set'
require 'minitest/spec'

module Minitest
  module Spec::DSL
    def before_bangs
      @before_bangs ||= Set.new
    end
    def after_bangs
      @after_bangs ||= Set.new
    end
    def before_ran
      @before_ran
    end

    def let!(name, &block)
      let(name, &block)
      if @before_ran
        after_bangs << name
      else
        before_bangs << name
      end
    end

    def before_with_bangs(_type=nil, &block)
      @before_ran = true
      b0 = before_bangs
      b1 = after_bangs
      block_with_bangs = ->(x) do
        b0.each do |bang|
          send(bang)
        end
        self.instance_eval(&block)
        b1.each do |bang|
          send(bang)
        end
      end
      before_without_bangs(_type, &block_with_bangs)
    end

    alias_method :before_without_bangs, :before
    alias_method :before, :before_with_bangs

    def bangs
      before_bangs + after_bangs + bangs_from_parent_scope
    end

    def bangs_from_parent_scope
      return Set.new unless defined? self.superclass.bangs
      self.superclass.bangs
    end

  end
end
