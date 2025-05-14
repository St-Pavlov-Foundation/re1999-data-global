module("modules.logic.versionactivity1_2.common.Stat1_2Controller", package.seeall)

local var_0_0 = class("Stat1_2Controller")

function var_0_0.yaXianStatStart(arg_1_0)
	arg_1_0.yaXianStartTime = ServerTime.now()
end

function var_0_0.yaXianStatEnd(arg_2_0, arg_2_1)
	if not arg_2_0.yaXianStartTime then
		return
	end

	if arg_2_0.waitingRpc then
		return
	end

	arg_2_0.useTime = ServerTime.now() - arg_2_0.yaXianStartTime
	arg_2_0.mapId = YaXianGameModel.instance:getMapId()
	arg_2_0.round = YaXianGameModel.instance:getRound()
	arg_2_0.goalNum = YaXianGameModel.instance:getFinishConditionCount()
	arg_2_0.episodeId = YaXianGameModel.instance:getEpisodeId()
	arg_2_0.result = arg_2_1
	arg_2_0.waitingRpc = true

	Activity115Rpc.instance:sendGetAct115InfoRequest(YaXianEnum.ActivityId, arg_2_0._onReceiveMsg, arg_2_0)
end

function var_0_0._onReceiveMsg(arg_3_0)
	local var_3_0 = YaXianModel.instance:getEpisodeMo(arg_3_0.episodeId)
	local var_3_1 = var_3_0 and var_3_0.totalCount or 0

	arg_3_0.yaXianStartTime = nil
	arg_3_0.waitingRpc = false

	StatController.instance:track(StatEnum.EventName.ExitYaXian, {
		[StatEnum.EventProperties.UseTime] = arg_3_0.useTime,
		[StatEnum.EventProperties.MapId] = tostring(arg_3_0.mapId),
		[StatEnum.EventProperties.ChallengesNum] = var_3_1,
		[StatEnum.EventProperties.RoundNum] = arg_3_0.round,
		[StatEnum.EventProperties.GoalNum] = arg_3_0.goalNum,
		[StatEnum.EventProperties.Result] = arg_3_0.result
	})
end

var_0_0.instance = var_0_0.New()

return var_0_0
