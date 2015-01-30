# encoding: utf-8

require "i18n/cocoa/version"
require "i18n/cocoa/utils"
require "i18n/cocoa/finder"

module I18n
  module Cocoa

    def self.health attributes = {}
      finder = Finder.new(config.update attributes)
      finder.ensure_localization

      unused_keys = finder.find_unused_localization
      finder.delete_localization_keys unless unused_keys.empty?
    end

    def self.config
      {
        :localized_macro_string => 'NSLocalizedString',
        :search_path            => '.'
      }
    end

  end
end
