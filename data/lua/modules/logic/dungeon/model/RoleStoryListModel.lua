module("modules.logic.dungeon.model.RoleStoryListModel", package.seeall)

slot0 = class("RoleStoryListModel", ListScrollModel)

function slot0.markUnlockOrder(slot0)
	slot0.unlockOrderDict = {}
	slot2 = {}

	if RoleStoryConfig.instance:getStoryList() then
		for slot6, slot7 in ipairs(slot1) do
			if RoleStoryModel.instance:getMoById(slot7.id):isResidentTime() then
				slot0.unlockOrderDict[slot7.id] = slot8.hasUnlock and 1 or 0
			end
		end
	end
end

function slot0.refreshList(slot0)
	if #slot0._scrollViews == 0 then
		return
	end

	slot2 = {}

	if RoleStoryConfig.instance:getStoryList() then
		for slot6, slot7 in ipairs(slot1) do
			if RoleStoryModel.instance:getMoById(slot7.id):isResidentTime() then
				slot8.unlockOrder = slot0.unlockOrderDict[slot7.id] or 0

				table.insert(slot2, slot8)
			end
		end
	end

	table.sort(slot2, SortUtil.tableKeyUpper({
		"unlockOrder",
		"getRewardOrder",
		"order"
	}))
	slot0:setList(slot2)
end

slot0.instance = slot0.New()

return slot0
