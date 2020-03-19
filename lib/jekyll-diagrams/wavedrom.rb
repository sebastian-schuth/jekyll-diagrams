# frozen_string_literal: true

module Jekyll
  module Diagrams
    class WavedromBlock < Block
      def render_svg(code, config)
        command = build_command(config)

        render_with_tempfile(command, code) do |input, output|
          "--input #{input} --svg #{output}"
        end
      end

      def build_command(_config)
        'wavedrom-cli'
      end
    end
  end
end

Liquid::Template.register_tag(:wavedrom, Jekyll::Diagrams::WavedromBlock)