module("modules.logic.fight.model.restart.FightRestartRequestType.FightRestartRequestType23", package.seeall)

local var_0_0 = class("FightRestartRequestType23", FightRestartRequestType1)

function var_0_0.requestFight(arg_1_0)
	arg_1_0._fight_work:onDone(true)

	if FightController.instance:setFightHeroGroup() then
		local var_1_0 = arg_1_0._fightParam
		local var_1_1 = Season123Model.instance:getBattleContext()

		if not var_1_1 then
			FightSystem.instance:restartFightFail()

			return
		end

		local var_1_2 = var_1_1.layer or -1

		Activity123Rpc.instance:sendStartAct123BattleRequest(var_1_1.actId, var_1_2, var_1_0.chapterId, var_1_0.episodeId, var_1_0, var_1_0.multiplication, nil, var_1_0.isReplay, true, arg_1_0.onReceiveStartBattle, arg_1_0)
		AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
	end
end

function var_0_0.onReceiveStartBattle(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if arg_2_2 ~= 0 then
		FightSystem.instance:restartFightFail()

		return
	end
end

return var_0_0
