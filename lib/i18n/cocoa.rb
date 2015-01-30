# encoding: utf-8

require "i18n/cocoa/version"
require "i18n/cocoa/utils"
require "i18n/cocoa/finder"

module I18n
  module Cocoa

    def self.health localized_macro_string='NSLocalizedString'
      finder = Finder.new localized_macro_string
      finder.ensure_localization
    end

  end
end
