# Combine

Harvest the web while separating the grain from the chaff.

## Installation

Add this line to your application's Gemfile:

    gem 'combine'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install combine

## Usage
Goals:
+ Flexible
+ Composable
+ Stable (Fault Tolerant)
+ Fast

### Harvest Pattern
```ruby
{
  "index_page"=>{
    "wrapper"=>"div.Item.Right",
    "next_page_link"=>"div.next_page.test-selector",
    "fields"=>{
      "title"=>"h3.Data-Headline > a",
      "datetime"=>{
        "selector"=>"div.Data > p.Data-Date",
        "post"=>{
          "text"=>"text.gsub('–', ' until ').gsub(', 2013', '')"
        }
      }
    },
    "sub_pages"=>{
      "detail_page"=>{
        "uri_selector"=>"h3.Data-Headline > a",
        "wrapper"=>"div#Columns > div",
        "fields"=>{
          "description"=>"p"
        }
      },
      "location_page"=>{
        "uri_selector"=>"h3.Location-Headline > a",
        "wrapper"=>"div#location > div",
        "fields"=>{
          "location"=>"p"
          "datetime"=>[]
        }
      }
    }
  }
}
```


+ page title
    + uri
    + wrapper
    + next_page_link
    + fields
        + name
        + datetime
            + selector (can be a single selector, an array of selectors, or a hash of selectors )
            + nodes
            + html
            + text
    + sub_pages
        + page title
            + uri
            + ...
        + page title
            + uri
            + ...

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
