module("modules.logic.story.model.StoryBgZoneModel", package.seeall)

slot0 = class("StoryBgZoneModel", BaseModel)

function slot0.onInit(slot0)
	slot0._zoneList = {}
end

function slot0.setZoneList(slot0, slot1)
	slot0._zoneList = {}

	if slot1 then
		for slot5, slot6 in ipairs(slot1) do
			slot7 = StoryBgZoneMo.New()

			slot7:init(slot6)
			table.insert(slot0._zoneList, slot7)
		end
	end

	slot0:setList(slot0._zoneList)
end

function slot0.getZoneList(slot0)
	return slot0._zoneList
end

function slot0.getBgZoneByPath(slot0, slot1)
	slot6 = ".jpg"
	slot7 = ""

	for slot6, slot7 in pairs(slot0._zoneList) do
		if slot7.path == string.gsub(string.gsub(string.gsub(slot1, "_zone", ""), ".png", ""), slot6, slot7) .. "_zone.png" then
			return slot7
		end
	end

	return nil
end

function slot0.getRightBgZonePath(slot0, slot1)
	if slot0:getBgZoneByPath(slot1) then
		return slot2.path
	end

	return slot1
end

slot0.instance = slot0.New()

return slot0
