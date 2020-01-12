ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName = "Press Handle"
ENT.Spawnable = false 
ENT.Category = "Press Plates"
 
function ENT:SetupDataTables()
	self:NetworkVar("Float" , 0 ,"Pressure") 
end