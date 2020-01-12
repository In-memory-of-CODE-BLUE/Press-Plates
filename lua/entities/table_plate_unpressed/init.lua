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
function ENT:Use(act , call)
	if not call:isArrested() then
		call:ChatPrint("This job is only for people who are arrested.")
		return 
	end  
	if table.Count(self.activePlates) < maxPlates then
		local p = ents.Create("plate_unpressed")
		p:SetPos(self:GetPos() + (self:GetAngles():Up() * 45)) 
		local a = self:GetAngles()
		a:RotateAroundAxis(self:GetAngles():Right() , 180)
		p:SetAngles(a)  
		p:Spawn()
		local id = -1 
		for i = 1 , maxPlates do
			if self.activePlates[i] == nil then
				id = i
				break
			end
		end
		p.owner = self
		p.id = id
		self.activePlates[id] = p
	else 
		call:ChatPrint("There are to many plates around the area, Please use them first before getting more!")
	end
end

function ENT:PlateDestoyed(p)
	self.activePlates[p.id] = nil
end

