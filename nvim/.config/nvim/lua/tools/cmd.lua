-- quick exec command tool

local uv = vim.loop

function async_execute(command, callback)
  local stdout = uv.new_pipe(false)
  local stderr = uv.new_pipe(false)
  local handle

  handle = uv.spawn('sh', {
    args = {'-c', command},
    stdio = {nil, stdout, stderr}
  }, function(code, signal)
    stdout:read_stop()
    stderr:read_stop()
    stdout:close()
    stderr:close()
    handle:close()

    callback(code, stdout, stderr)
  end)

end
