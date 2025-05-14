module("modules.logic.fight.system.work.FightWorkEffectCardLevelChange", package.seeall)

local var_0_0 = class("FightWorkEffectCardLevelChange", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	arg_1_0:_startChangeCardEffect()
end

function var_0_0._startChangeCardEffect(arg_2_0)
	if not FightCardDataHelper.cardChangeIsMySide(arg_2_0._actEffectMO) then
		arg_2_0:onDone(true)

		return
	end

	if FightModel.instance:getVersion() < 1 then
		local var_2_0 = arg_2_0._actEffectMO.entityMO.id
		local var_2_1 = FightHelper.getEntity(var_2_0)

		if not var_2_1 then
			arg_2_0:onDone(true)

			return
		end

		if not var_2_1:isMySide() then
			arg_2_0:onDone(true)

			return
		end
	end

	local var_2_2 = tonumber(arg_2_0._actEffectMO.targetId)
	local var_2_3 = arg_2_0._actEffectMO.effectNum
	local var_2_4 = FightCardModel.instance:getHandCards()
	local var_2_5 = var_2_4[var_2_2]

	if not var_2_5 then
		arg_2_0:onDone(true)

		return
	end

	arg_2_0._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)

	local var_2_6 = var_2_5.skillId

	var_2_5.uid = arg_2_0._actEffectMO.entityMO.id
	var_2_5.skillId = var_2_3

	if FightModel.instance:getVersion() >= 4 then
		FightController.instance:dispatchEvent(FightEvent.CardLevelChange, var_2_5, var_2_2, var_2_6)
		arg_2_0:com_registTimer(arg_2_0._delayDone, FightEnum.PerformanceTime.CardLevelChange / FightModel.instance:getUISpeed())
	else
		FightCardModel.instance:coverCard(FightCardModel.calcCardsAfterCombine(var_2_4))
		FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
		arg_2_0:onDone(true)
	end
end

function var_0_0._delayDone(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	if arg_4_0._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end
end

return var_0_0
