# frozen_string_literal: true

module OutwoodLabels
  module Template
    class EmailPasswordInitial < EmailPassword
      template_name 'email-initial-password'
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
        "Initial password"
      end
    end
  end
end
