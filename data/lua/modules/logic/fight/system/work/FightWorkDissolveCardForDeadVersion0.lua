module("modules.logic.fight.system.work.FightWorkDissolveCardForDeadVersion0", package.seeall)

local var_0_0 = class("FightWorkDissolveCardForDeadVersion0", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.actEffectData = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	TaskDispatcher.runDelay(arg_2_0._delayDone, arg_2_0, 0.5)

	local var_2_0 = arg_2_0.actEffectData.targetId
	local var_2_1 = FightHelper.getEntity(var_2_0)

	if not var_2_1 then
		arg_2_0:onDone(true)

		return
	end

	if var_2_1:getMO() then
		local var_2_2 = arg_2_0:_calcRemoveCard(var_2_0)

		if var_2_2 then
			arg_2_0:_removeCard(var_2_2)

			return
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
		TaskDispatcher.cancelTask(arg_3_0._delayDone, arg_3_0)
		TaskDispatcher.runDelay(arg_3_0._delayDone, arg_3_0, 10)
		FightController.instance:registerCallback(FightEvent.OnCombineCardEnd, arg_3_0._onCombineDone, arg_3_0)
		FightController.instance:dispatchEvent(FightEvent.CardRemove, arg_3_1, var_3_3, true)
	else
		TaskDispatcher.runDelay(arg_3_0._delayAfterPerformance, arg_3_0, var_3_3 / FightModel.instance:getUISpeed())
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

function var_0_0._calcRemoveCard(arg_7_0, arg_7_1)
	local var_7_0 = FightDataHelper.handCardMgr.handCard
	local var_7_1

	for iter_7_0 = #var_7_0, 1, -1 do
		if var_7_0[iter_7_0].uid == arg_7_1 then
			var_7_1 = var_7_1 or {}

			table.insert(var_7_1, iter_7_0)
		end
	end

	return var_7_1
end

function var_0_0.clearWork(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._delayDone, arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._delayAfterPerformance, arg_8_0)

	if arg_8_0._needRemoveCard and arg_8_0._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end

	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, arg_8_0._onCombineDone, arg_8_0)
end

return var_0_0
