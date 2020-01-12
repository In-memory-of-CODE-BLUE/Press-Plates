include("shared.lua")

surface.CreateFont( "TABLE_PRESS", {
	font = "Roboto Lt",
	extended = false,
	size = 100,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

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
		draw.SimpleText("Place an unpressed plate here and mash 'e' on the handle","TABLE_PRESS",0,60, Color(255,255,255,self.alpha),1,1)
	cam.End3D2D()
	local ang = self:GetAngles()
	ang:RotateAroundAxis(self:GetAngles():Right(),90)
	ang:RotateAroundAxis(self:GetAngles():Forward(),90) 
	cam.Start3D2D(self:GetPos() + (ang:Up() *22.2) + (ang:Right() * -38.75), ang , 0.0175)
		draw.SimpleText("Place an unpressed plate here and mash 'e' on the handle","TABLE_PRESS",0,60, Color(255,255,255,self.alpha),1,1)
	cam.End3D2D()
	local ang = self:GetAngles()
	ang:RotateAroundAxis(self:GetAngles():Right(),180)
	ang:RotateAroundAxis(self:GetAngles():Forward(),90) 
	cam.Start3D2D(self:GetPos() + (ang:Up() *22.2) + (ang:Right() * -38.75), ang , 0.0175)
		draw.SimpleText("Place an unpressed plate here and mash 'e' on the handle","TABLE_PRESS",0,60, Color(255,255,255,self.alpha),1,1)
	cam.End3D2D()
	local ang = self:GetAngles()
	ang:RotateAroundAxis(self:GetAngles():Right(),180+90)
	ang:RotateAroundAxis(self:GetAngles():Forward(),90) 
	cam.Start3D2D(self:GetPos() + (ang:Up() *22.2) + (ang:Right() * -38.75), ang , 0.0175)
		draw.SimpleText("Place an unpressed plate here and mash 'e' on the handle","TABLE_PRESS",0,60, Color(255,255,255,self.alpha),1,1)
	cam.End3D2D()
end
 
 
