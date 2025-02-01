module("modules.logic.dungeon.model.RoleStoryRewardListModel", package.seeall)

slot0 = class("RoleStoryRewardListModel", ListScrollModel)

function slot0.refreshList(slot0)
	slot2 = {}

	if RoleStoryModel.instance:getCurActStoryId() then
		for slot7, slot8 in ipairs(RoleStoryConfig.instance:getRewardList(slot1) or {}) do
			table.insert(slot2, {
				index = slot7,
				config = slot8
			})
		end
	end

	slot0:setList(slot2)
end

slot0.instance = slot0.New()

return slot0
