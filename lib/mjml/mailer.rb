module Mjml
  module Mailer
    def mail(headers, &block)
      scope = Mjml::Scope.new(self, headers[:template_variables])
      content = _layout ? mjml_layout_content(headers, scope) : mjml_template_content(headers, scope)

      headers[:body] = Mjml.template(content)
      headers[:content_type] = "text/html"

      super(headers, &block)
    end

    def mjml_layout_content(headers, scope)
      erb_layout = Tilt::ERBTemplate.new("#{Dir.pwd}/app/views/layouts/#{_layout}.mjml")
      erb_template = Tilt::ERBTemplate.new("#{headers[:template_path]}/#{headers[:template_name]}.mjml")
      erb_layout.render(scope) { erb_template.render(scope) }
    end

    def mjml_template_content(headers, scope)
      erb_template = Tilt::ERBTemplate.new("#{headers[:template_path]}/#{headers[:template_name]}.mjml")
      erb_template.render(scope)
    end
  end
end
