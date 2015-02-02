i18n::Cocoa [![Gem-version](https://img.shields.io/gem/v/i18n-cocoa.svg)](https://rubygems.org/gems/i18n-cocoa) [![Gem-downloads](https://img.shields.io/gem/dt/i18n-cocoa.svg)](https://rubygems.org/gems/i18n-cocoa) [![LICENSE](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/hirohisa/i18n-cocoa/blob/master/LICENSE)
===========

i18n-cocoa manages translation and localization with analysis, for iOS, OSX.
It helps you find to missing and unused localized strings in file.

Support languages
----------

Objective-C, Objective-C++, Swift

Installation
----------

Add this line to your application's Gemfile:

```ruby
gem 'i18n-cocoa'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install i18n-cocoa

Usage
----------

### Check health

`I18n::Cocoa.health` checks if any keys are missing or not used:
```ruby
require 'i18n/cocoa'

success, failure_issues = I18n::Cocoa.health
```

**Custom macro and specify directory**
```ruby
require 'i18n/cocoa'

attributes = {:localized_macro_string => 'LocalizedString', :search_path => 'iOSProject'}
success, failure_issues = I18n::Cocoa.health attributes
```

### Remove unused keys

`I18n::Cocoa.remove_unused` remove unused keys from `.strings` file if any keys are not used:
```ruby
require 'i18n/cocoa'

success, failure_issues = I18n::Cocoa.remove_unused
```


Features
----------

- [x] Ensure to not forget to add localized string literal with key in `.strings` files
- [x] Find to unused localized keys in files and strip them from these files
- [x] Documentation
- [ ] Find unused localized keys in files per language
- [ ] Comprehensive Unit Test Coverage

Contributing
----------

1. Fork it ( https://github.com/hirohisa/i18n-cocoa/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
