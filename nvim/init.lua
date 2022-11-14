local ok,_ = pcall(require, "impatient")
if ok then
	require('impatient')
end



require('user.plugin')

require('user.core.disable_builtin')
require('user.core.setting')
require('user.core.autocmd')
require('user.core.key')
