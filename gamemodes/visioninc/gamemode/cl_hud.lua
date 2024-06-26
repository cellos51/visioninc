local hide = {
	["CHudHealth"] = true,
	["CHudBattery"] = true,
	["CHudAmmo"] = true,
	["CHudSecondaryAmmo"] = true,
	["CHudCrosshair"] = true,
	["CHudWeaponSelection"] = true,
	["CHudDamageIndicator"] = true,
	["CHudZoom"] = true,
	["CHudPoisonDamageIndicator"] = true,
	["CHudSuitPower"] = true,
	["CHudGeiger"] = true,
	["CHudVoiceStatus"] = true,
	["CHudVoiceSelfStatus"] = true,
}

hook.Add( "HUDShouldDraw", "HideHUD", function( name )
	if ( hide[ name ] ) then
		return false
	end
end )