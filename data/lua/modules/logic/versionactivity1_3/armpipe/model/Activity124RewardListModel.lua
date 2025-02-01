module("modules.logic.versionactivity1_3.armpipe.model.Activity124RewardListModel", package.seeall)

slot0 = class("Activity124RewardListModel", ListScrollModel)

function slot0.init(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in ipairs(Activity124Config.instance:getEpisodeList(slot1)) do
		slot9 = Activity124RewardMO.New()

		slot9:init(slot8)
		table.insert(slot2, slot9)
	end

	table.sort(slot2, uv0.sortMO)
	slot0:setList(slot2)
end

function slot0.sortMO(slot0, slot1)
	if slot0:isHasReard() ~= slot1:isHasReard() then
		return slot2
	end

	if slot0:isReceived() ~= slot1:isReceived() then
		return slot5
	end

	if slot0.id ~= slot1.id then
		return slot0.id < slot1.id
	end
end

slot0.instance = slot0.New()

return slot0
