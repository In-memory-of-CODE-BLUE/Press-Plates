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
	self.locked = false
	self:SetCustomCollisionCheck(true)
  local phys = self:GetPhysicsObject() 
  if IsValid(phys) then
  	phys:Wake() 
  end      
  self:SetSubMaterial(1,"press-plates/plate_body")
end    
 
function ENT:Think()
	if self.timer <= CurTime() and not self.locked then
		self:Remove()
	end
end

function ENT:Use(act , call) 
	if self.locked then return false end
	call:PickupObject(self) 
end

function ENT:OnRemove() 
	if self.owner == nil or self.owner == NULL_ENTITY then return end
  self.owner:PlateDestoyed(self)
end