AddCSLuaFile()

SWEP.PrintName = "Lighter" -- This will be shown in the spawn menu, and in the weapon selection menu
SWEP.Author = "" -- These two options will be shown when you have the weapon highlighted in the weapon selection menu
SWEP.Instructions = "Left mouse to start a fire."

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom	= false

SWEP.Slot = 1
SWEP.SlotPos = 2
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true

SWEP.ViewModel = "models/lighter.mdl"
SWEP.WorldModel	= "models/lighter.mdl"

SWEP.OpenSound = Sound("lighter/open.wav")
SWEP.CloseSound = Sound("lighter/close.wav")
SWEP.ViewModelPos = Vector(8, 7, -2)
SWEP.ViewModelAng = Vector(0, 30, 0)

function SWEP:Initialize()
    self.CurrentLight = nil
    self.lighterOn = false
end

function SWEP:PrimaryAttack()
    self:SetNextPrimaryFire(CurTime() + 1) -- Set the fire rate

    self.lighterOn = not self.lighterOn

    if SERVER then	
		local vm = self:GetOwner():GetViewModel()
		if self.lighterOn then
			vm:SendViewModelMatchingSequence(vm:LookupSequence("open"))
			timer.Simple(0.9, function()
				vm:SendViewModelMatchingSequence(vm:LookupSequence("on_idle"))
			end)
	
			timer.Simple(0.4, function()
				self:EmitSound(self.OpenSound)
				if not IsValid(self.CurrentLight) then
					self.CurrentLight = ents.Create("light_dynamic")
				end
	
				self.CurrentLight:Spawn()
				self.CurrentLight:SetKeyValue("distance", 256)
				self.CurrentLight:SetKeyValue("brightness", 2)
				self.CurrentLight:SetKeyValue("style", 6)
				self.CurrentLight:SetKeyValue("rendercolor", string.format("%d %d %d", Color(255, 169, 89):Unpack()))
				self.CurrentLight:Fire("TurnOn", "", 0)
			end)
		else
			vm:SendViewModelMatchingSequence(vm:LookupSequence("close"))
			timer.Simple(0.9, function()
				vm:SendViewModelMatchingSequence(vm:LookupSequence("closed_idle"))
			end)
	
			timer.Simple(0.1, function()
				self:EmitSound(self.CloseSound)
				if IsValid(self.CurrentLight) then 
					self.CurrentLight:Remove()
				end
			end)
		end
    end
end

function SWEP:SecondaryAttack()

end

function SWEP:OnRemove()
    if IsValid(self.CurrentLight) then
        self.CurrentLight:Remove()
    end
end

function SWEP:Holster()
    if IsValid(self.CurrentLight) then
        self.CurrentLight:Remove()
    end
	
    return true -- Allow weapon switch
end

function SWEP:Deploy()
	local vm = self:GetOwner():GetViewModel()
	if IsValid(vm) then
		if self.lighterOn then
			vm:SendViewModelMatchingSequence(vm:LookupSequence("on_idle"))
		else
			vm:SendViewModelMatchingSequence(vm:LookupSequence("closed_idle"))
		end
		self.initializedVM = true -- Mark as initialized to prevent repeated execution
	end

	return true -- Allow weapon deploy
end

function SWEP:Think()
    if self.lighterOn and IsValid(self.CurrentLight) then 
		self.CurrentLight:SetPos(self:GetOwner():GetPos() + Vector(0, 0, 50))
	end
end

function SWEP:GetViewModelPosition(EyePos, EyeAng)
	EyeAng = EyeAng * 1
	
	EyeAng:RotateAroundAxis(EyeAng:Right(), 	self.ViewModelAng.x)
	EyeAng:RotateAroundAxis(EyeAng:Up(), 		self.ViewModelAng.y)
	EyeAng:RotateAroundAxis(EyeAng:Forward(),   self.ViewModelAng.z)

	local Right 	= EyeAng:Right()
	local Up 		= EyeAng:Up()
	local Forward 	= EyeAng:Forward()

	EyePos = EyePos + self.ViewModelPos.x * Right
	EyePos = EyePos + self.ViewModelPos.y * Forward
	EyePos = EyePos + self.ViewModelPos.z * Up
	
	return EyePos, EyeAng
end