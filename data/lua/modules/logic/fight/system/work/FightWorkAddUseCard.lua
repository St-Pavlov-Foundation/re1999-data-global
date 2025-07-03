module("modules.logic.fight.system.work.FightWorkAddUseCard", package.seeall)

local var_0_0 = class("FightWorkAddUseCard", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	if not FightCardDataHelper.cardChangeIsMySide(arg_1_0.actEffectData) then
		arg_1_0:onDone(true)

		return
	end

	local var_1_0 = arg_1_0.actEffectData.effectNum
	local var_1_1 = FightPlayCardModel.instance:getUsedCards()

	if var_1_0 - 1 > #var_1_1 then
		var_1_0 = #var_1_1 + 1
	end

	FightViewPartVisible.set(false, false, false, false, true)
	FightPlayCardModel.instance:addUseCard(var_1_0, arg_1_0.actEffectData.cardInfo, arg_1_0.actEffectData.effectNum1)
	FightController.instance:dispatchEvent(FightEvent.AddUseCard, var_1_0)

	local var_1_2 = arg_1_0:getWaitTime()

	arg_1_0:com_registTimer(arg_1_0._delayAfterPerformance, var_1_2 / FightModel.instance:getUISpeed())
end

function var_0_0.getWaitTime(arg_2_0)
	if FightHeroALFComp.ALFSkillDict[arg_2_0.actEffectData.effectNum1] then
		return 1.8
	end

	return 0.5
end

function var_0_0.clearWork(arg_3_0)
	return
end

return var_0_0
