AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
 
include("shared.lua")
local maxPlates = 5 --Per table (No more than five can exist at a time per table)

function ENT:Initialize()
	self:SetModel( "models/press-plates/workbench.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )     
	self:SetMoveType( MOVETYPE_VPHYSICS )   
	self:SetSolid( SOLID_VPHYSICS )          
	self:SetUseType(SIMPLE_USE)  
  local phys = self:GetPhysicsObject() 
  phys:EnableMotion(false)  
  self.activePlates = {}
end   

function ENT:StartTouch(e)
	if e:GetClass() == "plate_pressed" then
		if e.alreadyUsed == nil then
			local creator = e.lastPickup
			creator:OnPlateCreated()
			e.alreadyUsed = true
			e:Remove() 
		end
	end
end

