include("shared.lua")

surface.CreateFont( "PP_REG", {
	font = "Roboto Cn",
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
	local ang = self:GetAngles()
	ang:RotateAroundAxis(ang:Up(),90)
	cam.Start3D2D(self:GetPos() + (ang:Up() * 0.50),ang,0.035)
		draw.SimpleText(self.reg,"PP_REG",0,25,Color(0,0,0,255),1,1)
	cam.End3D2D()
end
 
function ENT:Initialize()
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
	self.reg = reg
end
 
 
