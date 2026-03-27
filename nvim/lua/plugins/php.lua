return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        php = { "php_cs_fixer" },
      },
      formatters = {
        php_cs_fixer = {
          -- 1. Force a ruleset since there's no composer.json to guide it
          -- 2. Add --no-interaction to prevent hanging on errors
          prepend_args = { "--rules=@PSR12", "--no-interaction" },

          -- Remove the check for composer.json as the root file
          cwd = require("conform.util").root_file({ ".php-cs-fixer.dist.php", ".php-cs-fixer.php", ".git" }),
        },
      },
    },
  },
}
