module("modules.logic.player.model.IconTipModel", package.seeall)

slot0 = class("IconTipModel", BaseModel)

function slot0.onInit(slot0)
	slot0._iconslist = {}
end

function slot0.setIconList(slot0, slot1)
	slot0._iconslist = {}
	slot4 = {}
	slot5 = {}

	for slot9, slot10 in pairs(ItemModel.instance:getItemList()) do
		if lua_item.configDict[slot10.id] and slot11.subType == ItemEnum.SubType.Portrait and not ({})[slot10.id] then
			slot12 = {
				id = slot11.id,
				icon = slot11.icon,
				name = slot11.name,
				isused = slot11.id == slot1 and 1 or 0,
				effect = slot11.effect
			}

			if not slot5[slot11.effect] then
				slot13 = {}
				slot17 = "#"

				for slot17, slot18 in ipairs(string.split(slot11.effect, slot17)) do
					table.insert(slot13, tonumber(slot18) or 0)
				end

				slot5[slot11.effect] = slot13
			end

			for slot18 = #slot13, 1, -1 do
				if false then
					slot3[slot13[slot18]] = true
				elseif slot13[slot18] == slot11.id then
					slot14 = true
				end
			end

			slot4[slot11.id] = slot12
		end
	end

	for slot9, slot10 in pairs(slot4) do
		if not slot3[slot9] then
			table.insert(slot0._iconslist, slot10)
		end
	end

	slot0:setIconsList()
end

function slot0.setSelectIcon(slot0, slot1)
	slot0._selectIcon = slot1

	PlayerController.instance:dispatchEvent(PlayerEvent.SelectPortrait, slot1)
end

function slot0.getSelectIcon(slot0)
	return slot0._selectIcon
end

function slot0.setIconsList(slot0)
	IconListModel.instance:setIconList(slot0._iconslist)
end

slot0.instance = slot0.New()

return slot0
