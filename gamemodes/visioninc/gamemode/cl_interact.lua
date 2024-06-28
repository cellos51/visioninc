local interactDistance = 70

hook.Add("HUDPaint", "VisionInc_HighlightInteractable", function()
    local ply = LocalPlayer()
    if not IsValid(ply) then return end

    local trace = ply:GetEyeTrace()
    if trace.HitPos:Distance(ply:GetPos()) < interactDistance and IsValid(trace.Entity) then
        if trace.Entity:GetClass() == "class C_BaseEntity" then
            local ent = trace.Entity
            halo.Add({ent}, Color(255, 255, 0), 2, 2, 2, true, true)
        else
            return -- Don't do anything if the entity isn't interactable
        end 
    end
end)

local buttonDown = false

hook.Add("Think", "VisionInc_Interact", function()
    local ply = LocalPlayer()
    if not IsValid(ply) then return end

    if input.IsButtonDown(KEY_E) and buttonDown == false then
        buttonDown = true
        local trace = ply:GetEyeTrace()

        if trace.HitPos:Distance(ply:GetPos()) < interactDistance and IsValid(trace.Entity) then
            if trace.Entity:GetClass() == "class C_BaseEntity" then
                net.Start("VisionInc_UseInteractable")
                net.WriteEntity(trace.Entity)
                net.SendToServer()
            end
        else
            return -- Don't do anything if the entity isn't interactable
        end
    elseif not input.IsButtonDown(KEY_E) then
        buttonDown = false
    end
end)