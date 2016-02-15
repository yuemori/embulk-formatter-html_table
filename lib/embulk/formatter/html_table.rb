module Embulk
  module Formatter
    class HtmlTable < FormatterPlugin
      Plugin.register_formatter("html_table", self)

      NEWLINES = {
        'CRLF' => "\r\n",
        'LF' => "\n",
        'CR' => "\r",
        'NUL' => "\0"
      }

      def self.join_texts((*inits,last), opt = {})
        delim = opt[:delimiter] || ', '
        last_delim = opt[:last_delimiter] || ' or '
        [inits.join(delim),last].join(last_delim)
      end

      def self.transaction(config, schema, &control)
        task = {
          'encoding' => config.param('encoding', :string, default: 'UTF-8'),
          'newline' => config.param('newline', :string, default: 'LF'),
          'to_br' => config.param('to_br', :bool, default: true),
          'timestamp_format' => config.param('timestamp_format', :string, default: '%Y-%m-%d %H-%M-%S'),
        }

        yield(task)
      end

      def init
        @header_print = true
        @encoding = task['encoding'].upcase
        @newline = NEWLINES[task['newline'].upcase]
        @to_br = task['to_br']
        @timestamp_format = task['timestamp_format']
        @current_file = nil
        @current_file_size = 0
      end

      def close
      end

      def add(page)
        page.each do |record|
          if @current_file == nil
            @current_file = file_output.next_file
            @current_file_size = 0
          elsif @current_file_size > 32*1024
            @current_file.write '</table>'.encode(@encoding)
            @current_file = file_output.next_file
            @current_file_size = 0
          end

          if @header_print
            @current_file.write "<table>#{@newline}".encode(@encoding)
            header  = "<tr>#{page.schema.map(&:name).map { |name| "<th>#{name}</th>"}.join('')}</tr>#{@newline}"
            @current_file.write header.encode(@encoding)
            @header_print = false
          end

          row = "<tr>#{record.map { |col| format(col) }.join('')}</tr>#{@newline}"
          @current_file.write row.encode(@encoding)
        end
      end

      def format(column)
        if @to_br
          column = column.strftime(@timestamp_format) if column.is_a? Time
          column = column.to_s.split(@newline).join('<BR>') if @to_br
        end
        "<td>#{column}</td>"
      end

      def finish
        @current_file.write '</table>'.encode(@encoding)
        file_output.finish
      end
    end
  end
end
