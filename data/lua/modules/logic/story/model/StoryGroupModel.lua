module("modules.logic.story.model.StoryGroupModel", package.seeall)

slot0 = class("StoryGroupModel", BaseModel)

function slot0.onInit(slot0)
	slot0._groupList = {}
end

function slot0.setGroupList(slot0, slot1)
	slot0._groupList = {}

	if slot1 then
		for slot5, slot6 in pairs(slot1) do
			slot7 = {}

			for slot11, slot12 in ipairs(slot6) do
				slot13 = StoryGroupMo.New()

				slot13:init(slot12)
				table.insert(slot7, slot13)
			end

			table.insert(slot0._groupList, slot7)
		end
	end
end

function slot0.getGroupList(slot0)
	return slot0._groupList
end

function slot0.getGroupListById(slot0, slot1)
	for slot5, slot6 in pairs(slot0._groupList) do
		for slot10, slot11 in pairs(slot6) do
			if slot11.id == slot1 then
				return slot6
			end
		end
	end

	return nil
end

slot0.instance = slot0.New()

return slot0
