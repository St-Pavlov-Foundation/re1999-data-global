module("modules.logic.sp01.assassin2.controller.stealthgameflow.StealthEnemyFightWork", package.seeall)

local var_0_0 = class("StealthEnemyFightWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = AssassinStealthGameModel.instance:getEnemyOperationData()
	local var_1_1 = var_1_0 and var_1_0.battleGrids

	if var_1_1 and #var_1_1 > 0 then
		local var_1_2 = {}

		for iter_1_0, iter_1_1 in ipairs(var_1_1) do
			local var_1_3 = AssassinStealthGameModel.instance:getGridEntityIdList(iter_1_1, false)

			for iter_1_2, iter_1_3 in ipairs(var_1_3) do
				if AssassinStealthGameModel.instance:getHeroMo(iter_1_3, true):getStatus() == AssassinEnum.HeroStatus.Expose then
					var_1_2[#var_1_2 + 1] = iter_1_3
				end
			end
		end

		if #var_1_2 > 0 then
			for iter_1_4, iter_1_5 in ipairs(var_1_2) do
				AssassinStealthGameEntityMgr.instance:playHeroEff(iter_1_5, AssassinEnum.EffectId.EnemyAttack)
			end

			local var_1_4 = AssassinConfig.instance:getAssassinEffectDuration(AssassinEnum.EffectId.EnemyAttack)

			TaskDispatcher.cancelTask(arg_1_0.playAttackEffFinished, arg_1_0)
			TaskDispatcher.runDelay(arg_1_0.playAttackEffFinished, arg_1_0, var_1_4)
		else
			arg_1_0:playAttackEffFinished()
		end
	else
		arg_1_0:onDone(true)
	end
end

function var_0_0.playAttackEffFinished(arg_2_0)
	local var_2_0 = AssassinStealthGameModel.instance:getEnemyOperationData()
	local var_2_1 = var_2_0 and var_2_0.battleGrids
	local var_2_2 = var_2_1 and var_2_1[1]

	if var_2_2 then
		AssassinStealthGameController.instance:enterBattleGrid(var_2_2)
	end

	arg_2_0:onDone(false)
end

function var_0_0.clearWork(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0.playAttackEffFinished, arg_3_0)
end

return var_0_0
