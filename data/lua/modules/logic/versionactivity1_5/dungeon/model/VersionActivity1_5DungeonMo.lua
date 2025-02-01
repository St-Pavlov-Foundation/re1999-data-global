module("modules.logic.versionactivity1_5.dungeon.model.VersionActivity1_5DungeonMo", package.seeall)

slot0 = pureTable("VersionActivity1_5DungeonMo", VersionActivityDungeonBaseMo)

function slot0.updateEpisodeId(slot0, slot1)
	if slot1 then
		slot0.episodeId = slot1

		if DungeonConfig.instance:getEpisodeCO(slot0.episodeId).chapterId == slot0.activityDungeonConfig.story2ChapterId or slot2.chapterId == slot0.activityDungeonConfig.story3ChapterId then
			while slot2.chapterId ~= slot0.activityDungeonConfig.story1ChapterId do
				slot2 = DungeonConfig.instance:getEpisodeCO(slot2.preEpisode)
			end
		end

		slot0.episodeId = slot2.id

		return
	end

	if DungeonModel.instance:hasPassAllChapterEpisode(slot0.chapterId) then
		slot0.episodeId = VersionActivityDungeonBaseController.instance:getChapterLastSelectEpisode(slot0.chapterId)
	else
		slot3 = nil

		for slot7, slot8 in ipairs(DungeonConfig.instance:getChapterEpisodeCOList(slot0.chapterId)) do
			if (slot8 and DungeonModel.instance:getEpisodeInfo(slot8.id) or nil) and slot0:checkEpisodeUnLock(slot8) then
				slot0.episodeId = slot8.id
			end
		end
	end
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
