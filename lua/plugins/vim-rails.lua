return {
  event = "VeryLazy",
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
          "require \"rails_helper\"",
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
        alternate = "app/controllers/{}.rb",
        type = "test"
      },
      -- GraphQL
      ["app/graphql/types/*.rb"] = {
        alternate = "spec/graphql/types/{}_spec.rb",
        type = "source"
      },
      ["spec/graphql/types/*_spec.rb"] = {
        alternate = "app/graphql/types/{}.rb",
        type = "test"
      },
      ["app/graphql/mutations/*.rb"] = {
        alternate = "spec/graphql/mutations/{}_spec.rb",
        type = "source"
      },
      ["spec/graphql/mutations/*_spec.rb"] = {
        alternate = "app/graphql/mutations/{}.rb",
        type = "test"
      },
      ["app/graphql/*.rb"] = {
        alternate = "spec/graphql/{}_spec.rb",
        type = "source"
      },
      ["spec/graphql/*_spec.rb"] = {
        alternate = "app/graphql/{}.rb",
        type = "test"
      },
    }
  end,
}
