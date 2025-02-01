module("modules.logic.season.model.Activity104EquipTagModel", package.seeall)

slot0 = class("Activity104EquipTagModel", BaseModel)
slot0.NoTagId = -1

function slot0.clear(slot0)
	slot0._desc2IdMap = nil
	slot0._optionsList = nil
	slot0._curTag = nil
	slot0._curTagStr = nil
end

function slot0.init(slot0, slot1)
	slot0._curTag = uv0.NoTagId
	slot0._curTagStr = tostring(slot0._curTag)
	slot0.activityId = slot1

	slot0:initConfig()
end

function slot0.initConfig(slot0)
	slot0._index2IdMap = {}
	slot0._optionsList = {}
	slot0._index2IdMap[0] = uv0.NoTagId

	table.insert(slot0._optionsList, luaLang("common_all"))

	slot3 = {}

	if SeasonConfig.instance:getSeasonTagDict(slot0.activityId) then
		for slot7, slot8 in pairs(slot1) do
			table.insert(slot3, slot8)
		end
	end

	table.sort(slot3, function (slot0, slot1)
		return slot0.order < slot1.order
	end)

	slot4 = 1

	for slot8, slot9 in ipairs(slot3) do
		slot0._index2IdMap[slot4] = slot9.id

		table.insert(slot0._optionsList, slot9.desc)

		slot4 = slot4 + 1
	end
end

function slot0.getOptions(slot0)
	return slot0._optionsList
end

function slot0.getSelectIdByIndex(slot0, slot1)
	return slot0._index2IdMap[slot1]
end

function slot0.isCardNeedShow(slot0, slot1)
	if slot0._curTag == uv0.NoTagId or not slot0._curTag then
		return true
	end

	for slot6, slot7 in pairs(string.split(slot1, "#")) do
		if slot0._curTagStr == slot7 then
			return true
		end
	end

	return false
end

function slot0.selectTagIndex(slot0, slot1)
	if slot0:getSelectIdByIndex(slot1) ~= nil then
		slot0._curTag = slot2
		slot0._curTagStr = tostring(slot0._curTag)
	else
		logNormal("tagIndex = " .. tostring(slot1) .. " not found!")
	end
end

function slot0.getCurTagId(slot0)
	return slot0._curTag
end

return slot0
