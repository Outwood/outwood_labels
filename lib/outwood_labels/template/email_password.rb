# frozen_string_literal: true

module OutwoodLabels
  module Template
    class EmailPassword < Base
      PADDING = 6

      template_name 'email-password'
      page_layout 'Avery7160'
      accept_columns(
        'admin',
        'lastname',
        'firstname',
        'vmg',
        'email',
        'password'
      )

      def self.password_label
        "Password"
      end

      # @param data [#[]] data object
      # @param pdf [Prawn::Document]
      def self.evaluate(pdf, data)
        b = pdf.bounds
        full_width = b.width - (PADDING * 2)
        col1 = (full_width / 3).floor - 1
        col2 = (col1 * 2) - 1

        pdf.font 'Helvetica'

        pdf.move_down (PADDING * 2).round
        pdf.indent(PADDING) do
          pdf.text_box "#{data['firstname']} #{data['lastname']}",
            at: [b.left, pdf.cursor],
            width: full_width, height: 12,
            overflow: :truncate
        end
        pdf.move_down 12
        pdf.stroke_horizontal_rule
        pdf.move_down 6
        pdf.indent(PADDING) do
          pdf.font "Helvetica", size: 7 do
            pdf.text_box "Admin no.",
              at: [b.left, pdf.cursor],
              width: col1, height: 8
            pdf.text_box "Group",
              at: [b.right - col2, pdf.cursor],
              width: col2, height: 8
          end
          pdf.move_down 9
          pdf.text_box (data["admin"] || ""),
            at: [b.left, pdf.cursor],
            width: col1, height: 10,
            overflow: :shrink_to_fit
          pdf.text_box (data["vmg"] || ""),
            at: [b.right - col2, pdf.cursor],
            width: col2, height: 10,
            overflow: :shrink_to_fit
          pdf.move_down 16
          pdf.font_size 7 do
            pdf.text_box "Email",
              at: [b.left, pdf.cursor],
              width: full_width, height: 8
          end
          pdf.move_down 9
          pdf.text_box (data["email"] || ""),
            at: [b.left, pdf.cursor],
            width: full_width, height: 12,
            overflow: :shrink_to_fit
          pdf.move_down 16
          pdf.font_size 7 do
            pdf.text_box password_label,
              at: [b.left, pdf.cursor],
              width: full_width, height: 8
          end
          pdf.move_down 9
          pdf.font "Courier" do
            pdf.text_box (data["password"] || ""),
              at: [b.left, pdf.cursor],
              width: full_width, height: 12,
              overflow: :shrink_to_fit
          end
        end
      end
    end
  end
end
