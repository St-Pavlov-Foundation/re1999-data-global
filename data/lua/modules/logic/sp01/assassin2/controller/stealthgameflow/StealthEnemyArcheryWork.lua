module("modules.logic.sp01.assassin2.controller.stealthgameflow.StealthEnemyArcheryWork", package.seeall)

local var_0_0 = class("StealthEnemyArcheryWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = AssassinStealthGameModel.instance:getEnemyOperationData()
	local var_1_1 = var_1_0 and var_1_0.attacks

	if var_1_1 and #var_1_1 > 0 then
		for iter_1_0, iter_1_1 in ipairs(var_1_1) do
			AssassinStealthGameController.instance:updateHero(iter_1_1.hero, AssassinEnum.EffectId.EnemyAttack)
		end

		local var_1_2 = AssassinConfig.instance:getAssassinEffectDuration(AssassinEnum.EffectId.EnemyAttack)

		TaskDispatcher.cancelTask(arg_1_0.playAttackEffFinished, arg_1_0)
		TaskDispatcher.runDelay(arg_1_0.playAttackEffFinished, arg_1_0, var_1_2)
	else
		arg_1_0:playAttackEffFinished()
	end
end

function var_0_0.playAttackEffFinished(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0.playAttackEffFinished, arg_3_0)
end

return var_0_0
