if not SystemChatMover then SystemChatMover = { 1 } end
local gfind = string.gmatch or string.gfind
local popup = nil

SystemChatMover_ChatFrame_OnEvent = ChatFrame_OnEvent

function ChatFrame_OnEvent(event)
  local highlight, match = "|cffffdd00", nil
  local original = arg1

  local r = ChatTypeInfo["SYSTEM"].r
  local g = ChatTypeInfo["SYSTEM"].g
  local b = ChatTypeInfo["SYSTEM"].b
  local rgb = r..","..g..","..b

  if (event == "CHAT_MSG_SYSTEM" and arg1) then

    for i=1, table.getn(SystemChatMover) do
      local id = SystemChatMover[i]
      local chatframe = "ChatFrame" .. id
      local c, d=loadstring(chatframe..":AddMessage(arg1,"..rgb..")") c()
    end

  return
  end

  SystemChatMover_ChatFrame_OnEvent(event)
end

SLASH_SYSTEMCHATMOVER1, SLASH_SYSTEMCHATMOVER2 = "/scm", "/systemchatmover"
SlashCmdList["SYSTEMCHATMOVER"] = function(message)
  local commandlist = { }
  local command

  local r = ChatTypeInfo["SYSTEM"].r
  local g = ChatTypeInfo["SYSTEM"].g
  local b = ChatTypeInfo["SYSTEM"].b

  for command in gfind(message, "[^ ]+") do
    table.insert(commandlist, string.lower(command))
  end

  local frame = table.concat(commandlist," ",2)

  -- add channel
  if commandlist[1] == "add" then
    if not tonumber(frame) then DEFAULT_CHAT_FRAME:AddMessage("You must enter in a number.",r,g,b) return end
    table.insert(SystemChatMover, frame)
    DEFAULT_CHAT_FRAME:AddMessage("System messages will also be displayed on frame: "..frame,r,g,b)

  -- remove entry
  elseif commandlist[1] == "rm" then
    if not tonumber(frame) then DEFAULT_CHAT_FRAME:AddMessage("You must enter in a number.",r,g,b) return end
    if tonumber(frame) then
      DEFAULT_CHAT_FRAME:AddMessage("System messages will no longer be displayed on frame: " .. frame,r,g,b)
      for i=1, table.getn(SystemChatMover) do
        if SystemChatMover[i] == frame then
          table.remove(SystemChatMover, i)
          break
        end
      end
      DEFAULT_CHAT_FRAME:AddMessage(SystemChatMover[i],r,g,b)
    end
  elseif commandlist[1] == "ls" then
    local o = ''
    for i=1, table.getn(SystemChatMover) do
      o = o..SystemChatMover[i]..", "
    end
    o = string.sub(o,1,-3)
    DEFAULT_CHAT_FRAME:AddMessage("System messages will be displayed on frame(s): "..o,r,g,b)
  else
    DEFAULT_CHAT_FRAME:AddMessage("System Chat Mover Examples:",r,g,b)
    DEFAULT_CHAT_FRAME:AddMessage("/scm add 3 - Adds system message to chat frame 3.",r,g,b)
    DEFAULT_CHAT_FRAME:AddMessage("/scm rm 3 - Removes system messages from chat frame 3",r,g,b)
    DEFAULT_CHAT_FRAME:AddMessage("/scm ls - Lists the frames that system messages will be displayed in.",r,g,b)
  end
end
