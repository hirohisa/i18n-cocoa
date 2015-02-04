# encoding: utf-8

require "i18n/cocoa/version"
require "i18n/cocoa/utils"
require "i18n/cocoa/finder"

module I18n
  module Cocoa

    # validate localization and strip unused keys
    #
    # @param [hash]     attributes if you want to change from default attributes
    # default attributes
    #   localized_macro_string: 'NSLocalizedString',
    #   search_path:            '.'
    #
    # @return [bool]    true when finish to run with success
    def self.health attributes = {}
      finder = Finder.new(attributes)
      result, issues = finder.ensure_localization
      return false unless result

      unused_keys = finder.find_unused_localization
      finder.delete_localization_keys unless unused_keys.empty?

      true
    end

    # find unused keys from localized strings files
    #
    # @param [hash]     attributes if you want to change from default attributes
    # @return [array]    unused keys that are not include code in project, exist in localized strings file
    def self.unused attributes = {}
      finder = Finder.new(attributes)
      unused_keys = finder.find_unused_localization

      unused_keys
    end

    # find unused keys and strip them  from localized strings files
    #
    # @param [hash]     attributes if you want to change from default attributes
    # @return [bool]    true when finish to run with success
    def self.remove_unused attributes = {}
      finder = Finder.new(attributes)
      unused_keys = finder.find_unused_localization
      finder.delete_localization_keys unless unused_keys.empty?

      true
    end

  end
end
