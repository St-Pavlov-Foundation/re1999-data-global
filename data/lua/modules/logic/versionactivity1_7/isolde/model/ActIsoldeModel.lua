module("modules.logic.versionactivity1_7.isolde.model.ActIsoldeModel", package.seeall)

slot0 = class("ActIsoldeModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0.newFinishStoryLvlId = nil
	slot0.newFinishFightLvlId = nil
	slot0.lvlDataDic = nil
end

function slot0.initData(slot0)
	slot1 = VersionActivity1_7Enum.ActivityId.Isolde

	if not slot0.lvlDataDic then
		slot0.lvlDataDic = {}

		for slot6, slot7 in ipairs(RoleActivityConfig.instance:getStoryLevelList(slot1)) do
			slot0.lvlDataDic[slot7.id] = {
				config = slot7,
				isUnlock = DungeonModel.instance:isUnlock(slot7),
				star = DungeonModel.instance:getEpisodeInfo(slot7.id) and slot8.star or 0
			}
		end

		for slot7, slot8 in ipairs(RoleActivityConfig.instance:getBattleLevelList(slot1)) do
			slot0.lvlDataDic[slot8.id] = {
				config = slot8,
				isUnlock = DungeonModel.instance:isUnlock(slot8),
				star = DungeonModel.instance:getEpisodeInfo(slot8.id) and slot9.star or 0
			}
		end
	end

	if not slot0.storyChapteId or not slot0.fightChapterId then
		slot2 = RoleActivityConfig.instance:getActivityEnterInfo(slot1)
		slot0.storyChapteId = slot2.storyGroupId
		slot0.fightChapterId = slot2.episodeGroupId
	end
end

function slot0.updateData(slot0)
	for slot4, slot5 in pairs(slot0.lvlDataDic) do
		slot5.isUnlock = DungeonModel.instance:isUnlock(slot5.config)
		slot5.star = DungeonModel.instance:getEpisodeInfo(slot4) and slot6.star or 0
	end
end

function slot0.isLevelUnlock(slot0, slot1)
	if not slot0.lvlDataDic[slot1] then
		logError(slot1 .. "data is null")

		return
	end

	return slot0.lvlDataDic[slot1].isUnlock
end

function slot0.isLevelPass(slot0, slot1)
	if not slot0.lvlDataDic[slot1] then
		logError(slot1 .. "data is null")

		return
	end

	return slot0.lvlDataDic[slot1].star > 0
end

function slot0.checkFinishLevel(slot0, slot1, slot2)
	if not slot0.lvlDataDic then
		return
	end

	if slot0.lvlDataDic[slot1] and slot3.star == 0 and slot2 > 0 then
		if slot3.config.chapterId == slot0.storyChapteId then
			slot0.newFinishStoryLvlId = slot1
		elseif slot4 == slot0.fightChapterId then
			slot0.newFinishFightLvlId = slot1
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

function slot0.setFirstEnter(slot0)
	slot0.firstEnter = true
end

function slot0.getFirstEnter(slot0)
	return slot0.firstEnter
end

function slot0.clearFirstEnter(slot0)
	slot0.firstEnter = nil
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
