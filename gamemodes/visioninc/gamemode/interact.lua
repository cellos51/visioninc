

util.AddNetworkString("VisionInc_UseInteractable")
net.Receive("VisionInc_UseInteractable", function(len, ply)
    local ent = net.ReadEntity()

    if IsValid(ent) and ent:GetClass() == "func_button" then -- Button interaction
        print("Button pressed: " .. ent:GetName())
        ent:Fire("PressIn", "", 0)
    end
end)