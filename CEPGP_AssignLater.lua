local addonName, addon = ...



--[[
	

CEPGP_handleLoot(event, arg1, arg2)



]]--

local function SplitMessage(msg)
	local returnTable = {}
	local t = {}                 
	local i = 0
	while true do
		local subText
		i = string.find(msg, "%[[%a+%s']+%]", i+1)  
		if i == nil then break end
		subText = string.match(msg, "%[[%a+%s']+%]", i)
		subText = string.match(subText, "[%a+%s']+")
		table.insert(returnTable, subText)
	end
	return returnTable
end

local function AL_CEPGP_LootFrame_Update(itemTable)
	local items = {}
	local count = #itemTable	
	local itemTexture, itemName, itemStackCount, itemRarity, itemLink
	for index, item in pairs(itemTable) do
		itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(item)

		if itemName ~= "nil" then			
			items[index] = {}
			items[index][1] = itemTexture
			items[index][2] = itemName
			items[index][3] = itemRarity
			items[index][4] = itemLink
			local link = itemLink
			local itemString = string.find(link, "item[%-?%d:]+");
			itemString = strsub(link, itemString, string.len(link)-string.len(itemName)-6);  -- sould end in: item:4306::::::::[8]60:::::::[7]
			items[index][5] = itemString;
			items[index][6] = index;
			items[index][7] = itemStackCount;
		else
			message("error")
		end
	end	

	for k, v in pairs(items) do -- k = loot slot number, v is the table result
		if (UnitInRaid("player") or CEPGP_Info.Debug) and (v[3] >= CEPGP.Loot.MinThreshold) or (CEPGP_inOverride(v[2]) or CEPGP_inOverride(v[4])) then
			if CEPGP_isML() == 0 then
				CEPGP_frame:Show();
				CEPGP_mode = "loot";
				CEPGP_toggleFrame("CEPGP_loot");
			end
			break;
		end
	end
	CEPGP_populateFrame(items);
end

local function bla()

	if CEPGP_ElvUI then
		local numLootItems = GetNumLootItems();
		local texture, item, quantity, quality;
		for index = 1, numLootItems do
			if ( index <= numLootItems ) then	
				texture, item, quantity, _, quality = GetLootSlotInfo(index);
				if (tostring(GetLootSlotLink(index)) ~= "nil" or CEPGP_inOverride(item)) and item ~= nil then
					items[index-count] = {};
					items[index-count][1] = texture;
					items[index-count][2] = item;
					items[index-count][3] = quality;
					items[index-count][4] = GetLootSlotLink(index);
					local link = GetLootSlotLink(index);
					local itemString = string.find(link, "item[%-?%d:]+");
					itemString = strsub(link, itemString, string.len(link)-string.len(item)-6);
					items[index-count][5] = itemString;
					items[index-count][6] = index;
					items[index-count][7] = quantity;
				else
					count = count + 1;
				end
			end
		end
	else
		local numLootItems = LootFrame.numLootItems;
		local texture, item, quantity, quality;
		for index = 1, numLootItems do
			local slot = index;
			if ( slot <= numLootItems ) then	
				if (LootSlotHasItem(slot)) then
					texture, item, quantity, _, quality = GetLootSlotInfo(slot);
					if tostring(GetLootSlotLink(slot)) ~= "nil" or CEPGP_inOverride(item) then
						items[index-count] = {};
						items[index-count][1] = texture;
						items[index-count][2] = item;
						items[index-count][3] = quality;
						items[index-count][4] = GetLootSlotLink(slot);
						local link = GetLootSlotLink(index);
						local itemString = string.find(link, "item[%-?%d:]+");
						itemString = strsub(link, itemString, string.len(link)-string.len(item)-6);
						items[index-count][5] = itemString;
						items[index-count][6] = slot;
						items[index-count][7] = quantity;
					else
						count = count + 1;
					end
				end
			end
		end
	end
	for k, v in pairs(items) do -- k = loot slot number, v is the table result
		if (UnitInRaid("player") or CEPGP_Info.Debug) and (v[3] >= CEPGP.Loot.MinThreshold) or (CEPGP_inOverride(v[2]) or CEPGP_inOverride(v[4])) then
			if CEPGP_isML() == 0 then
				CEPGP_frame:Show();
				CEPGP_mode = "loot";
				CEPGP_toggleFrame("CEPGP_loot");
			end
			break;
		end
	end
	CEPGP_populateFrame(items);
end

local function LootLinkTest(nameTable)
	print(#nameTable)
	for _, name in pairs(nameTable) do
		print(name)
	itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(name)
		
	--
	--print("itemName", itemName)
	--print("itemLink", itemLink)
	--print("itemRarity", itemRarity)
	--print("itemLevel", itemLevel)
	--print("itemMinLevel", itemMinLevel)
	--print("itemType", itemType)
	--print("itemSubType", itemSubType)
	--print("itemStackCount", itemStackCount)
	--print("itemEquipLoc", itemEquipLoc)
	--print("itemTexture", itemTexture)
	--print("itemSellPrice", itemSellPrice)
--
--
	--		
	--local item = "Fractured' Canine"
	--local link = "|cff9d9d9d|Hitem:3299::::::::20:257::::::|h[Fractured' Canine]|h|r"
	--
	--local itemString = string.find(link, "item[%-?%d:]+")
	--print(itemString)
	--
	--itemString = strsub(link, itemString, string.len(link)-string.len(item)-6);
	--print(itemString)



	end
end


StaticPopupDialogs["EXAMPLE_HELLOWORLD"] = {
	text = "Distribute Buff EP now?",
	button1 = "Yes",
	button2 = "No",
	OnAccept = function()
		AssignRaidBuffEP()
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
	preferredIndex = 3,
  }


SLASH_CEPGPAL1 = '/cepal'
SLASH_CEPGPAL2 = '/al'
function SlashCmdList.CEPGPAL(msg, editbox)   
	print("AssignLater")

	if msg and msg ~= "" then
		AL_CEPGP_LootFrame_Update(SplitMessage(msg))
		--LootLinkTest(SplitMessage(msg))
	else
		print("Please post Item do Assign")
	end
end