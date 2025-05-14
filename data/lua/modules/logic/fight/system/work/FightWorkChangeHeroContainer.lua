module("modules.logic.fight.system.work.FightWorkChangeHeroContainer", package.seeall)

local var_0_0 = class("FightWorkChangeHeroContainer", FightStepEffectFlow)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0:getAdjacentSameEffectList(nil, true)
	local var_1_1 = arg_1_0:com_registWorkDoneFlowSequence()
	local var_1_2 = var_1_1:registWork(FightWorkFlowParallel)

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		local var_1_3 = iter_1_1.effect.effectType
		local var_1_4 = FightStepBuilder.ActEffectWorkCls[var_1_3]

		var_1_2:registWork(var_1_4, iter_1_1.stepMO, iter_1_1.effect)
	end

	var_1_1:registWork(FightWorkFocusMonsterAfterChangeHero)
	var_1_1:start()
end

function var_0_0._showSubEntity(arg_2_0)
	GameSceneMgr.instance:getCurScene().entityMgr:showSubEntity()
end

function var_0_0.clearWork(arg_3_0)
	return
end

return var_0_0
