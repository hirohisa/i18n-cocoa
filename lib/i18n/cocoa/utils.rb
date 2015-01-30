module I18n
  module Cocoa

    module Utils

      def self.encode string
        # invalid byte sequence in US-ASCII (ArgumentError)
        string.force_encoding('UTF-8')
        string.encode("UTF-8", "UTF-8")
      end

      def self.create_issue title, description
        "#{title}: #{description}"
      end
    end
  end
end
