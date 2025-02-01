module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.controller.VersionActivity1_3DungeonController", package.seeall)

slot0 = class("VersionActivity1_3DungeonController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
	slot0.directFocusDaily = false
	slot0.dailyFromEpisodeId = nil
end

function slot0.openVersionActivityDungeonMapView(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.openViewParam = {
		chapterId = slot1,
		episodeId = slot2
	}

	if slot5 then
		for slot9, slot10 in pairs(slot5) do
			slot0.openViewParam[slot9] = slot10
		end
	end

	Activity113Rpc.instance:sendGetAct113InfoRequest(VersionActivity1_3Enum.ActivityId.Dungeon)

	if #TaskModel.instance:getTaskMoList(TaskEnum.TaskType.ActivityDungeon, VersionActivity1_3Enum.ActivityId.Dungeon) > 0 and Activity126Model.instance.isInit then
		ViewMgr.instance:openView(ViewName.VersionActivity1_3DungeonMapView, slot0.openViewParam)

		if slot3 then
			slot3()
		end

		return
	end

	if ActivityModel.instance:isActOnLine(VersionActivity1_3Enum.ActivityId.Act310) then
		Activity126Rpc.instance:sendGet126InfosRequest(VersionActivity1_3Enum.ActivityId.Act310)
	end

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, function ()
		ViewMgr.instance:openView(ViewName.VersionActivity1_3DungeonMapView, uv0.openViewParam)

		if uv1 then
			uv1()
		end
	end)
end

function slot0.getEpisodeMapConfig(slot0, slot1)
	if DungeonConfig.instance:getEpisodeCO(slot1).chapterId == VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBeiHard then
		for slot8, slot9 in ipairs(DungeonConfig.instance:getChapterEpisodeCOList(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei)) do
			if DungeonConfig.instance:getEpisodeLevelIndexByEpisodeId(slot1) == DungeonConfig.instance:getEpisodeLevelIndexByEpisodeId(slot9.id) then
				slot2 = slot9

				break
			end
		end
	else
		while slot2.chapterId ~= VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei do
			slot2 = DungeonConfig.instance:getEpisodeCO(slot2.preEpisode)
		end
	end

	return DungeonConfig.instance:getChapterMapCfg(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei, slot2.preEpisode)
end

function slot0.isDayTime(slot0, slot1)
	if DungeonConfig.instance:getEpisodeCO(slot1).chapterId == VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBeiHard then
		slot1 = slot1 - 10000
	end

	return slot1 < VersionActivity1_3DungeonEnum.DailyEpisodeId or slot1 == VersionActivity1_3DungeonEnum.ExtraEpisodeId
end

function slot0.openDungeonChangeView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.VersionActivity1_3DungeonChangeView, slot1)
end

function slot0.getEpisodeIndex(slot0, slot1)
	if DungeonConfig.instance:getEpisodeCO(slot1).chapterId == VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBeiHard then
		slot2 = DungeonConfig.instance:getEpisodeCO(slot1 - 10000)
	elseif slot2.chapterId == VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei3 then
		slot2 = DungeonConfig.instance:getEpisodeCO(slot2.preEpisode)
	elseif slot2.chapterId == VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei4 then
		slot2 = DungeonConfig.instance:getEpisodeCO(DungeonConfig.instance:getEpisodeCO(slot2.preEpisode).preEpisode)
	end

	return DungeonConfig.instance:getChapterEpisodeIndexWithSP(slot2.chapterId, slot2.id)
end

slot0.instance = slot0.New()

return slot0
