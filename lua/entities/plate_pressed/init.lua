AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
 
include("shared.lua")

function ENT:Initialize() 
	self.timer = CurTime() + 25
	self:SetModel( "models/press-plates/plate.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )     
	self:SetMoveType( MOVETYPE_VPHYSICS )   
	self:SetSolid( SOLID_VPHYSICS )        
	self:SetUseType(SIMPLE_USE)  
		self:SetCustomCollisionCheck(true)
  local phys = self:GetPhysicsObject() 
  if IsValid(phys) then
  	phys:Wake() 
  end
  self.hasPlate = false
  self.plate = nil
end   
 
function ENT:Think()
	if self.timer <= CurTime() then
		self:Remove()
	end
end

function ENT:Use(act , call)
	call:PickupObject(self) 
	self.lastPickup = call
end

