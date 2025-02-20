module("modules.logic.versionactivity2_3.dudugu.model.ActDuDuGuModel", package.seeall)

slot0 = class("ActDuDuGuModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._curLvIndex = 0
end

function slot0.setCurLvIndex(slot0, slot1)
	slot0._curLvIndex = slot1
end

function slot0.getCurLvIndex(slot0)
	return slot0._curLvIndex or 0
end

function slot0.initData(slot0, slot1)
	RoleActivityModel.instance:initData(slot1)
end

function slot0.updateData(slot0, slot1)
	RoleActivityModel.instance:updateData(slot1)
end

function slot0.isLevelUnlock(slot0, slot1, slot2)
	return RoleActivityModel.instance:isLevelUnlock(slot1, slot2)
end

function slot0.isLevelPass(slot0, slot1, slot2)
	return RoleActivityModel.instance:isLevelPass(slot1, slot2)
end

function slot0.getNewFinishStoryLvl(slot0)
	if not RoleActivityConfig.instance:getStoryLevelList(VersionActivity2_3Enum.ActivityId.DuDuGu)[slot0._curLvIndex].id or slot3 <= 0 then
		return
	end

	if (slot0._curLvIndex + 1 <= #slot2 and slot2[slot0._curLvIndex + 1].id or 0) > 0 then
		slot5 = slot0:isLevelPass(slot1, slot3)
		slot6 = true

		if slot2[slot0._curLvIndex].afterStory > 0 then
			slot6 = StoryModel.instance:isStoryFinished(slot7)
		end

		if slot5 and not slot0:isLevelUnlock(slot1, slot4) and slot6 then
			slot0.newFinishStoryLvlId = slot3

			return slot0.newFinishStoryLvlId
		end
	end

	slot0.newFinishStoryLvlId = RoleActivityModel.instance:getNewFinishStoryLvl()

	return slot0.newFinishStoryLvlId
end

function slot0.clearNewFinishStoryLvl(slot0)
	RoleActivityModel.instance:clearNewFinishStoryLvl()

	return slot0.newFinishStoryLvlId
end

slot0.instance = slot0.New()

return slot0
