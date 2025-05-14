module("modules.logic.chessgame.controller.ChessStatController", package.seeall)

local var_0_0 = class("ChessStatController")

function var_0_0.startStat(arg_1_0)
	arg_1_0.startTime = ServerTime.now()
end

function var_0_0.statSuccess(arg_2_0)
	arg_2_0:_statEnd(StatEnum.Result.Success)
end

function var_0_0.statFail(arg_3_0)
	arg_3_0:_statEnd(StatEnum.Result.Fail)
end

function var_0_0.statReset(arg_4_0)
	arg_4_0:_statEnd(StatEnum.Result.Reset)
	arg_4_0:startStat()
end

function var_0_0.statAbort(arg_5_0)
	arg_5_0:_statEnd(StatEnum.Result.Abort)
end

function var_0_0._statEnd(arg_6_0, arg_6_1)
	if not arg_6_0.startTime then
		return
	end

	StatController.instance:track(StatEnum.EventName.ExitLanShouPaActivity, {
		[StatEnum.EventProperties.UseTime] = ServerTime.now() - arg_6_0.startTime,
		[StatEnum.EventProperties.EpisodeId] = tostring(ChessModel.instance:getEpisodeId()),
		[StatEnum.EventProperties.RoundNum] = ChessGameModel.instance:getRound(),
		[StatEnum.EventProperties.GoalNum] = ChessGameModel.instance:getCompletedCount(),
		[StatEnum.EventProperties.Result] = arg_6_1,
		[StatEnum.EventProperties.BackNum] = ChessGameModel.instance:getRollBackNum()
	})
	ChessGameModel.instance:clearRound()
	ChessGameModel.instance:clearRollbackNum()

	arg_6_0.startTime = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
