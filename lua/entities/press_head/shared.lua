ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName = "Press Head"
ENT.Spawnable = false 
ENT.Category = "Press Plates"

function ENT:SetupDataTables()
	self:NetworkVar("Float" , 0 ,"Pressure") 
end