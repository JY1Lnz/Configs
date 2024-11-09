local is_debug = false;
local diffview_open = false
local state = {

}
local M = {
  set_debug = function(debug)
    is_debug = debug
  end,
  get_debug = function()
    return is_debug
  end,
  set = function (key, value)
    state[key] = value
  end,
  get = function (key)
    if state[key] == nil then
      return false
    end
    return state[key]
  end
}
return M
