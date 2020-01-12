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
		draw.SimpleText("Place pressed plates here to reduce your sentence!","TABLE_PRESS",0,60, Color(255,255,255,self.alpha),1,1)
	cam.End3D2D()
	local ang = self:GetAngles()
	ang:RotateAroundAxis(self:GetAngles():Right(),90)
	ang:RotateAroundAxis(self:GetAngles():Forward(),90) 
	cam.Start3D2D(self:GetPos() + (ang:Up() *22.2) + (ang:Right() * -38.75), ang , 0.0175)
		draw.SimpleText("Place pressed plates here to reduce your sentence!","TABLE_PRESS",0,60, Color(255,255,255,self.alpha),1,1)
	cam.End3D2D()
	local ang = self:GetAngles()
	ang:RotateAroundAxis(self:GetAngles():Right(),180)
	ang:RotateAroundAxis(self:GetAngles():Forward(),90) 
	cam.Start3D2D(self:GetPos() + (ang:Up() *22.2) + (ang:Right() * -38.75), ang , 0.0175)
		draw.SimpleText("Place pressed plates here to reduce your sentence!","TABLE_PRESS",0,60, Color(255,255,255,self.alpha),1,1)
	cam.End3D2D()
	local ang = self:GetAngles()
	ang:RotateAroundAxis(self:GetAngles():Right(),180+90) 
	ang:RotateAroundAxis(self:GetAngles():Forward(),90) 
	cam.Start3D2D(self:GetPos() + (ang:Up() *22.2) + (ang:Right() * -38.75), ang , 0.0175)
		draw.SimpleText("Place pressed plates here to reduce your sentence!","TABLE_PRESS",0,60, Color(255,255,255,self.alpha),1,1)
	cam.End3D2D()
end

function ENT:Initialize()
	local csm = {}
	self.reges = {}
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
				t:SetPos(offset + (self:GetAngles():Forward() *  (i * 10)) + (self:GetAngles():Right() *  (y * 19)) + (self:GetAngles():Up() * xOffset))    
				if a == stack then  
					local reg = ""
					for i = 1 , 2 do
						local char = math.random(65,90)
						local c = string.char(char)
						reg = reg..c 
					end 
					for i = 1 , 2 do
						reg = reg..math.random(0,9) 
					end 
					reg = reg.."  " 
					for i = 1 , 3 do
						local char = math.random(65,90)
						local c = string.char(char)
						reg = reg..c
					end  
					t.reg = reg  
					t.RenderOverride = function(self)  
	 					self:DrawModel()
						local ang = self:GetAngles()
						ang:RotateAroundAxis(ang:Up(),90)
						cam.Start3D2D(self:GetPos() + (ang:Up() * 0.50),ang,0.035)
							draw.SimpleText(self.reg,"PP_REG",0,25,Color(0,0,0,255),1,1)
						cam.End3D2D()
					end
				end    
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
 
