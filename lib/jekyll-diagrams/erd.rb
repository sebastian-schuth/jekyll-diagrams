# frozen_string_literal: true

module Jekyll
  module Diagrams
    class ErdBlock < Block
      XML_REGEX = /^<\?xml(([^>]|\n)*>\n?){2}/.freeze
      CONFIGURATIONS = %w[config edge].freeze

      def render_svg(code, config)
        command = build_command(config)

        svg = render_with_stdin_stdout(command, code)
        svg.sub!(XML_REGEX, '')
      end

      def build_command(config)
        command = +'erd --fmt=svg'
        command << ' --dot-entity' if config.fetch('dot-entity', false) != false

        CONFIGURATIONS.each do |conf|
          command << " --#{conf}=#{config[conf]}" if config.key?(conf)
        end

        command
      end
    end
  end
end

Liquid::Template.register_tag(:erd, Jekyll::Diagrams::ErdBlock)