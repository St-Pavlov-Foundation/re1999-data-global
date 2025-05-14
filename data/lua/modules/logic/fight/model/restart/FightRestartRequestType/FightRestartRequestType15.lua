module("modules.logic.fight.model.restart.FightRestartRequestType.FightRestartRequestType15", package.seeall)

local var_0_0 = class("FightRestartRequestType15", FightRestartRequestType1)

function var_0_0.requestFight(arg_1_0)
	local var_1_0 = DungeonModel.instance.curSendEpisodeId
	local var_1_1 = DungeonConfig.instance:getEpisodeCO(var_1_0)
	local var_1_2 = Activity104Model.instance:getCurSeasonId()
	local var_1_3 = Activity104Model.instance:getBattleFinishLayer()

	if var_1_1.type == DungeonEnum.EpisodeType.SeasonRetail then
		var_1_3 = 0
	end

	local var_1_4 = FightModel.instance:getFightParam()
	local var_1_5 = {
		isRestart = true,
		chapterId = var_1_4.chapterId,
		episodeId = var_1_0,
		fightParam = var_1_4,
		multiplication = var_1_4.multiplication
	}

	Activity104Rpc.instance:sendStartAct104BattleRequest(var_1_5, var_1_2, var_1_3, var_1_0, arg_1_0.enterFightAgainRpcCallback, arg_1_0)
end

function var_0_0.enterFightAgainRpcCallback(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if arg_2_2 ~= 0 then
		FightSystem.instance:restartFightFail()

		return
	end

	arg_2_0._fight_work:onDone(true)
end

return var_0_0
