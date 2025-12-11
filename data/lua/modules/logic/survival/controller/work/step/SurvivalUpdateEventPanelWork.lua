module("modules.logic.survival.controller.work.step.SurvivalUpdateEventPanelWork", package.seeall)

local var_0_0 = class("SurvivalUpdateEventPanelWork", SurvivalStepBaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0._stepMo.panel

	if var_1_0.type == SurvivalEnum.PanelType.Search and ViewMgr.instance:isOpen(ViewName.SurvivalMapSearchView) and not arg_1_0.context.fastExecute then
		SurvivalController.instance:registerCallback(SurvivalEvent.SurvivalSearchAnimFinish, arg_1_0._delayDone, arg_1_0)
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnSearchEventUpdate, var_1_0:getSearchItems())
	else
		arg_1_0:onDone(true)
	end
end

function var_0_0._delayDone(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.SurvivalSearchAnimFinish, arg_3_0._delayDone, arg_3_0)
end

function var_0_0.getRunOrder(arg_4_0, arg_4_1, arg_4_2)
	arg_4_1.havePanelUpdate = true

	return SurvivalEnum.StepRunOrder.After
end

return var_0_0
