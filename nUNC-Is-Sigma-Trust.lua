local TextChatService = game:GetService("TextChatService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local e = "https://raw.githubusercontent.com/NebulaHubRBLX/24356784753487645969674893543567897uyhgbvbgyrt67tyu66666322hfgbc798345768teyfdguishf43iu5y3498579834/refs/heads/main/nUNC.lua"

TextChatService.MessageReceived:Connect(function(textChatMessage)
    if not textChatMessage then return end
    local msgText = textChatMessage.Text
    local source = textChatMessage.TextSource

    if source and source.UserId == player.UserId and msgText and msgText:lower() == "-run" then

        local success, err = pcall(function()
            local code = game:HttpGet(e)
            local fn = loadstring(code)
            if type(fn) == "function" then
                fn()
            else
                error("Loaded content is not a function")
            end
        end)
        if not success then
            warn("Failed to execute nUNC:", err)
        end
    end
end)
