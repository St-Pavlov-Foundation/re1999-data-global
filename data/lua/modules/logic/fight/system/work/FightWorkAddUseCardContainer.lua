module("modules.logic.fight.system.work.FightWorkAddUseCardContainer", package.seeall)

local var_0_0 = class("FightWorkAddUseCardContainer", FightStepEffectFlow)

var_0_0.IndexList = {}

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0:getAdjacentSameEffectList(nil, false)

	arg_1_0:customPlayEffectData(var_1_0)

	local var_1_1 = var_0_0.IndexList

	tabletool.clear(var_1_1)

	local var_1_2 = 0.5

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		local var_1_3 = iter_1_1.actEffectData
		local var_1_4 = var_1_3.effectNum
		local var_1_5 = FightPlayCardModel.instance:getUsedCards()

		if var_1_4 - 1 > #var_1_5 then
			var_1_4 = #var_1_5 + 1
		end

		table.insert(var_1_1, var_1_4)
		FightPlayCardModel.instance:addUseCard(var_1_4, var_1_3.cardInfo, var_1_3.effectNum1)

		if FightHeroALFComp.ALFSkillDict[var_1_3.effectNum1] then
			var_1_2 = 1.8
		end
	end

	FightController.instance:dispatchEvent(FightEvent.AddUseCard, var_1_1)
	FightController.instance:dispatchEvent(FightEvent.AfterAddUseCardContainer, arg_1_0.fightStepData)
	arg_1_0:com_registTimer(arg_1_0._delayAfterPerformance, var_1_2 / FightModel.instance:getUISpeed())
end

function var_0_0.customPlayEffectData(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		FightDataHelper.playEffectData(iter_2_1.actEffectData)
	end
end

function var_0_0.clearWork(arg_3_0)
	return
end

return var_0_0
