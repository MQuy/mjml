# Mjml

Allow use https://mjml.io/ in rails

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mjml'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mjml

## Usage

#### Configuration

```ruby
Mjml.configure do |config|
  config.exec_path = `which mjml`
end
```

You have to install mjml compiler via `npm install mjml` to use this gem

The `exec_path` will be set default as `node_modules/mjml/bin/mjml`. If you use heroku you can config [multiple buildpacks](https://devcenter.heroku.com/articles/using-multiple-buildpacks-for-an-app) to make it support nodejs

#### Mjmj#render

`Mjml.render(template_path, template_variable, binding)`: this render method accept three parameters
+ template_path: the location of your template
+ template_variable: these variables which be passed to template so that you can use something like this `<div><%= name %></div>`
+ binding: you can get something like mailer binding to support rails path helper

#### Mailer

You can use in mailer

```ruby
body = Mjml.render("#{Dir.pwd}/app/views/template", { name: 'Mjml parser' }) # => template.mjml
mail(to: xxx, subject: xxx, body: body, content_type: 'text/html')
```

and `template.mjml`
```html
<mjml>
  <mj-body>
    <mj-container>
      <mj-section>
        <mj-column>
          <mj-image width="100" src="https://mjml.io/assets/img/logo-small.png"></mj-image>
          <mj-divider border-color="#F45E43"></mj-divider>
          <mj-text font-size="20px" color="#F45E43" font-family="helvetica">Hello <%= name %></mj-text>
        </mj-column>
      </mj-section>
    </mj-container>
  </mj-body>
</mjml>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/MQuy/mjml. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.
