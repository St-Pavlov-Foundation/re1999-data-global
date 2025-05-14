module("modules.logic.fight.system.work.FightWorkDialogBeforeStartFight", package.seeall)

local var_0_0 = class("FightWorkDialogBeforeStartFight", BaseWork)

function var_0_0.onStart(arg_1_0)
	arg_1_0._flow = FlowSequence.New()

	arg_1_0._flow:addWork(FunctionWork.New(arg_1_0._setHudState, arg_1_0))
	arg_1_0._flow:addWork(FunctionWork.New(arg_1_0._setFightViewState, arg_1_0, true))
	arg_1_0._flow:addWork(FunctionWork.New(arg_1_0._setEntityState, arg_1_0, false))
	arg_1_0._flow:addWork(FightWorkNormalDialog.New(FightViewDialog.Type.BeforeStartFight))
	arg_1_0._flow:addWork(FightWorkNormalDialog.New(FightViewDialog.Type.BeforeStartFightAndXXTimesEnterBattleId))
	arg_1_0._flow:addWork(FunctionWork.New(arg_1_0._setFightViewState, arg_1_0, false))
	arg_1_0._flow:registerDoneListener(arg_1_0._onFlowDone, arg_1_0)
	arg_1_0._flow:start()
end

function var_0_0._setHudState(arg_2_0)
	gohelper.setActive(ViewMgr.instance:getUILayer(UILayerName.Hud), true)
	gohelper.setActiveCanvasGroup(ViewMgr.instance:getUILayer(UILayerName.Hud), true)
end

function var_0_0._setFightViewState(arg_3_0, arg_3_1)
	FightController.instance:dispatchEvent(FightEvent.SetStateForDialogBeforeStartFight, arg_3_1)
end

function var_0_0._setEntityState(arg_4_0, arg_4_1)
	FightViewPartVisible.set()

	local var_4_0 = FightHelper.getAllEntitys()

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		if iter_4_1.nameUI then
			iter_4_1.nameUI:setActive(arg_4_1)
		end

		if iter_4_1.setAlpha then
			iter_4_1:setAlpha(arg_4_1 and 1 or 0, 0)
		end
	end
end

function var_0_0._onFlowDone(arg_5_0)
	arg_5_0:onDone(true)
end

function var_0_0.revertState(arg_6_0)
	if not arg_6_0._reverStateDone then
		arg_6_0._reverStateDone = true

		arg_6_0:_setFightViewState(false)
		arg_6_0:_setEntityState(true)
	end
end

function var_0_0.clearWork(arg_7_0)
	arg_7_0:revertState()

	if arg_7_0._flow then
		arg_7_0._flow:unregisterDoneListener(arg_7_0._onFlowDone, arg_7_0)
		arg_7_0._flow:stop()

		arg_7_0._flow = nil
	end
end

return var_0_0
