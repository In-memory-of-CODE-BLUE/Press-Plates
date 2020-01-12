
//////////////////////////////////
/////PLEASE REAS THIS FIRST///////
//////////////////////////////////

 //**TIP** To make users use this addon please increase the jail time on your server to 10 minutes or more.
 //**TIP** Players who leave to avoid jail time will be re-arrested when they join back.

--To make a plate you need 3 things, the unpressed plates, a table press and a pressed plate table.
--Spawn them in around the map, You can have as many as you want, As long as you have at least one of each table (Otherwise its inmpossible to make a plate)
--To make a plate follow the instruction on the tables
--[SAVING] To save the tables just do !savepressplates in chat or !unsavepressplates to unsave them.
--Edit below to your liking. 

--**NOTE** Please make sure the press table is completely flat otherwise props may fall off it.
--**WARNING** PLEASE RESTART YOUR SERVER AFTER MOVING THE TABLES OTHERWISE THEY WILL NOT FUNCTION CORRECTLY, SO ONCE YOUR DONE SAVE THEM AND THEN RESTART THANKS!

PPC = {} 
PPC.permision = { --This is a list of ULX ranks that can use the chat commands to save or remove bars from the map (For permanent placement)
	"superadmin",
	"owner", 
	"developer"
}    
PPC.SentanceReduction = 15 --The number of seconds to take off someones setance (Jail time) for each plate they make
PPC.PressureRequired = 0.05 --The lower this number the faster you have to press E to press (The higher the easiers)
