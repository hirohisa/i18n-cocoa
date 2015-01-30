# encoding: utf-8

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'i18n/cocoa'

puts I18n::Cocoa::VERSION
puts I18n::Cocoa.health
