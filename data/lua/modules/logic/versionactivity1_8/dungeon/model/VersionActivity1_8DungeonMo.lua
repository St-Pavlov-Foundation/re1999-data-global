module("modules.logic.versionactivity1_8.dungeon.model.VersionActivity1_8DungeonMo", package.seeall)

slot0 = pureTable("VersionActivity1_8DungeonMo", VersionActivityDungeonBaseMo)

function slot0.updateEpisodeId(slot0, slot1)
	slot2 = nil

	if slot1 then
		if DungeonConfig.instance:getEpisodeCO(slot1).chapterId == slot0.activityDungeonConfig.story2ChapterId or slot3.chapterId == slot0.activityDungeonConfig.story3ChapterId then
			while slot3.chapterId ~= slot0.activityDungeonConfig.story1ChapterId do
				slot3 = DungeonConfig.instance:getEpisodeCO(slot3.preEpisode)
			end
		end

		slot2 = slot3.id
	else
		slot3 = DungeonConfig.instance:getChapterEpisodeCOList(slot0.chapterId)

		if DungeonModel.instance:hasPassAllChapterEpisode(slot0.chapterId) then
			if slot0:getIsInSideMission() then
				slot2 = slot3[#slot3] and slot6.id
			end
		else
			slot5 = nil

			for slot9, slot10 in ipairs(slot3) do
				if (slot10 and DungeonModel.instance:getEpisodeInfo(slot10.id) or nil) and slot0:checkEpisodeUnLock(slot10) then
					slot2 = slot10.id
				end
			end
		end
	end

	if slot2 then
		slot0.episodeId = slot2
	else
		slot0.episodeId = VersionActivityDungeonBaseController.instance:getChapterLastSelectEpisode(slot0.chapterId)
	end
end

function slot0.getIsInSideMission(slot0)
	if not Activity157Model.instance:getIsSideMissionUnlocked() then
		return false
	end

	slot3 = DungeonConfig.instance:getChapterEpisodeCOList(slot0.chapterId)

	if not (slot3[#slot3] and slot4.id) then
		return slot1
	end

	slot6 = Activity157Model.instance:getActId()

	for slot12, slot13 in ipairs(VersionActivity1_8DungeonModel.instance:getElementCoList(VersionActivity1_8DungeonConfig.instance:getEpisodeMapConfig(slot5).id)) do
		if Activity157Config.instance:getMissionIdByElementId(slot6, slot13.id) and Activity157Config.instance:isSideMission(slot6, slot15) and not Activity157Model.instance:isFinishMission(Activity157Config.instance:getMissionGroup(slot6, slot15), slot15) then
			slot1 = true

			break
		end
	end

	return slot1
end

function slot0.checkEpisodeUnLock(slot0, slot1)
	if not slot1 then
		return true
	end

	if string.nilorempty(slot1.elementList) then
		return true
	end

	for slot7, slot8 in ipairs(string.splitToNumber(slot2, "#")) do
		if not DungeonMapModel.instance:elementIsFinished(slot8) then
			return false
		end
	end

	return true
end

return slot0
