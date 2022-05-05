vim.g.rails_projections = {
  ["app/services/*.rb"] = {
    command = "service",
    test = "spec/services/{}_spec.rb",
    template = {
      "# frozen_string_literal: true",
      "",
      "class {camelcase|capitalize|colons}",
      "  include Callable",
      "",
      "  def call",
      "  end",
      "end",
    }
  },
  ["spec/services/*_spec.rb"] = {
    command = "sspec",
    template = {
      "# frozen_string_literal: true",
      "",
      "RSpec.describe {camelcase|capitalize|colons}, type: :service do",
      "end"
    },
    type = "functional test"
  },
}
