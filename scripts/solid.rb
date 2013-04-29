#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
Bundler.require if File.exists?('Gemfile')

require 'oj'
require 'sprockets'
require 'coffee_script'
require 'listen'
require 'stylus/sprockets'

require Pathname('.') + 'scripts/commonjs.rb'

root = Pathname('.').expand_path
env = Sprockets::Environment.new(root)
Stylus.setup(env)
env.register_postprocessor 'application/javascript', Sprockets::CommonJS

env.append_path(root)

def build env
  puts "- #{Time.now}"
  puts "Start building"
  t1 = Time.now
  begin
    js = env.find_asset('./solid/app.coffee')
    js.write_to('./public/app.js')
    css = env.find_asset('./solid/app.styl')
    css.write_to('./public/app.css')
    puts "Building complete - #{((Time.now - t1) * 1000).round.to_f / 1000}s"
  rescue Exception => e
    puts e.message
  end
  puts "\n"
end

build(env)

paths = []
[ "app", "solid" ].each do |path|
  paths << (root.to_s+"/"+path)
end
Listen.to(*paths) {
  build(env)
}