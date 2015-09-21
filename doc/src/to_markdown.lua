require 'MdWriter'


function capitalize(str)
  return string.lower(str):gsub("^%l", string.upper)
end


function startsWith(str, prefix)
   return str:sub(1, #prefix) == prefix
end


local function trim(s)
  return s:gsub("^%s*(.-)%s*$", "%1")
end


local function expandHtmlEntities(str)
  str = str:gsub("&lt;", "<")
  str = str:gsub("&gt;", ">")
  str = str:gsub("&amp;", "&")
  return str
end


local function convertIndex(input, output)
  local infile, err = io.open(input, "r")
  if err then
    error("Error opening " .. input .. " for reading.")
  end

  local outfile = MdWriter(output)
  local echo = true

  while true do
    line = infile:read()
    if line == nil then break end
    line = line:gsub("doubldoc.html", "doubldoc.md")
    if line == "---" then
      echo = not echo
    end
    if echo and line ~= "---" then
      outfile:writeLn(line)
    end
  end

  outfile:close()
  infile:close()
end


local function convertDocs(input, output)
  local infile, err = io.open(input, "r")
  if err then
    error("Error opening " .. input .. " for reading.")
  end

  local outfile = MdWriter(output)

  local descriptions = {}
  local curSubsection
  while true do
    line = infile:read()
    if line == nil then break end

    -- Detect title
    local first, last, title = line:find('<TITLE>([^<]*)</TITLE>')
    if title then
      outfile:writeLn()
      outfile:writeLn("# " .. title)
      outfile:writeLn()
    end

    -- Detect TOC entry
    local first, last, name, description = line:find('<A HREF="[^"]*">([^,]*),([^<]*)</A>')
    if name and description then
      descriptions[name] = trim(description)
    end

    -- Detect subsection
    local first, last, subsection = line:find('\\* ([A-Z ]*):')
    if subsection then
      outfile:writeLn(capitalize(subsection) .. ":")
      outfile:writeLn()
      curSubsection = subsection
    end

    -- Detect section title
    local first, last, name = line:find('<A NAME="([^"]*)">')
    if name then
      assert(descriptions[name])
      outfile:writeLn()
      outfile:writeLn('<a name="' .. name .. '"></a>')
      outfile:writeLn("## " .. name .. " - " .. descriptions[name])
      curSubsection = nil
    elseif trim(line) == "*" then
      outfile:writeLn()
    elseif trim(line) == "*/" then
      -- Ignore
    elseif not subsection and startsWith(line, " *") then
      line = expandHtmlEntities(line:sub(4))
      if curSubsection then
        outfile:writeLn("    " .. line)
      else
        outfile:writeLn(line)
      end
    end
  end

  outfile:close()
  infile:close()
end


convertIndex("index.markdown", "../markdown/index.md")
convertDocs("doubldoc.html", "../markdown/doubldoc.md")


