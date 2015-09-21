require 'torch'

local MdWriter = torch.class("MdWriter")

function MdWriter:__init(filename)
  local err
  self.file, err = io.open(filename, "w")
  if err then
    error("Error opening " .. filename .. " for writing.")
  end
  self.lastLineBlank = false
end


function MdWriter:writeLn(line)
  if line == nil or line == "" then
    if not self.lastLineBlank then
      self.file:write("\n")
    end
    self.lastLineBlank = true
    return
  end

  self.file:write(line .. "\n")
  self.lastLineBlank = false
end

function MdWriter:close()
  self.file:close()
  self.file = nil
end


