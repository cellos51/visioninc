AddCSLuaFile()
DEFINE_BASECLASS( "player_default" )

local PLAYER = {}

PLAYER.DuckSpeed = 0.3      -- How fast to go from not ducking, to ducking
PLAYER.UnDuckSpeed = 0.3    -- How fast to go from ducking, to not ducking

PLAYER.SlowWalkSpeed = 50
PLAYER.WalkSpeed = 100
PLAYER.RunSpeed = 200

function PLAYER:SetupDataTables()
    BaseClass.SetupDataTables( self )
end

function PLAYER:Loadout()
    -- Customize player loadout if needed
end

function PLAYER:SetModel()
    BaseClass.SetModel( self )
end

function PLAYER:Spawn()
    BaseClass.Spawn( self )
    -- Additional spawn logic if needed
end

function PLAYER:ShouldDrawLocal()
    -- Return true or false based on your requirement for local camera drawing
end

function PLAYER:CreateMove( cmd )
    -- Disable jumping
    if cmd:KeyDown( IN_JUMP ) then
        cmd:RemoveKey( IN_JUMP )
    end
end

function PLAYER:CalcView( view )
    -- Customize player view if needed
end

function PLAYER:StartMove( move )
    -- Modify player movement start if needed
end

function PLAYER:FinishMove( move )
    -- Modify player movement finish if needed
end

player_manager.RegisterClass( "player_vision", PLAYER, "player_default" )