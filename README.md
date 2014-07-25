minitest-bang
=============

Provides the let! method to minitest spec, similar to the RSpec method of the same name.

## Install

```shell
gem install minitest-bang
```
or add the following line to Gemfile:

```ruby
gem 'minitest-bang', require: false
```
and run `bundle install` from your shell.

Then in your test helper, after requiring minitest/autorun:

```ruby
require 'minitest/bang'
```

## Supported Minitest versions
Currently, minitest-bang supports minitest 4.7.5 through 5.4.0

## Usage

You use it just like you would `let`, except the ones you define with `let!` get called automatically right before your before block gets executed:

```ruby
  describe User do
    let!(:user1) { create :user }

    before do
      User.count.must_equal 1
    end

    it "has one user without referencing user1" do
      User.count.must_equal 1
    end
  end
```
