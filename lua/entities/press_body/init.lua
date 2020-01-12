AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
 
include("shared.lua")

function ENT:Initialize()
	self:SetModel( "models/press-plates/press.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )       
	self:SetMoveType( MOVETYPE_NONE )    
	self:SetSolid( SOLID_VPHYSICS )          
	self:SetUseType(SIMPLE_USE)   
  local phys = self:GetPhysicsObject() 
  if IsValid(phys) then
  	--phys:Wake()    
  end
  self.hasPlate = false
 
end
  
function ENT:StartTouch(e)  
	if e:GetClass() == "plate_unpressed" then   
		if self.hasPlate == false then  
			e.locked = true   
			self.hasPlate = true 
			self.plate = e
			e:SetPos(self:GetPos() + Vector(0,0,2))
			e:SetAngles(self:GetAngles()) 
			e:SetMoveType(MOVETYPE_NONE)  
			e:GetPhysicsObject():Sleep()
		end 
	end
end

function ENT:PlatePressed()  
	local plate = ents.Create("plate_pressed") 
	plate:SetPos(self.plate:GetPos() + Vector(0,0,2))
	plate:SetAngles(self.plate:GetAngles())
	self.plate:Remove()
	self.plate = nil
	self.hasPlate = false 
	plate:Spawn() 
end

hook.Add("ShouldCollide" , "StopPropFly" , function(e1 , e2)
	if e1:GetClass() == "press_head" and e2:GetClass() == "plate_pressed" then
		return false
	end 
	if e2:GetClass() == "press_head" and e1:GetClass() == "plate_pressed" then
		return false
	end
end)