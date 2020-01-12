include("shared.lua")

function ENT:Draw()  
	--self:DrawModel()
end  

function ENT:Think()
	if self.smooth_pressure == nil then self.smooth_pressure = 0 end 
	if self.csm == nil or not IsValid(self.csm) then return end 
	local ang = Angle(0,0,0)
	if IsValid(self:GetParent()) then 
		ang = self:GetParent():GetAngles()
	end
	self.smooth_pressure = Lerp(5 * FrameTime() , self.smooth_pressure , self:GetPressure())  
	ang:RotateAroundAxis(ang:Right(),Lerp(self.smooth_pressure , 0 , 45))
	self.csm:SetAngles(ang)
	self.csm:SetPos(self:GetPos()) 
end
 
function ENT:Initialize() 
	self:UseClientSideAnimation() 
	self.csm = ClientsideModel("models/press-plates/press_handle.mdl")
end 

function ENT:OnRemove()
	self.csm:Remove()
end
  
