module("modules.logic.roleactivity.model.RoleActivityModel", package.seeall)

slot0 = class("RoleActivityModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0.newFinishStoryLvlId = nil
	slot0.newFinishFightLvlId = nil
	slot0.lvlDataDic = {}
	slot0.recordFightIndex = {}
end

function slot0.initData(slot0, slot1)
	if not slot0.lvlDataDic[slot1] then
		slot0.lvlDataDic[slot1] = {}

		for slot6, slot7 in ipairs(RoleActivityConfig.instance:getStoryLevelList(slot1)) do
			slot0:_createLevelMo(slot1, slot7)
		end

		for slot7, slot8 in ipairs(RoleActivityConfig.instance:getBattleLevelList(slot1)) do
			slot0:_createLevelMo(slot1, slot8)
		end
	end
end

function slot0._createLevelMo(slot0, slot1, slot2)
	slot3 = RoleActivityLevelMo.New()

	slot3:init(slot2)

	slot0.lvlDataDic[slot1][slot2.id] = slot3
end

function slot0.updateData(slot0, slot1)
	for slot6, slot7 in pairs(slot0.lvlDataDic[slot1]) do
		slot7:update()
	end
end

function slot0.isLevelUnlock(slot0, slot1, slot2)
	if not slot0.lvlDataDic[slot1][slot2] then
		logError(slot2 .. "data is null")

		return
	end

	return slot3.isUnlock
end

function slot0.isLevelPass(slot0, slot1, slot2)
	if not slot0.lvlDataDic[slot1][slot2] then
		logError(slot2 .. "data is null")

		return
	end

	return slot3.star > 0
end

function slot0.checkFinishLevel(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot0.lvlDataDic) do
		if slot7[slot1] then
			slot9 = RoleActivityConfig.instance:getActivityEnterInfo(slot6)

			if slot7[slot1] and slot8.star == 0 and slot2 > 0 and slot8.config.chapterId == slot9.storyGroupId then
				slot0.newFinishStoryLvlId = slot1

				break
			end

			if slot10 == slot9.episodeGroupId then
				slot0.newFinishFightLvlId = slot1
			end

			break
		end
	end
end

function slot0.getNewFinishStoryLvl(slot0)
	return slot0.newFinishStoryLvlId
end

function slot0.clearNewFinishStoryLvl(slot0)
	slot0.newFinishStoryLvlId = nil
end

function slot0.getNewFinishFightLvl(slot0)
	return slot0.newFinishFightLvlId
end

function slot0.clearNewFinishFightLvl(slot0)
	slot0.newFinishFightLvlId = nil
end

function slot0.setEnterFightIndex(slot0, slot1)
	slot0.recordFightIndex = slot1
end

function slot0.getEnterFightIndex(slot0)
	slot0.recordFightIndex = nil

	return slot0.recordFightIndex
end

slot0.instance = slot0.New()

return slot0
