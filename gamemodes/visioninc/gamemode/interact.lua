local entities = {}

local function interacted(name)
    if entities[name] then
        entities[name] = false
        return true
    else
        return false
    end
end
    
util.AddNetworkString("VisionInc_UseInteractable")
net.Receive("VisionInc_UseInteractable", function(len, ply)
    local ent = net.ReadEntity()

    if IsValid(ent) and ent:GetClass() == "func_button" then -- Button interaction
        ent:Fire("PressIn", "", 0)
    end

    entities[ent:GetName()] = true
end)


local keys = {}
local code = {"red", "green", "blue", "yellow"}

local output1 = ents.FindByName("keypad_output_1")[1]
local output2 = ents.FindByName("keypad_output_2")[1]
local output3 = ents.FindByName("keypad_output_3")[1]
local output4 = ents.FindByName("keypad_output_4")[1]

hook.Add("Think", "VisionInc_KeyPad", function()
    if not IsValid(output1) or not IsValid(output2) or not IsValid(output3) or not IsValid(output4) then
        return -- Don't do anything if the outputs aren't valid
    end


    if interacted("keypad_button_red") then
       table.insert(keys, "red")
    elseif interacted("keypad_button_green") then
        table.insert(keys, "green")
    elseif interacted("keypad_button_blue") then
        table.insert(keys, "blue")
    elseif interacted("keypad_button_yellow") then
        table.insert(keys, "yellow")
    end

    if #keys == 1 then
        output1:SetColor(Color(0, 0, 0))
        output2:SetColor(Color(86, 108, 87))
        output2:SetColor(Color(86, 108, 87))
        output2:SetColor(Color(86, 108, 87))
    elseif #keys == 2 then
        output1:SetColor(Color(0, 0, 0))
        output2:SetColor(Color(0, 0, 0))
        output3:SetColor(Color(86, 108, 87))
        output4:SetColor(Color(86, 108, 87))
    elseif #keys == 3 then
        output1:SetColor(Color(0, 0, 0))
        output2:SetColor(Color(0, 0, 0))
        output3:SetColor(Color(0, 0, 0))
        output4:SetColor(Color(86, 108, 87))
    else
        output1:SetColor(Color(86, 108, 87))
        output2:SetColor(Color(86, 108, 87))
        output3:SetColor(Color(86, 108, 87))
        output4:SetColor(Color(86, 108, 87))
    end

    if #keys == 4 then
        if table.concat(keys) == table.concat(code) then
            local door = ents.FindByName("storage_door")[1]
            door:Fire("Unlock", "", 0)
            door:Fire("Open", "", 0)

            output1:SetColor(Color(0, 0, 0))
            output2:SetColor(Color(0, 0, 0))
            output3:SetColor(Color(0, 0, 0))
            output4:SetColor(Color(0, 0, 0))

            hook.Remove("Think", "VisionInc_KeyPad")
        else
            print("Incorrect!")
        end

        keys = {}
    end
end)