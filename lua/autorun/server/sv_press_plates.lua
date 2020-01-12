include("config_press_plates.lua")
local p = FindMetaTable("Player")
 
 hook.Add("ShouldCollide" , "stop_plates_collide" , function(e1 , e2)
 		if e1:GetClass() == "plate_unpressed" and e2:GetClass() == "plate_unpressed" then
 			return false
 		end
 		if e1:GetClass() == "plate_pressed" and e2:GetClass() == "plate_pressed" then
 			return false
 		end
 		 if e1:GetClass() == "plate_unpressed" and e2:GetClass() == "plate_pressed" then
 			return false
 		end
 		if e1:GetClass() == "plate_pressed" and e2:GetClass() == "plate_unpressed" then
 			return false
 		end
 		--print(e1:GetClass() , e2:GetClass())
end)


function p:OnPlateCreated()
	--Knock time off there setence (Should now work with different versions of dankrp) 
	if not self:isArrested() then return end 
	if timer.TimeLeft(self:UniqueID().."jailtimer") == nil then
		timer.Adjust(self:SteamID64().. "jailtimer", timer.TimeLeft(self:SteamID64() .. "jailtimer") - PPC.SentanceReduction, 1, function()
	    if IsValid(self) then self:unArrest() end
	    if arrestedPlayers ~= nil then
	    	arrestedPlayers[self:SteamID()] = nil 
	    end
	  end)  
	  umsg.Start("GotArrested", self) 
	    umsg.Float(timer.TimeLeft(self:SteamID64() .. "jailtimer"))
	  umsg.End()
	 else
		timer.Adjust(self:UniqueID().. "jailtimer", timer.TimeLeft(self:UniqueID() .. "jailtimer") - PPC.SentanceReduction, 1, function()
	    if IsValid(self) then self:unArrest() end
	    if arrestedPlayers ~= nil then
	    	arrestedPlayers[self:SteamID()] = nil 
	    end
	  end)  
	  umsg.Start("GotArrested", self) 
	    umsg.Float(timer.TimeLeft(self:UniqueID() .. "jailtimer"))
	  umsg.End()
	 end 
end  

hook.Add("PlayerSay" , "SavePressPlates" , function(ply , text)
	if string.lower(text) == "!savepressplates" then
		local hasPermision = false
		for k ,v in pairs(PPC.permision) do
			if ply:GetUserGroup() == v then
				hasPermision = true
				break
			end
		end
		if not hasPermision then return end
		local tables = ents.FindByClass("table_press")
		local unpressed = ents.FindByClass("table_plate_unpressed")
		local pressed = ents.FindByClass("table_plate_pressed")
		local OBJECTS = {}
		OBJECTS.press = {}
		OBJECTS.unpressed = {}
		OBJECTS.pressed = {}
		for k ,v in pairs(tables) do
			local b = {}
			b.pos = {x=v:GetPos().x,y=v:GetPos().y,z=v:GetPos().z} 
			b.ang = {p=v:GetAngles().pitch,y=v:GetAngles().yaw,r=v:GetAngles().roll}
			table.insert(OBJECTS.press , b)  
		end 
		for k ,v in pairs(unpressed) do
			local b = {}
			b.pos = {x=v:GetPos().x,y=v:GetPos().y,z=v:GetPos().z} 
			b.ang = {p=v:GetAngles().pitch,y=v:GetAngles().yaw,r=v:GetAngles().roll}
			table.insert(OBJECTS.unpressed , b)  
		end 
		for k ,v in pairs(pressed) do
			local b = {}
			b.pos = {x=v:GetPos().x,y=v:GetPos().y,z=v:GetPos().z} 
			b.ang = {p=v:GetAngles().pitch,y=v:GetAngles().yaw,r=v:GetAngles().roll}
			table.insert(OBJECTS.pressed , b)  
		end 
		local plate_table_json = util.TableToJSON(OBJECTS)
		file.Write("press_plates.txt", plate_table_json)
		ply:ChatPrint("PRESS PLATES SAVED!")
	end
	if string.lower(text) == "!unsavepressplates" then
		local hasPermision = false
		for k ,v in pairs(PPC.permision) do
			if ply:GetUserGroup() == v then 
				hasPermision = true
				break
			end 
		end 
		if not hasPermision then return end
		file.Write("press_plates.txt", "")
		ply:ChatPrint("PRESS PLATES UNSAVED!")
	end
end)

hook.Add( "InitPostEntity", "LoadPressPlates", function()
	local data = file.Read("press_plates.txt" , false)
	if data == "" or data == nil then return end
	local dataTable = util.JSONToTable(data)
	for k , v in pairs(dataTable.press) do
		local t = ents.Create("table_press")
		t:SetPos(Vector(v.pos.x , v.pos.y , v.pos.z))
		t:SetAngles(Angle(v.ang.p , v.ang.y , v.ang.r))
		t:Spawn() 
	end
	for k , v in pairs(dataTable.unpressed) do
		local t = ents.Create("table_plate_unpressed")
		t:SetPos(Vector(v.pos.x , v.pos.y , v.pos.z))
		t:SetAngles(Angle(v.ang.p , v.ang.y , v.ang.r))
		t:Spawn()  
	end
	for k , v in pairs(dataTable.pressed) do
		local t = ents.Create("table_plate_pressed")
		t:SetPos(Vector(v.pos.x , v.pos.y , v.pos.z))
		t:SetAngles(Angle(v.ang.p , v.ang.y , v.ang.r))
		t:Spawn() 
	end
end )