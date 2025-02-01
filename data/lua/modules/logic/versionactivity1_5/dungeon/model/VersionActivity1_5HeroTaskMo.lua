module("modules.logic.versionactivity1_5.dungeon.model.VersionActivity1_5HeroTaskMo", package.seeall)

slot0 = pureTable("DispatchMo")

function slot0.initById(slot0, slot1)
	slot0.id = slot1
	slot0.config = VersionActivity1_5DungeonConfig.instance:getHeroTaskCo(slot0.id)
	slot0.subTaskCoList = VersionActivity1_5DungeonConfig.instance:getSubHeroTaskList(slot0.id)
	slot0.gainedReward = false
	slot0.subTaskGainedRewardList = nil
end

function slot0.initByCo(slot0, slot1)
	slot0.id = slot1.id
	slot0.config = slot1
	slot0.gainedReward = false
	slot0.subTaskGainedRewardList = nil
end

function slot0.updateGainedReward(slot0, slot1)
	slot0.gainedReward = slot1
end

function slot0.updateSubHeroTaskGainedReward(slot0, slot1)
	if slot0:isExploreTask() then
		return
	end

	slot0.subTaskGainedRewardList = {}

	if not slot1 then
		return
	end

	for slot5, slot6 in ipairs(slot1) do
		table.insert(slot0.subTaskGainedRewardList, slot6)
	end
end

function slot0.gainedSubHeroTaskId(slot0, slot1)
	table.insert(slot0.subTaskGainedRewardList, slot1)
end

function slot0.isExploreTask(slot0)
	return slot0.id == VersionActivity1_5DungeonEnum.ExploreTaskId
end

function slot0.isUnlock(slot0)
	return DungeonModel.instance:hasPassLevelAndStory(slot0.config.preEpisodeId)
end

function slot0.isFinish(slot0)
	if slot0:isExploreTask() then
		return false
	end

	for slot4, slot5 in ipairs(slot0.subTaskCoList) do
		if not VersionActivity1_5RevivalTaskModel.instance:checkSubHeroTaskIsFinish(slot5) then
			return false
		end
	end

	return true
end

function slot0.getSpriteName(slot0)
	if slot0.id == VersionActivity1_5DungeonEnum.ExploreTaskId then
		return slot0.isSelect and VersionActivity1_5DungeonEnum.ExploreTabImageSelect or VersionActivity1_5DungeonEnum.ExploreTabImageNotSelect
	end

	return slot0.isSelect and slot0.config.heroTabIcon .. 1 or slot0.config.heroTabIcon .. 2
end

function slot0.subTaskIsGainedReward(slot0, slot1)
	return slot0.subTaskGainedRewardList and tabletool.indexOf(slot0.subTaskGainedRewardList, slot1)
end

function slot0.getSubTaskFinishCount(slot0)
	for slot5, slot6 in ipairs(slot0.subTaskCoList) do
		if VersionActivity1_5RevivalTaskModel.instance:checkSubHeroTaskIsFinish(slot6) then
			slot1 = 0 + 1
		end
	end

	return slot1
end

function slot0.getSubTaskCount(slot0)
	return slot0.subTaskCoList and #slot0.subTaskCoList or 0
end

function slot0.getSubTaskCoList(slot0)
	return slot0.subTaskCoList
end

return slot0
