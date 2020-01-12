include("shared.lua")


function ENT:Draw()   
	self:DrawModel()
	if self.alpha == nil then self.alpha = 0 end
	if LocalPlayer():GetPos():Distance(self:GetPos()) < 100 then
		self.alpha = Lerp(10 * FrameTime() , self.alpha , 255)
	else
		self.alpha = Lerp(10 * FrameTime() , self.alpha , 0)
	end
	local ang = self:GetAngles()
	ang:RotateAroundAxis(self:GetAngles():Forward(),90) 
	cam.Start3D2D(self:GetPos() + (ang:Up() *22.2) + (ang:Right() * -38.75), ang , 0.0175)
		draw.SimpleText("Pressed 'E' to get an unpressed plate, Then take it to the press","TABLE_PRESS",0,60, Color(255,255,255,self.alpha),1,1)
	cam.End3D2D()
	local ang = self:GetAngles()
	ang:RotateAroundAxis(self:GetAngles():Right(),90)
	ang:RotateAroundAxis(self:GetAngles():Forward(),90) 
	cam.Start3D2D(self:GetPos() + (ang:Up() *22.2) + (ang:Right() * -38.75), ang , 0.0175)
		draw.SimpleText("Pressed 'E' to get an unpressed plate, Then take it to the press","TABLE_PRESS",0,60, Color(255,255,255,self.alpha),1,1)
	cam.End3D2D()
	local ang = self:GetAngles()
	ang:RotateAroundAxis(self:GetAngles():Right(),180)
	ang:RotateAroundAxis(self:GetAngles():Forward(),90) 
	cam.Start3D2D(self:GetPos() + (ang:Up() *22.2) + (ang:Right() * -38.75), ang , 0.0175)
		draw.SimpleText("Pressed 'E' to get an unpressed plate, Then take it to the press","TABLE_PRESS",0,60, Color(255,255,255,self.alpha),1,1)
	cam.End3D2D()
	local ang = self:GetAngles()
	ang:RotateAroundAxis(self:GetAngles():Right(),180+90) 
	ang:RotateAroundAxis(self:GetAngles():Forward(),90) 
	cam.Start3D2D(self:GetPos() + (ang:Up() *22.2) + (ang:Right() * -38.75), ang , 0.0175)
		draw.SimpleText("Pressed 'E' to get an unpressed plate, Then take it to the press","TABLE_PRESS",0,60, Color(255,255,255,self.alpha),1,1)
	cam.End3D2D()
end

function ENT:Initialize()
	local csm = {}
	local offset = self:GetPos() + Vector(0,0,39) + (self:GetAngles():Forward() * -15) + (self:GetAngles():Right() * -9)  
	for i =0 , 3 do   
		for y = 0 , 1 do
			local xOffset = 0
			local stack = math.random(1,10)
			for a = 1 , stack do
				local t = ClientsideModel("models/press-plates/plate.mdl") 
				local r = math.random(1,2)  
				if r == 2 then 
					t:SetAngles(self:GetAngles()) 
				else
					local ang = self:GetAngles()
					ang:RotateAroundAxis(self:GetAngles():Up(),180)
					t:SetAngles(ang)  
				end 
				t:SetSubMaterial(1,"press-plates/plate_body")    
				t:SetPos(offset + (self:GetAngles():Forward() *  (i * 10)) + (self:GetAngles():Right() *  (y * 19)) + (self:GetAngles():Up() * xOffset))    
				t:Spawn()  
				t:SetParent(self)
				table.insert(csm , t)  
				xOffset = xOffset  + 0.37   
			end
		end
	end 
	self.csm = csm
end
 
function ENT:OnRemove()
	for k ,v in pairs(self.csm) do
		v:Remove()
	end
end 
 
