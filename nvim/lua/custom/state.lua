local is_debug = false;
local M = {
  set_debug = function(debug)
    is_debug = debug
  end,
  get_debug = function()
    return is_debug
  end

}
return M
