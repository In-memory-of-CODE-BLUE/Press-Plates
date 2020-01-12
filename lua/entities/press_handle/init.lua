AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
 
include("shared.lua")

function ENT:Initialize()
	self:SetModel( "models/press-plates/press_handle.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )      
	self:SetMoveType( MOVETYPE_NONE )   
	self:SetSolid( SOLID_VPHYSICS )        
	self:SetUseType(SIMPLE_USE)  
  local phys = self:GetPhysicsObject() 
end
function ENT:Use(call)
	if not call:isArrested() then
		call:ChatPrint("This job is only for people who are arrested.")
		return 
	end  
	self:GetParent():OnHandlePressed(self)
end
