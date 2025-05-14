module("modules.logic.versionactivity1_4.act130.controller.StatActivity130Controller", package.seeall)

local var_0_0 = class("StatActivity130Controller", BaseController)

function var_0_0.statStart(arg_1_0)
	arg_1_0.startTime = Time.realtimeSinceStartup
end

function var_0_0.statSuccess(arg_2_0)
	arg_2_0:statEnd(StatEnum.Result.Success)
end

function var_0_0.statFail(arg_3_0)
	arg_3_0:statEnd(StatEnum.Result.Fail)
end

function var_0_0.statAbort(arg_4_0)
	arg_4_0:statEnd(StatEnum.Result.Abort)
end

function var_0_0.statReset(arg_5_0)
	arg_5_0:statEnd(StatEnum.Result.Reset)
	arg_5_0:statStart()
end

function var_0_0.statEnd(arg_6_0, arg_6_1)
	if not arg_6_0.startTime then
		return
	end

	local var_6_0 = Time.realtimeSinceStartup - arg_6_0.startTime
	local var_6_1 = Activity130Model.instance:getCurEpisodeId()
	local var_6_2 = Activity130Model.instance:getGameChallengeNum(var_6_1)
	local var_6_3 = PuzzleRecordListModel.instance:getCount()
	local var_6_4 = Role37PuzzleModel.instance:getResult() and 1 or 0
	local var_6_5 = 0
	local var_6_6 = Activity130Model.instance:getInfo(var_6_1)

	if var_6_6.getFinishElementCount then
		var_6_5 = var_6_6:getFinishElementCount()
	end

	local var_6_7 = ""

	if arg_6_1 == StatEnum.Result.Fail then
		var_6_7 = "超出回合数"
	end

	StatController.instance:track(StatEnum.EventName.Exit37Game, {
		[StatEnum.EventProperties.UseTime] = var_6_0,
		[StatEnum.EventProperties.EpisodeId] = tostring(var_6_1),
		[StatEnum.EventProperties.ChallengesNum] = var_6_2,
		[StatEnum.EventProperties.RoundNum] = var_6_3,
		[StatEnum.EventProperties.GoalNum] = var_6_4,
		[StatEnum.EventProperties.ElementNum] = var_6_5,
		[StatEnum.EventProperties.Result] = arg_6_1,
		[StatEnum.EventProperties.FailReason] = var_6_7
	})

	arg_6_0.startTime = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
