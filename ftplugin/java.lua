local jdtls = require('jdtls')

-- 1. Paths & Environment
local java_25_bin = "/Users/rferegrino/.sdkman/candidates/java/25.0.2-tem/bin/java"
local mason_path = vim.fn.stdpath("data") .. "/mason/packages"
local jdtls_path = mason_path .. "/jdtls"

local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local config_dir = jdtls_path .. "/config_mac"
local lombok_jar = jdtls_path .. "/lombok.jar"

-- 2. Debugger & Test Bundles (Required for Java DAP/Testing)
local bundles = {
  vim.fn.glob(mason_path .. "/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", 1),
}
local java_test_jars = vim.split(vim.fn.glob(mason_path .. "/java-test/extension/server/*.jar", 1), "\n")
for _, jar in ipairs(java_test_jars) do
  if not vim.endswith(jar, "com.microsoft.java.test.runner-jar-with-dependencies.jar") then
    table.insert(bundles, jar)
  end
end

-- 3. Workspace Detection
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = jdtls.setup.find_root(root_markers)
if root_dir == "" then return end

local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls-workspace/" .. project_name

-- 4. Java-Specific on_attach
local on_attach = function(client, bufnr)
  -- Connect JDTLS to nvim-dap
  jdtls.setup_dap({ hotcodereplace = 'auto' })
  
  local opts = { buffer = bufnr, silent = true }
  vim.keymap.set('n', '<leader>co', jdtls.organize_imports, { desc = "Java: Organize Imports", buffer = bufnr })
  vim.keymap.set('n', '<leader>cv', jdtls.extract_variable, { desc = "Java: Extract Variable", buffer = bufnr })
  vim.keymap.set('v', '<leader>cm', [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], { desc = "Java: Extract Method", buffer = bufnr })
end

-- 5. Full Config
local config = {
  cmd = {
    java_25_bin,
    "-Xmx1g",
    "-javaagent:" .. lombok_jar,
    "-jar", launcher_jar,
    "-configuration", config_dir,
    "-data", workspace_dir,
  },
  root_dir = root_dir,
  on_attach = on_attach,
  init_options = {
    bundles = bundles,
    extendedClientCapabilities = jdtls.extendedClientCapabilities,
  },
  settings = {
    java = {
      configuration = {
        runtimes = {
          {
            name = "JavaSE-17",
            path = "/Users/rferegrino/.sdkman/candidates/java/17.0.11-tem/",
            default = true,
          },
        }
      }
    }
  }
}

jdtls.start_or_attach(config)
