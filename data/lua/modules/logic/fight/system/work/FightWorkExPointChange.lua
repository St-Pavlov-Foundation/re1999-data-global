module("modules.logic.fight.system.work.FightWorkExPointChange", package.seeall)

local var_0_0 = class("FightWorkExPointChange", FightEffectBase)

function var_0_0.beforePlayEffectData(arg_1_0)
	arg_1_0._entityId = arg_1_0.actEffectData.targetId
	arg_1_0._entityMO = FightDataHelper.entityMgr:getById(arg_1_0._entityId)
	arg_1_0._oldValue = arg_1_0._entityMO and arg_1_0._entityMO.exPoint
end

function var_0_0.onStart(arg_2_0)
	if not arg_2_0._entityMO then
		arg_2_0:onDone(true)

		return
	end

	arg_2_0._newValue = arg_2_0._entityMO and arg_2_0._entityMO.exPoint

	if arg_2_0._oldValue ~= arg_2_0._newValue then
		FightController.instance:dispatchEvent(FightEvent.OnExPointChange, arg_2_0._entityId, arg_2_0._oldValue, arg_2_0._newValue)

		if FightModel.instance:getVersion() < 1 and arg_2_0._newValue < arg_2_0._oldValue then
			if FightModel.instance:getCurStage() == FightEnum.Stage.StartRound then
				arg_2_0:onDone(true)

				return
			end

			local var_2_0 = arg_2_0:_calcRemoveCard()

			if var_2_0 then
				arg_2_0:_removeCard(var_2_0)

				return
			end
		end
	end

	arg_2_0:onDone(true)
end

function var_0_0._removeCard(arg_3_0, arg_3_1)
	arg_3_0._needRemoveCard = true
	arg_3_0._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)

	local var_3_0 = FightDataHelper.handCardMgr.handCard
	local var_3_1 = #var_3_0

	table.sort(arg_3_1, FightWorkCardRemove2.sort)

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		table.remove(var_3_0, iter_3_1)
	end

	local var_3_2 = 0.033
	local var_3_3 = 1.2 + var_3_2 * 7 + 3 * var_3_2 * (var_3_1 - #arg_3_1)

	if FightCardDataHelper.canCombineCardListForPerformance(var_3_0) then
		arg_3_0:com_registTimer(arg_3_0._delayDone, 10)
		FightController.instance:registerCallback(FightEvent.OnCombineCardEnd, arg_3_0._onCombineDone, arg_3_0)
		FightController.instance:dispatchEvent(FightEvent.CardRemove, arg_3_1, var_3_3, true)
	else
		arg_3_0:com_registTimer(arg_3_0._delayAfterPerformance, var_3_3 / FightModel.instance:getUISpeed())
		FightController.instance:dispatchEvent(FightEvent.CardRemove, arg_3_1)
	end
end

function var_0_0._onCombineDone(arg_4_0)
	arg_4_0:onDone(true)
end

function var_0_0._delayDone(arg_5_0)
	FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
	arg_5_0:onDone(true)
end

function var_0_0._delayAfterPerformance(arg_6_0)
	arg_6_0:onDone(true)
end

function var_0_0._calcRemoveCard(arg_7_0)
	local var_7_0 = FightDataHelper.handCardMgr.handCard
	local var_7_1

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		local var_7_2 = FightDataHelper.entityMgr:getById(iter_7_1.uid)

		if var_7_2 then
			local var_7_3 = var_7_2:getExPoint()
			local var_7_4 = var_7_2 and var_7_2:getUniqueSkillPoint() or 5

			if FightCardDataHelper.isBigSkill(iter_7_1.skillId) and var_7_3 < var_7_4 then
				var_7_1 = var_7_1 or {}

				table.insert(var_7_1, iter_7_0)
			end
		end
	end

	return var_7_1
end

function var_0_0.clearWork(arg_8_0)
	if arg_8_0._needRemoveCard and arg_8_0._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end

	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, arg_8_0._onCombineDone, arg_8_0)
end

return var_0_0
