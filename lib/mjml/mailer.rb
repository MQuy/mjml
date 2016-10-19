module Mjml
  module Mailer
    def mjml(headers, &block)
      scope = Mjml::Scope.new(self, headers[:template_variables])

      headers[:subject] ||= I18n.t("mailers.#{mailer_name}.#{action_name}.subject", headers[:subject_variables])
      headers[:template_name] ||= action_name
      headers[:template_path] ||= "#{Dir.pwd}/app/views/mailers/#{mailer_name}"
      headers[:body] = mjml_content(headers, scope)
      headers[:content_type] = "text/html"

      mail(headers, &block)
    end

    def mailer_name
      self.class.name.underscore.sub(/_mailer$/, '')
    end

    def t(pharse, args = {})
      if pharse =~ /\A\./
        I18n.t("mailers.#{mailer_name}.#{action_name}#{pharse}", args)
      else
        super
      end
    end

    private

    def mjml_content(headers, scope)
      content =
        if _layout
          mjml_layout_content(headers, scope)
        else
          mjml_template_content(headers, scope)
        end

      Mjml.template(content)
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
