module("modules.logic.versionactivity1_5.act142.controller.Activity142StatController", package.seeall)

local var_0_0 = class("Activity142StatController", BaseController)

var_0_0.FailReasonEnum = {
	[0] = "",
	nil,
	nil,
	"回合上限",
	"触碰到不可触碰的棋子",
	"被场地机制击倒"
}

function var_0_0.statStart(arg_1_0)
	arg_1_0.startTime = Time.realtimeSinceStartup
end

function var_0_0.statEnd(arg_2_0, arg_2_1)
	if not arg_2_0.startTime or arg_2_0.waitingRpc then
		return
	end

	arg_2_0.useTime = Time.realtimeSinceStartup - arg_2_0.startTime
	arg_2_0.episodeId = Activity142Model.instance:getCurEpisodeId()
	arg_2_0.round = Va3ChessGameModel.instance:getRound()

	if arg_2_1 == StatEnum.Result.Abort or arg_2_1 == StatEnum.Result.Reset or arg_2_1 == StatEnum.Result.BackTrace then
		arg_2_0.round = arg_2_0.round - 1
	end

	arg_2_0.goalNum = Activity142Model.instance:getStarCount()
	arg_2_0.result = arg_2_1

	if arg_2_1 == StatEnum.Result.Fail then
		local var_2_0 = Va3ChessGameModel.instance:getFailReason()

		arg_2_0.failReason = var_0_0.FailReasonEnum[var_2_0 or 0] or ""
	else
		arg_2_0.failReason = ""
	end

	arg_2_0.startTime = nil
	arg_2_0.waitingRpc = true

	local var_2_1 = Activity142Model.instance:getActivityId()

	Va3ChessRpcController.instance:sendGetActInfoRequest(var_2_1, arg_2_0._onReceive142InfoCb, arg_2_0)
end

function var_0_0._onReceive142InfoCb(arg_3_0)
	local var_3_0 = Activity142Model.instance:getEpisodeData(arg_3_0.episodeId)
	local var_3_1 = var_3_0 and var_3_0.totalCount or 0

	arg_3_0.waitingRpc = false

	StatController.instance:track(StatEnum.EventName.ExitSpathodeaActivity, {
		[StatEnum.EventProperties.UseTime] = arg_3_0.useTime,
		[StatEnum.EventProperties.EpisodeId] = tostring(arg_3_0.episodeId),
		[StatEnum.EventProperties.ChallengesNum] = var_3_1,
		[StatEnum.EventProperties.RoundNum] = arg_3_0.round,
		[StatEnum.EventProperties.GoalNum] = arg_3_0.goalNum,
		[StatEnum.EventProperties.Result] = arg_3_0.result,
		[StatEnum.EventProperties.FailReason] = arg_3_0.failReason
	})
end

function var_0_0.statSuccess(arg_4_0)
	arg_4_0:statEnd(StatEnum.Result.Success)
end

function var_0_0.statFail(arg_5_0)
	arg_5_0:statEnd(StatEnum.Result.Fail)
	arg_5_0:statStart()
end

function var_0_0.statBack2CheckPoint(arg_6_0)
	arg_6_0:statEnd(StatEnum.Result.BackTrace)
	arg_6_0:statStart()
end

function var_0_0.statReset(arg_7_0)
	arg_7_0:statEnd(StatEnum.Result.Reset)
	arg_7_0:statStart()
end

function var_0_0.statAbort(arg_8_0)
	arg_8_0:statEnd(StatEnum.Result.Abort)
end

function var_0_0.statCollectionViewStart(arg_9_0)
	arg_9_0.collectionViewStartTime = Time.realtimeSinceStartup
end

function var_0_0.statCollectionViewEnd(arg_10_0)
	if not arg_10_0.collectionViewStartTime then
		return
	end

	local var_10_0 = Activity142Model.instance:getActivityId()
	local var_10_1 = Time.realtimeSinceStartup - arg_10_0.collectionViewStartTime
	local var_10_2 = {}
	local var_10_3 = Activity142Model.instance:getHadCollectionIdList()

	for iter_10_0, iter_10_1 in ipairs(var_10_3) do
		local var_10_4 = Activity142Config.instance:getCollectionName(var_10_0, iter_10_1)

		table.insert(var_10_2, var_10_4)
	end

	StatController.instance:track(StatEnum.EventName.ExitSpathodeaCollect, {
		[StatEnum.EventProperties.Time] = var_10_1,
		[StatEnum.EventProperties.CollectedItems] = var_10_2
	})

	arg_10_0.collectionViewStartTime = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
