module("modules.logic.versionactivity1_2.common.Stat1_2Controller", package.seeall)

slot0 = class("Stat1_2Controller")

function slot0.yaXianStatStart(slot0)
	slot0.yaXianStartTime = ServerTime.now()
end

function slot0.yaXianStatEnd(slot0, slot1)
	if not slot0.yaXianStartTime then
		return
	end

	if slot0.waitingRpc then
		return
	end

	slot0.useTime = ServerTime.now() - slot0.yaXianStartTime
	slot0.mapId = YaXianGameModel.instance:getMapId()
	slot0.round = YaXianGameModel.instance:getRound()
	slot0.goalNum = YaXianGameModel.instance:getFinishConditionCount()
	slot0.episodeId = YaXianGameModel.instance:getEpisodeId()
	slot0.result = slot1
	slot0.waitingRpc = true

	Activity115Rpc.instance:sendGetAct115InfoRequest(YaXianEnum.ActivityId, slot0._onReceiveMsg, slot0)
end

function slot0._onReceiveMsg(slot0)
	slot0.yaXianStartTime = nil
	slot0.waitingRpc = false

	StatController.instance:track(StatEnum.EventName.ExitYaXian, {
		[StatEnum.EventProperties.UseTime] = slot0.useTime,
		[StatEnum.EventProperties.MapId] = tostring(slot0.mapId),
		[StatEnum.EventProperties.ChallengesNum] = YaXianModel.instance:getEpisodeMo(slot0.episodeId) and slot1.totalCount or 0,
		[StatEnum.EventProperties.RoundNum] = slot0.round,
		[StatEnum.EventProperties.GoalNum] = slot0.goalNum,
		[StatEnum.EventProperties.Result] = slot0.result
	})
end

slot0.instance = slot0.New()

return slot0
