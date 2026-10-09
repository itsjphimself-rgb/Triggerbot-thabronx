local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local KeyWindow = Fluent:CreateWindow({
    Title = "TB Key System",
    SubTitle = "Jnkie Verification Required",
    TabWidth = 160,
    Size = UDim2.fromOffset(480, 320),
    Acrylic = true,
    Theme = "Darker"
})

local KeyTab = KeyWindow:AddTab({ Title = "Authentication", Icon = "key" })
KeyWindow:SelectTab(1)

local KeyInput = KeyTab:AddInput("KeyInput", {
    Title = "Enter Access Key",
    Placeholder = "Enter your Jnkie Key...",
    Numeric = false,
    Finished = false,
    Callback = function() end
})

KeyTab:AddButton({
    Title = "Verify Key",
    Callback = function()
        local inputKey = KeyInput.Value
        if inputKey and inputKey ~= "" then
            -- Set the global variable Jnkie expects before running the loader
            getgenv().SCRIPT_KEY = inputKey
            
            Fluent:Notify({ Title = "Connecting", Content = "Verifying key with Jnkie servers...", Duration = 2 })
            
            -- Wait a moment, clean up the Key UI, then execute Jnkie
            task.delay(1, function()
                Fluent:Destroy()
                task.wait(0.5)
                
                local success, err = pcall(function()
                    loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/0cce7cba4f036d04de024114e7647f8dbdcfc700f071cd0fd8a3b7b59364d8d2/download"))()
                end)
                
                if not success then
                    warn("Jnkie Failed to Load: " .. tostring(err))
                end
            end)
        else
            Fluent:Notify({ Title = "Error", Content = "Please enter a key first!", Duration = 3 })
        end
    end
})
