include("shared.lua")

function ENT:Draw()  
	self:DrawModel()
end 
local ang = 0
function LerpColor(t , c1 , c2)
	local r = Lerp(t , c1.r , c2.r)
	local g = Lerp(t , c1.g , c2.g)
	local b = Lerp(t , c1.b , c2.b)
	local a = Lerp(t , c1.a , c2.a)
	return Color(r , g , b , a)
end
local c = Color(255,255,255)
hook.Add( "PreDrawHalos", "AddHalos", function() 
	if LocalPlayer():isArrested() then
		ang = ang + (4 * FrameTime())
		c = LerpColor((math.sin(ang) + 1 )/ 2 , Color(100,255,100) , Color(100,100,255))
		local e = {}
		for k ,v in pairs(ents.FindByClass( "plate_unpressed" )) do
			if v:GetPos():Distance(LocalPlayer():GetPos()) < 500 then
				table.insert(e , v)
			end 
		end
		halo.Add( e, c, 2,2,2,false,true) 
	end
end )
 
