module("modules.logic.versionactivity.controller.VersionActivityDungeonController", package.seeall)

slot0 = class("VersionActivityDungeonController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.openVersionActivityDungeonMapView(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.rpcCallback = slot3
	slot0.rpcCallbackObj = slot4
	slot0.openViewParam = {
		chapterId = slot1,
		episodeId = slot2
	}

	if slot5 then
		for slot9, slot10 in pairs(slot5) do
			slot0.openViewParam[slot9] = slot10
		end
	end

	Activity113Rpc.instance:sendGetAct113InfoRequest(VersionActivity1_6Enum.ActivityId.Reactivity, function ()
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.ActivityDungeon
		}, uv0._openVersionActivityDungeonMapView, uv0)
	end)
end

function slot0._openVersionActivityDungeonMapView(slot0)
	ViewMgr.instance:openView(ViewName.VersionActivityDungeonMapView, slot0.openViewParam)

	if slot0.rpcCallback then
		slot0.rpcCallback(slot0.rpcCallbackObj)
	end
end

function slot0.getEpisodeMapConfig(slot0, slot1)
	if DungeonConfig.instance:getEpisodeCO(slot1).chapterId == VersionActivityEnum.DungeonChapterId.LeiMiTeBeiHard then
		for slot8, slot9 in ipairs(DungeonConfig.instance:getChapterEpisodeCOList(VersionActivityEnum.DungeonChapterId.LeiMiTeBei)) do
			if DungeonConfig.instance:getEpisodeLevelIndexByEpisodeId(slot1) == DungeonConfig.instance:getEpisodeLevelIndexByEpisodeId(slot9.id) then
				slot2 = slot9

				break
			end
		end
	else
		while slot2.chapterId ~= VersionActivityEnum.DungeonChapterId.LeiMiTeBei do
			slot2 = DungeonConfig.instance:getEpisodeCO(slot2.preEpisode)
		end
	end

	return DungeonConfig.instance:getChapterMapCfg(VersionActivityEnum.DungeonChapterId.LeiMiTeBei, slot2.preEpisode)
end

slot0.instance = slot0.New()

return slot0
