AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
 
include("shared.lua")

function ENT:Initialize() 
	self:SetModel( "models/press-plates/workbench_smallcol.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )     
	self:SetMoveType( MOVETYPE_VPHYSICS )   
	self:SetSolid( SOLID_VPHYSICS )          
	self:SetUseType(SIMPLE_USE)  
  local phys = self:GetPhysicsObject() 
  self:SetUpModels() 
  self:GetPhysicsObject():EnableMotion(false)
end 

function ENT:SetUpModels() --Used to peice together the models
	local press = ents.Create("press_body")
	press:SetPos(self:GetPos() + Vector(0,0,39.35))
	press:SetAngles(self:GetAngles()) 
	--press:SetParent(self) 
	press:Spawn() 
	self._press = press
	local head = ents.Create("press_head")
	head:SetPos(press:GetPos() - Vector(0,0,2))
	head:SetAngles(press:GetAngles())
	head:SetParent(press)
	head:Spawn()
	self._head = head
	local handle = ents.Create("press_handle")
	handle:SetPos(press:GetPos() + Vector(0,0,24) + (press:GetAngles():Forward() * -1.9))
	handle:SetAngles(press:GetAngles())
	handle:SetParent(self)
	handle:Spawn()     
	self._handle = handle
end
function ENT:Think()
	self._press:SetPos(self:GetPos() + Vector(0,0,39.35))
	self._press:SetAngles(self:GetAngles()) 
	local handle = self._handle
	if handle:GetPressure() > 0 then
		local amount = handle:GetPressure() - (1 * FrameTime())
		if amount < 0 then  
			if handle:GetPressure() ~= 0 then
				handle:SetPressure(0)
			end 
		else 
			handle:SetPressure(amount) 
		end
	end 
	if self._head:GetPressure() ~= handle:GetPressure() then 
		self._head:SetPressure(handle:GetPressure())  
		self._head:SetPos(self._press:GetPos() - Vector(0,0,Lerp(self._head:GetPressure() , 0 , 13) + 2))
	end
end  
function ENT:OnHandlePressed(h)  
	if self._press.hasPlate then
		if h:GetPressure() < 1 then 
			local amount = h:GetPressure() + PPC.PressureRequired
			if amount >= 1 then
				--Goal accheived 
				h:SetPressure(0)
				self._press:PlatePressed()
			else
				h:SetPressure(amount)
			end
		end 
	end
end
function ENT:OnRemove()
	self._press:Remove()
end