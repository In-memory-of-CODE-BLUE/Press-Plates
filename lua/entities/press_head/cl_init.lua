include("shared.lua")


function ENT:Draw()   
	--self:DrawModel()
end

function ENT:Think()
	if self.csm ~= nil and IsValid(self.csm) then
		self.csm:SetPos(LerpVector(5*FrameTime(), self.csm:GetPos(), self:GetPos()))
		self.csm:SetAngles(self:GetAngles())    
	end
end

function ENT:Initialize()  
	self.csm = ClientsideModel(self:GetModel())
	self.csm:SetPos(self:GetPos())
end 

function ENT:OnRemove()
	self.csm:Remove()
end
 
 
