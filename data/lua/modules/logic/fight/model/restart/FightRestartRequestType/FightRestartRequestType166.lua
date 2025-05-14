module("modules.logic.fight.model.restart.FightRestartRequestType.FightRestartRequestType166", package.seeall)

local var_0_0 = class("FightRestartRequestType166", FightRestartRequestType1)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0:__onInit()

	arg_1_0._fight_work = arg_1_1
	arg_1_0._fightParam = arg_1_2
	arg_1_0._episode_config = arg_1_3
	arg_1_0._chapter_config = arg_1_4
end

function var_0_0.requestFight(arg_2_0)
	local var_2_0 = FightModel.instance:getFightParam()
	local var_2_1 = Season166Model.instance:getBattleContext()
	local var_2_2 = var_2_1.actId
	local var_2_3 = var_2_0.episodeId
	local var_2_4 = var_2_1.episodeType
	local var_2_5 = Season166HeroGroupModel.instance:getEpisodeConfigId(var_2_0.episodeId)
	local var_2_6 = var_2_1.talentId
	local var_2_7 = var_2_0.chapterId

	Activity166Rpc.instance:sendStartAct166BattleRequest(var_2_2, var_2_4, var_2_5, var_2_6, var_2_7, var_2_3, var_2_0, 1, nil, nil, true, arg_2_0._onReceiveBeforeStartBattleReply, arg_2_0)
	arg_2_0._fight_work:onDone(true)
end

function var_0_0._onReceiveBeforeStartBattleReply(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_2 ~= 0 then
		FightSystem.instance:restartFightFail()

		return
	end
end

function var_0_0.releaseSelf(arg_4_0)
	arg_4_0:__onDispose()
end

return var_0_0
