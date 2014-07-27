require 'set'
require 'minitest/spec'

module Minitest
  module Spec::DSL
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
end
