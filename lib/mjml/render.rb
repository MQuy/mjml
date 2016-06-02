module Mjml
  class Render
    attr_accessor :path, :scope, :content, :block

    def initialize(path, scope, block)
      @path = path
      @scope = scope
      @block = block
    end

    def execute
      generate_mjml_file
      generate_html_file
      read_html_file
      clear_tmp_files
      content
    end

    private

    def generate_mjml_file
      File.write(mjml_path, template_mjml)
    end

    def generate_html_file
      `#{Config.exec_path.chomp} #{mjml_path} -o #{html_path}`
    end

    def read_html_file
      @content ||= File.open(html_path).read
    end

    def clear_tmp_files
      File.delete(mjml_path)
      File.delete(html_path)
    end

    def mjml_path
      @mjml_path ||= "#{Dir.pwd}/tmp/template-#{SecureRandom.uuid}.mjml"
    end

    def html_path
      @html_path ||= "#{Dir.pwd}/tmp/template-#{SecureRandom.uuid}.html"
    end

    def template_mjml
      @template_mjml ||= lambda do
        erb = Tilt::ERBTemplate.new(path)
        erb.render(scope) { block&.call }
      end.call
    end
  end
end
