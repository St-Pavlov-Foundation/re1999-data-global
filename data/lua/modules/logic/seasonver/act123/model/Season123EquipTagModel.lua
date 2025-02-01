module("modules.logic.seasonver.act123.model.Season123EquipTagModel", package.seeall)

slot0 = class("Season123EquipTagModel", BaseModel)
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
	if not Season123Model.instance:getCurSeasonId() then
		return
	end

	slot0._index2IdMap = {}
	slot0._optionsList = {}
	slot0._index2IdMap[0] = uv0.NoTagId

	table.insert(slot0._optionsList, luaLang("common_all"))

	slot4 = {}

	if Season123Config.instance:getSeasonTagDesc(slot1) then
		for slot8, slot9 in pairs(slot2) do
			table.insert(slot4, slot9)
		end
	end

	table.sort(slot4, function (slot0, slot1)
		return slot0.order < slot1.order
	end)

	slot5 = 1

	for slot9, slot10 in ipairs(slot4) do
		slot0._index2IdMap[slot5] = slot10.id

		table.insert(slot0._optionsList, slot10.desc)

		slot5 = slot5 + 1
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
