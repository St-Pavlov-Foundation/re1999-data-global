module("modules.logic.handbook.model.HandbookStoryListModel", package.seeall)

slot0 = class("HandbookStoryListModel", ListScrollModel)

function slot0.setStoryList(slot0, slot1, slot2)
	slot0.moList = {}

	for slot7, slot8 in ipairs(slot1) do
		if slot8.storyChapterId == slot2 and HandbookModel.instance:isStoryGroupUnlock(slot8.id) then
			slot9 = HandbookStoryMO.New()

			slot9:init(slot8.id, 0 + 1)
			table.insert(slot0.moList, slot9)
		end
	end

	slot0:setList(slot0.moList)
end

function slot0.getStoryList(slot0)
	if GameUtil.getTabLen(slot0.moList) > 0 then
		return slot0.moList
	end

	return nil
end

function slot0.clearStoryList(slot0)
	slot0:setList({})
end

slot0.instance = slot0.New()

return slot0
