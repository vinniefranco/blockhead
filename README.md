# Blockhead

[![Build Status](https://travis-ci.org/vinniefranco/blockhead.svg)](https://travis-ci.org/vinniefranco/blockhead.svg)
[![Code Climate](https://codeclimate.com/github/vinniefranco/blockhead.png)](https://codeclimate.com/github/vinniefranco/blockhead.png)
[![Gem Version](https://badge.fury.io/rb/blockhead.svg)](http://badge.fury.io/rb/blockhead)
Easy marshalling of object attributes.

## Installation

Add this line to your application's Gemfile:

    gem 'blockhead'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install blockhead

## Usage

Say you have the following object with some 1:1 and 1:M set of relational attributes:

```ruby

object = OpenStruct.new(
  title: 'Fancy pants',
  order_number: 'STORE-1234'
  items: [
    OpenStruct.new(name: 'ACD', sku: '1234', ...),
  ]
  customer: OpenStruct.new(name: 'Bill Murray', score: 10, ...)
)

```

And you want to send a different structure to your data warehouse in the format of:

```ruby

{
  name: 'Bill Murray',
  order: 'STORE-1234',
  items: [
    { name: 'ACD', sku: '1234' }
  ],
  customer: {
    score: 10
  }
}

```

To marshal you would just:

```ruby

schema = Blockhead::Schema.define object do
  name -> { object.customer.name } # Accepts procs with object in scope
  order_number as: :order # Aliases
  items do
    name # Simple definitions on collection attributes
    sku
  end
  customer do
    score
  end
end

schema.marshal #=> { name: 'Bill Murray', order: 'STORE-1234', items: [{ name: 'ACD', sku: '1234' }], customer: { score: 10 } }

```

## Contributing

1. Fork it ( https://github.com/vinniefranco/blockhead/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
