require 'sprockets'
require 'tilt'

module Sprockets
  class CommonJS < Tilt::Template

    WRAPPER = '%s.define({"%s":' +
              'function(exports, require, module){' +
              '%s' +
              ";}});\n"

    class << self
      attr_accessor :default_namespace
    end

    self.default_mime_type = 'application/javascript'
    self.default_namespace = 'this.require'

    protected

    def prepare
      @namespace = self.class.default_namespace
    end

    def evaluate(scope, locals, &block)
      puts scope.logical_path.to_s
      if commonjs_module?(scope)
        scope.require_asset 'scripts/sprockets/commonjs'
        WRAPPER % [ namespace, commonjs_module_name(scope), data ]
      else
        data
      end
    end

    private

    attr_reader :namespace

    def commonjs_module?(scope)
      basename = scope.pathname.basename.to_s
      basename != "app.coffee" && basename != "commonjs.js"
    end

    def commonjs_module_name(scope)
      parts = scope.logical_path.split("/")
      filename = parts[parts.length - 1]
      filename.gsub("\.coffee","")
    end

  end
end