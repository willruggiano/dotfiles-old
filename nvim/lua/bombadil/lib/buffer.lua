local bufdelete = require("bufdelete").bufdelete

local delete_buffer = function(bufnr)
  if vim.fn.bufwinnr(bufnr) ~= -1 then
    bufdelete(bufnr, true)
  else
    vim.api.nvim_buf_delete(bufnr, { force = true })
  end
end

return {
  delete_buffer = delete_buffer,
}
