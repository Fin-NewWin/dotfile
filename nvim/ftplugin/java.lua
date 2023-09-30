local mason_path = os.getenv("XDG_DATA_HOME") .. "/nvim/mason"
local config = {
    cmd = { mason_path .. "/bin/jdtls" },
    root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
}

require("jdtls").start_or_attach(config)
