I18n::Cocoa
===========

Manage translation and localization with static analysis, for iOS, OSX

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

**Check health**
```ruby

attributes = {:localized_macro_string => 'LocalizedString', :search_path => 'iOSProject'}
success, failure_issues = I18n::Cocoa.health attributes

```

Features
----------

- [x] Ensure to not forget to add localized string literal with key in `.strings` files
- [x] Find to unused localizaed key in files and strip them from these files
- [ ] Comprehensive Unit Test Coverage

Contributing
----------

1. Fork it ( https://github.com/hirohisa/i18n-cocoa/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
