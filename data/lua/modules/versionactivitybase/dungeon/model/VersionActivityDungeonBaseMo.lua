module("modules.versionactivitybase.dungeon.model.VersionActivityDungeonBaseMo", package.seeall)

slot0 = pureTable("VersionActivityDungeonBaseMo")

function slot0.ctor(slot0)
	slot0.actId = nil
	slot0.chapterId = nil
	slot0.episodeId = nil
	slot0.mode = nil
	slot0.activityDungeonConfig = nil
	slot0.unlockHardModeEpisodeId = nil
	slot0.layoutClass = nil
	slot0.episodeItemCls = nil
	slot0.layoutPrefabUrl = nil
	slot0.layoutOffsetY = nil
end

function slot0.init(slot0, slot1, slot2, slot3)
	slot0.actId = slot1
	slot0.activityDungeonConfig = ActivityConfig.instance:getActivityDungeonConfig(slot1)
	slot0.unlockHardModeEpisodeId = slot0:getUnlockActivityHardDungeonEpisodeId()

	if not slot2 and not slot3 then
		slot0.chapterId = slot0.activityDungeonConfig.story1ChapterId
	elseif slot3 then
		slot0.chapterId = DungeonConfig.instance:getEpisodeCO(slot3).chapterId
	else
		slot0.chapterId = slot2
	end

	if slot0.chapterId == slot0.activityDungeonConfig.story2ChapterId or slot0.chapterId == slot0.activityDungeonConfig.story3ChapterId then
		slot0.chapterId = slot0.activityDungeonConfig.story1ChapterId
	end

	slot0:updateMode()
	slot0:updateEpisodeId(slot3)
end

function slot0.update(slot0, slot1, slot2)
	slot0:init(slot0.actId, slot1, slot2)
end

function slot0.getUnlockActivityHardDungeonEpisodeId(slot0)
	return DungeonConfig.instance:getChapterEpisodeCOList(slot0.activityDungeonConfig.hardChapterId) and #slot1 > 0 and slot1[1].preEpisode
end

function slot0.updateMode(slot0)
	if slot0.chapterId == slot0.activityDungeonConfig.story1ChapterId then
		slot0.mode = VersionActivityDungeonBaseEnum.DungeonMode.Story
	elseif slot0.chapterId == slot0.activityDungeonConfig.story2ChapterId then
		slot0.mode = VersionActivityDungeonBaseEnum.DungeonMode.Story2
	elseif slot0.chapterId == slot0.activityDungeonConfig.story3ChapterId then
		slot0.mode = VersionActivityDungeonBaseEnum.DungeonMode.Story3
	elseif slot0.chapterId == slot0.activityDungeonConfig.hardChapterId then
		slot0.mode = VersionActivityDungeonBaseEnum.DungeonMode.Hard
	end
end

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
			if slot8 and DungeonModel.instance:getEpisodeInfo(slot8.id) or nil then
				slot0.episodeId = slot8.id
			end
		end
	end
end

function slot0.changeMode(slot0, slot1)
	slot0.mode = slot1
	slot0.chapterId = slot0.activityDungeonConfig[VersionActivityDungeonBaseEnum.DungeonMode2ChapterIdKey[slot0.mode]]

	slot0:updateEpisodeId()
	VersionActivityDungeonBaseController.instance:dispatchEvent(VersionActivityDungeonEvent.OnModeChange)
end

function slot0.changeEpisode(slot0, slot1)
	slot0:updateEpisodeId(slot1)
	VersionActivityDungeonBaseController.instance:dispatchEvent(VersionActivityDungeonEvent.OnActivityDungeonMoChange)
end

function slot0.isHardMode(slot0)
	return slot0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard
end

function slot0.setLayoutClass(slot0, slot1)
	slot0.layoutClass = slot1
end

function slot0.getLayoutClass(slot0)
	return slot0.layoutClass or VersionActivityDungeonBaseChapterLayout
end

function slot0.setMapEpisodeItemClass(slot0, slot1)
	slot0.episodeItemCls = slot1
end

function slot0.getEpisodeItemClass(slot0)
	return slot0.episodeItemCls or VersionActivityDungeonBaseEpisodeItem
end

function slot0.setLayoutPrefabUrl(slot0, slot1)
	slot0.layoutPrefabUrl = slot1
end

function slot0.getLayoutPrefabUrl(slot0)
	return slot0.layoutPrefabUrl or "ui/viewres/dungeon/chaptermap/chaptermaplayout.prefab"
end

function slot0.setLayoutOffsetY(slot0, slot1)
	slot0.layoutOffsetY = slot1
end

function slot0.getLayoutOffsetY(slot0)
	return slot0.layoutOffsetY or 100
end

return slot0
