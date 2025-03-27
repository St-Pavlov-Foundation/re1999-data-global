module("modules.logic.versionactivity2_4.dungeon.model.VersionActivity2_4DungeonMo", package.seeall)

slot0 = pureTable("VersionActivity2_4DungeonMo", VersionActivityDungeonBaseMo)

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
			slot2 = VersionActivityDungeonBaseController.instance:getChapterLastSelectEpisode(slot0.chapterId)
		else
			slot5 = nil

			for slot9, slot10 in ipairs(slot3) do
				if (slot10 and DungeonModel.instance:getEpisodeInfo(slot10.id) or nil) and slot0:checkEpisodeUnLock(slot10) then
					slot2 = slot10.id
				end
			end
		end
	end

	slot0.episodeId = slot2
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
