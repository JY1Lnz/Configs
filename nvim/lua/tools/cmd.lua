-- quick exec command tool

local uv = vim.loop

local function async_execute(command, callback)
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

  uv.read_start(stdout, function(err, data)
    -- assert(not err, err)
    -- print (data
    -- if data then
    --   print(data)
    -- end
  end)

end

async_execute("sleep 3", function(code, stdout, stderr)
  print ("ok")
end)
