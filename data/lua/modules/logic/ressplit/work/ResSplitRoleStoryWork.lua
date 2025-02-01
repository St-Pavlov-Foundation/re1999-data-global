module("modules.logic.ressplit.work.ResSplitRoleStoryWork", package.seeall)

slot0 = class("ResSplitRoleStoryWork", BaseWork)

function slot0.onStart(slot0, slot1)
	slot3 = {}

	for slot7, slot8 in pairs(ResSplitConfig.instance:getAppIncludeConfig()) do
		if slot8.heroStoryIds then
			for slot12, slot13 in pairs(slot8.heroStoryIds) do
				ResSplitModel.instance:addIncludeChapter(RoleStoryConfig.instance:getStoryById(slot13).chapterId)
			end
		end
	end

	slot0:onDone(true)
end

return slot0
