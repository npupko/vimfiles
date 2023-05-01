return {
  'tpope/vim-rails',
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "eruby.yaml",
      command = "set filetype=yaml",
    })

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
      ["app/*.rb"] = {
        alternate = "spec/{}_spec.rb",
        type = "source"
      },
      ["spec/*_spec.rb"] = {
        alternate = "app/{}.rb",
        type = "test"
      },
      ["app/controllers/*.rb"] = {
        alternate = "spec/requests/{}_spec.rb",
        type = "source"
      },
      ["spec/requests/*_spec.rb"] = {
        alternate = "app/{}.rb",
        type = "test"
      }
    }
  end,
}
