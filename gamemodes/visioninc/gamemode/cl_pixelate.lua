-- this is taken from https://steamcommunity.com/sharedfiles/filedetails/?id=2874593084 i dont take credit for this code and i am only using it because i can't figure out how to link the addon
local materials = {rt = nil, mat = nil}
local pixelLevel = 4
local wait = 0
local function RebuildMaterials()
	if wait > SysTime() then return end
	local w, h = ScrW(), ScrH()

	materials.rt = GetRenderTarget("pixelation_rt", w, h, RT_SIZE_NO_CHANGE, MATERIAL_RT_DEPTH_SEPARATE, 1, 0, IMAGE_FORMAT_BGRA8888)
	materials.mat = CreateMaterial("pixelation_material", "UnlitGeneric", {["$basetexture"] = materials.rt:GetName()})
	materials.mat:SetInt("$flags", bit.bor(materials.mat:GetInt("$flags"), 32768))
	wait = SysTime() + 1 
end

local function Draw()
	local mat, rt = materials.mat, materials.rt
	
	if not mat or not rt then return RebuildMaterials() end

	local w, h = ScrW(), ScrH()

	if pixelLevel < 2 then return end

	render.CopyRenderTargetToTexture(render.GetScreenEffectTexture())

	local wDiv, hDiv = math.ceil(w / pixelLevel), math.ceil(h / pixelLevel)
	render.PushRenderTarget(materials.rt, 0, 0, wDiv, hDiv)
	render.DrawTextureToScreenRect(render.GetScreenEffectTexture(), 0, 0, wDiv, hDiv)
	render.PopRenderTarget()

	surface.SetDrawColor(255, 255, 255)
	surface.SetMaterial(materials.mat)

	local filter = 1
	render.PushFilterMag(filter)
	surface.DrawTexturedRect(0, 0, math.ceil(w * pixelLevel), math.ceil(h * pixelLevel))
	render.PopFilterMag()
end

hook.Add("Initialize", "pixelation_postprocess", function()
	hook.Add("RenderScreenspaceEffects", "pixelation_pp", Draw)
	hook.Add("OnScreenSizeChanged", "pixelation", RebuildMaterials)
end)

