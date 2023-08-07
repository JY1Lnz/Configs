local M = {}

local function fileExists(filename)
    local file = io.open(filename, "r")
    if file then
        io.close(file)
        return true
    else
        return false
    end
end

M.fileExists = fileExists

return M
