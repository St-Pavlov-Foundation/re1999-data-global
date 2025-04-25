module("modules.logic.versionactivity2_5.liangyue.controller.LiangYueController", package.seeall)

slot0 = class("LiangYueController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.openGameView(slot0, slot1, slot2)
	LiangYueModel.instance:setCurActId(slot1)
	LiangYueModel.instance:setCurEpisodeId(slot2)
	ViewMgr.instance:openView(ViewName.LiangYueGameView, {
		actId = slot1,
		episodeId = slot2,
		episodeGameId = LiangYueConfig.instance:getEpisodeConfigByActAndId(slot1, slot2).puzzleId
	})
end

function slot0.enterLevelView(slot0, slot1)
	LiangYueRpc.instance:sendGetAct184InfoRequest(slot1, slot0._onReceiveInfo, slot0)
end

function slot0._onReceiveInfo(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		ViewMgr.instance:openView(ViewName.LiangYueLevelView)
	end
end

function slot0.finishEpisode(slot0, slot1, slot2, slot3)
	LiangYueRpc.instance:sendAct184FinishEpisodeRequest(slot1, slot2, slot3)
end

function slot0.statExitData(slot0, slot1, slot2, slot3, slot4)
	StatController.instance:track(StatEnum.EventName.ExitLiangYueActivity, {
		[StatEnum.EventProperties.LiangYue_UseTime] = ServerTime.now() - slot1,
		[StatEnum.EventProperties.EpisodeId] = tostring(slot2),
		[StatEnum.EventProperties.Result] = slot3,
		[StatEnum.EventProperties.LiangYue_Illustration_Result] = slot4
	})
end

slot0.instance = slot0.New()

return slot0
