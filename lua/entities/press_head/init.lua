AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
 
include("shared.lua")

function ENT:Initialize()
	self:SetModel( "models/press-plates/press_head.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )      
	self:SetMoveType( MOVETYPE_NONE )   
	self:SetSolid( SOLID_VPHYSICS )        
	self:SetUseType(SIMPLE_USE)  
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
  local phys = self:GetPhysicsObject() 
end
