require 'mustache/generator'

class Mustache
  class SchemaGenerator < Generator
    def generate(exp, as_ruby=true)
      schema = "{ #{compile!(exp)} }"
      as_ruby ? eval(schema) : schema
    end

    def on_collection(name, offset, content, raw, delims)
      "#{simple_name(name)}: [{ #{ compile!(content) } }]"
    end

    def on_section(name, offset, content, raw, delims)
      "#{simple_name(name)}: { #{ compile!(content) } }"
    end

    def on_utag(name, offset)
      "#{simple_name(name)}: ''"
    end

    alias_method :on_etag, :on_utag

    def str(s)
      ""
    end

    def simple_name(name)
      name.last.first
    end
  end
end
