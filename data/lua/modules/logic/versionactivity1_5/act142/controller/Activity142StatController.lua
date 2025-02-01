module("modules.logic.versionactivity1_5.act142.controller.Activity142StatController", package.seeall)

slot0 = class("Activity142StatController", BaseController)
slot0.FailReasonEnum = {
	[0] = "",
	nil,
	nil,
	"回合上限",
	"触碰到不可触碰的棋子",
	"被场地机制击倒"
}

function slot0.statStart(slot0)
	slot0.startTime = Time.realtimeSinceStartup
end

function slot0.statEnd(slot0, slot1)
	if not slot0.startTime or slot0.waitingRpc then
		return
	end

	slot0.useTime = Time.realtimeSinceStartup - slot0.startTime
	slot0.episodeId = Activity142Model.instance:getCurEpisodeId()
	slot0.round = Va3ChessGameModel.instance:getRound()

	if slot1 == StatEnum.Result.Abort or slot1 == StatEnum.Result.Reset or slot1 == StatEnum.Result.BackTrace then
		slot0.round = slot0.round - 1
	end

	slot0.goalNum = Activity142Model.instance:getStarCount()
	slot0.result = slot1

	if slot1 == StatEnum.Result.Fail then
		slot0.failReason = uv0.FailReasonEnum[Va3ChessGameModel.instance:getFailReason() or 0] or ""
	else
		slot0.failReason = ""
	end

	slot0.startTime = nil
	slot0.waitingRpc = true

	Va3ChessRpcController.instance:sendGetActInfoRequest(Activity142Model.instance:getActivityId(), slot0._onReceive142InfoCb, slot0)
end

function slot0._onReceive142InfoCb(slot0)
	slot0.waitingRpc = false

	StatController.instance:track(StatEnum.EventName.ExitSpathodeaActivity, {
		[StatEnum.EventProperties.UseTime] = slot0.useTime,
		[StatEnum.EventProperties.EpisodeId] = tostring(slot0.episodeId),
		[StatEnum.EventProperties.ChallengesNum] = Activity142Model.instance:getEpisodeData(slot0.episodeId) and slot1.totalCount or 0,
		[StatEnum.EventProperties.RoundNum] = slot0.round,
		[StatEnum.EventProperties.GoalNum] = slot0.goalNum,
		[StatEnum.EventProperties.Result] = slot0.result,
		[StatEnum.EventProperties.FailReason] = slot0.failReason
	})
end

function slot0.statSuccess(slot0)
	slot0:statEnd(StatEnum.Result.Success)
end

function slot0.statFail(slot0)
	slot0:statEnd(StatEnum.Result.Fail)
	slot0:statStart()
end

function slot0.statBack2CheckPoint(slot0)
	slot0:statEnd(StatEnum.Result.BackTrace)
	slot0:statStart()
end

function slot0.statReset(slot0)
	slot0:statEnd(StatEnum.Result.Reset)
	slot0:statStart()
end

function slot0.statAbort(slot0)
	slot0:statEnd(StatEnum.Result.Abort)
end

function slot0.statCollectionViewStart(slot0)
	slot0.collectionViewStartTime = Time.realtimeSinceStartup
end

function slot0.statCollectionViewEnd(slot0)
	if not slot0.collectionViewStartTime then
		return
	end

	slot2 = Time.realtimeSinceStartup - slot0.collectionViewStartTime
	slot3 = {}

	for slot8, slot9 in ipairs(Activity142Model.instance:getHadCollectionIdList()) do
		table.insert(slot3, Activity142Config.instance:getCollectionName(Activity142Model.instance:getActivityId(), slot9))
	end

	StatController.instance:track(StatEnum.EventName.ExitSpathodeaCollect, {
		[StatEnum.EventProperties.Time] = slot2,
		[StatEnum.EventProperties.CollectedItems] = slot3
	})

	slot0.collectionViewStartTime = nil
end

slot0.instance = slot0.New()

return slot0
