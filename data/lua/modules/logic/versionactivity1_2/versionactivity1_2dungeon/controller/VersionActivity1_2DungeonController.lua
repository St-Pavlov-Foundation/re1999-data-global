module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.controller.VersionActivity1_2DungeonController", package.seeall)

slot0 = class("VersionActivity1_2DungeonController", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
end

function slot0.setDungeonSelectedEpisodeId(slot0, slot1)
	slot0.dungeonSelectedEpisodeId = slot1
end

function slot0.getDungeonSelectedEpisodeId(slot0)
	return slot0.dungeonSelectedEpisodeId
end

function slot0.getEpisodeMapConfig(slot0, slot1)
	slot2 = DungeonConfig.instance:getEpisodeCO(slot1)
	slot3 = VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal1

	while slot2.chapterId ~= slot3 do
		slot2 = DungeonConfig.instance:getEpisodeCO(slot2.preEpisode)
	end

	return DungeonConfig.instance:getChapterMapCfg(slot3, slot2.preEpisode)
end

function slot0._onFinishStory(slot0)
	slot0:openDungeonView(slot0._enterChapterId, slot0._enterEpisodeId, slot0._showMapLevelView, slot0._focusCamp)
end

function slot0.openDungeonView(slot0, slot1, slot2, slot3, slot4, slot5)
	if not VersionActivityBaseController.instance:isPlayedActivityVideo(VersionActivity1_2Enum.ActivityId.Dungeon) and ActivityConfig.instance:getActivityCo(VersionActivity1_2Enum.ActivityId.Dungeon) and slot6.storyId and slot7 ~= 0 then
		slot0._enterChapterId = slot1
		slot0._enterEpisodeId = slot2
		slot0._showMapLevelView = slot3
		slot0._focusCamp = slot4

		StoryController.instance:playStory(slot7, nil, slot0._onFinishStory, slot0)

		return
	end

	Activity113Rpc.instance:sendGetAct113InfoRequest(VersionActivity1_7Enum.ActivityId.Reactivity, function ()
		ViewMgr.instance:openView(ViewName.VersionActivity1_2DungeonView, {
			chapterId = uv0,
			episodeId = uv1,
			showMapLevelView = uv2,
			focusCamp = uv3,
			jumpParam = uv4
		})
	end)
end

function slot0._getDefaultFocusEpisode(slot0, slot1)
	slot3 = true
	slot4 = nil

	for slot8, slot9 in ipairs(DungeonConfig.instance:getChapterEpisodeCOList(slot1)) do
		if not DungeonModel.instance:hasPassLevel(slot9.id) then
			slot3 = false
		end

		if DungeonModel.instance:isUnlock(slot9) and DungeonModel.instance:isFinishElementList(slot9) then
			slot4 = slot9.id
		end
	end

	if slot3 and VersionActivity1_2DungeonMapEpisodeBaseView.getlastBattleEpisodeId(slot1) > 0 then
		return slot5
	end

	return slot4 or slot2[1].id
end

function slot0.getNowEpisodeId(slot0)
	slot1 = DungeonConfig.instance:getChapterEpisodeCOList(VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal1)
	slot2 = slot1[1].id

	for slot6, slot7 in ipairs(slot1) do
		if DungeonModel.instance:isUnlock(slot7) and DungeonModel.instance:isFinishElementList(slot7) then
			slot2 = slot7.id
		end
	end

	return slot2
end

slot0.instance = slot0.New()

return slot0
