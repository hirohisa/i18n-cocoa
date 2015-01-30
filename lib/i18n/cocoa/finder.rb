# encoding: utf-8

module I18n
  module Cocoa

    class Finder

      def initialize attributes
        config = default_config.update attributes
        @localized_macro_string = config[:localized_macro_string]
        @method_file_paths = []
        @localized_file_paths = []

        _search_file_paths File.absolute_path(config[:search_path])
      end

      def default_config
        {
          :localized_macro_string => 'NSLocalizedString',
          :search_path            => '.'
        }
      end

      def ensure_localization
        failure_issues = []

        # use variable key for localization
        lines = _find_lines_using_variable_key_in_method_files
        failure_issues << Utils.create_issue("found to set varible keys with logic", lines) if lines.count > 0

        # use localized key but key doesnt exist in strings file
        used_keys = _get_used_localized_keys_from_method_files
        localized_keys = _get_localized_keys_from_strings_files

        forgot_keys = _contain_keys_in_localized_keys used_keys, localized_keys
        failure_issues << Utils.create_issue("found to forget keys", forgot_keys) if forgot_keys.count > 0

        [failure_issues.count == 0, failure_issues]
      end

      def find_unused_localization
        # use localized key but key doesnt exist in strings file
        used_keys = _get_used_localized_keys_from_method_files
        localized_keys = _get_localized_keys_from_strings_files

        unused_keys = _contain_keys_in_localized_keys localized_keys, used_keys

        unused_keys
      end

      def delete_localization_keys keys
        for file_path in @localized_file_paths do
          _rewrite_strings_file file_path, keys
        end
      end

      private
      def _search_file_paths directory_path
        Dir::foreach(directory_path) do |f|
          current_file_path = "#{directory_path}/#{f}"

          _assort_with_extension current_file_path unless File.directory?current_file_path

          _search_file_paths current_file_path if _need_to_search_in_directory? current_file_path
        end
      end

      def _assort_with_extension file_path
        return if File.directory?file_path

        extension = file_path.split('.').last
        case extension
        when 'm', 'mm', 'swift'
          @method_file_paths << file_path
        when 'strings'
          directory_name = file_path.split('/').last(2).first # e.g. 'en.lproj'
          _extension = directory_name.split('.').last
          @localized_file_paths << file_path if _extension == 'lproj'
        end
      end

      def _need_to_search_in_directory? file_path
        return false unless File.directory? file_path

        file_name = file_path.split('/').last
        return false if file_name.start_with?"." # '.', '..', '.git'

        extension = file_name.split('.').last
        xcode_extensions = ['xcodeproj', 'xcassets', 'xcworkspace']
        return false if xcode_extensions.include?extension # directory for xcode

        library_directories = ['Pods', 'Carthage']
        return false if library_directories.include?file_name # support Pods, Carthage

        true
      end

      def _find_lines_using_variable_key_in_method_files
        lines = []

        @method_file_paths.each do |file_path|
          f = File.new(file_path, "r")
          f.readlines.each do |l|
            line = Utils.encode l

            m = /#{@localized_macro_string}\([^@\"]+\)/.match(line)
            next if m.nil?

            lines << line.strip
          end
        end

        lines
      end

      def _get_used_localized_keys_from_method_files
        keys = []

        @method_file_paths.each do |file_path|
          f = File.new(file_path, "r")
          f.readlines.each do |l|
            l = Utils.encode l
            next if l.strip.empty?

            found_keys = _find_localized_macro_from_line l.strip
            found_keys.each {|k| keys << k } unless found_keys.empty?
          end
        end

        keys.uniq
      end

      def _find_localized_macro_from_line line
        pattern = @localized_macro_string + '\(@"([^"]*)"[^\)]*\)'
        result = line.scan /#{pattern}/

        return result.flatten unless result.empty?

        []
      end

      def _get_localized_keys_from_strings_files
        keys = []

        @localized_file_paths.each do |file_path|
          f = File.new(file_path, "r")
          f.readlines.each do |l|
            l = Utils.encode l
            next if l.start_with?("//")

            m = /^"([^"]+)"[ ]*=[ ]*"([^"]+)";[\r\n]*$/.match(l)
            next if m.nil?

            keys << m[1] if m.size == 3
          end
        end

        keys
      end

      def _contain_keys_in_localized_keys used_keys, localized_keys
        diff = used_keys - localized_keys

        diff
      end

      def _rewrite_strings_file file_path, exclude_keys
        temp_path = './tmp'
        temp_file = File.new(temp_path, "w")

        f = File.new(file_path, "r")
        f.readlines.each do |l|
          needs_copy = true

          match = /^"([^"]+)"[ ]*=[ ]*"([^"]+)";[\r\n]*$/.match(l)
          if !match.nil? && match.size == 3
            needs_copy = false if exclude_keys.include?match[1]
          end

          temp_file.puts l if needs_copy
        end
        f.close
        temp_file.close

        FileUtils.move temp_path, file_path
      end

    end
  end
end
