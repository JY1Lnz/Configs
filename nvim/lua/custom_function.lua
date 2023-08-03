function Exec()
  local session = require'dap'.session()
  if session == nil then
    print ("No session")
    return
  end
  session:evaluate(vim.fn.input("Input expr: "), function(err, resp)
    if err then
      print(err)
    elseif resp and resp.result then
      print(resp.result)
    end
  end)
end
