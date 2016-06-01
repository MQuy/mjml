module Mjml
  class Render
    attr_accessor :path, :args, :content, :instance

    def initialize(path, args, instance)
      @path = path
      @args = args
      @instance = instance || binding
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

    def template_variables
      @template_variables ||= args.inject(instance) { |b, item| b.local_variable_set(item[0], item[1]) and b }
    end

    def template_mjml
      @template_mjml ||= lambda do
        template_erb = File.open(path).read
        ERB.new(template_erb).result(template_variables)
      end.call
    end
  end
end
