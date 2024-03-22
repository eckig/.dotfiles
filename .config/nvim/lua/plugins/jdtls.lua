local os_config = "linux"
if vim.fn.has("mac") == 1 then
  os_config = "mac"
end
if vim.fn.has("windows") == 1 then
  os_config = "win"
end

local jdk_path = os.getenv("JDK21")

return {
  {
    "mfussenegger/nvim-jdtls",
    opts = function()
      return {
        root_dir = require("lspconfig.server_configurations.jdtls").default_config.root_dir,

        cmd = {
          jdk_path .. "/bin/java",
        },
        flags = { debounce_text_changes = 80 },
        settings = {
          java = {
            autobuild = { enabled = false },
            maxConcurrentBuilds = 8,
            signatureHelp = { enabled = true },
            saveActions = {
              organizeImports = true,
            },
            completion = {
              favoriteStaticMembers = {
                "io.crate.testing.Asserts.assertThat",
                "org.assertj.core.api.Assertions.assertThat",
                "org.assertj.core.api.Assertions.assertThatThrownBy",
                "org.assertj.core.api.Assertions.assertThatExceptionOfType",
                "org.assertj.core.api.Assertions.catchThrowable",
                "org.hamcrest.MatcherAssert.assertThat",
                "org.hamcrest.Matchers.*",
                "org.hamcrest.CoreMatchers.*",
                "org.junit.jupiter.api.Assertions.*",
                "java.util.Objects.requireNonNull",
                "java.util.Objects.requireNonNullElse",
                "org.mockito.Mockito.*",
              },
              filteredTypes = {
                "com.sun.*",
                "java.awt.*",
                "jdk.*",
                "sun.*",
              },
            },
            sources = {
              organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
              },
            },
            codeGeneration = {
              hashCodeEquals = {
                useJava7Objects = true,
              },
              useBlocks = true,
            },
            configuration = {
              updateBuildConfiguration = "disabled",
              runtimes = {
                {
                  name = "JavaSE-21",
                  path = jdk_path,
                },
              },
            },
          },
        },
        full_cmd = function(opts)
          local fname = vim.api.nvim_buf_get_name(0)
          local root_dir = opts.root_dir(fname)
          local cmd = vim.deepcopy(opts.cmd)
          local workspace_folder = vim.fn.stdpath("cache")
            .. "/jdtls/"
            .. vim.fn.fnamemodify(root_dir, ":p:h:t")
            .. "/workspace"
          local config_folder = vim.fn.stdpath("cache")
            .. "/jdtls/"
            .. vim.fn.fnamemodify(root_dir, ":p:h:t")
            .. "/config"

          local mason_registry = require("mason-registry")
          local java_jdtls_pkg = mason_registry.get_package("jdtls")
          local java_jdtls_path = java_jdtls_pkg:get_install_path()
          local java_jdtls_bin = vim.fn.glob(java_jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

          vim.list_extend(cmd, {
            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
            "-Dosgi.bundles.defaultStartLevel=4",
            "-Declipse.product=org.eclipse.jdt.ls.core.product",
            "-Dosgi.checkConfiguration=true",
            "-Dosgi.sharedConfiguration.area=" .. java_jdtls_path .. "/config_" .. os_config,
            "-Dosgi.sharedConfiguration.area.readOnly=true",
            "-Dosgi.configuration.cascaded=true",
            "-Xms1G",
            "-Xmx4g",
            "--add-modules=ALL-SYSTEM",
            "--add-opens",
            "java.base/java.util=ALL-UNNAMED",
            "--add-opens",
            "java.base/java.lang=ALL-UNNAMED",
            "-jar",
            java_jdtls_bin,
            "-configuration",
            config_folder,
            "-data",
            workspace_folder,
          })

          return cmd
        end,

        dap = { hotcodereplace = "auto", config_overrides = {} },
        dap_main = {},
        test = true,
      }
    end,
  },
}
