module("modules.logic.survival.controller.work.step.SurvivalRemoveEventPanelWork", package.seeall)

local var_0_0 = class("SurvivalRemoveEventPanelWork", SurvivalStepBaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = false
	local var_1_1 = arg_1_0._stepMo.paramInt[1]

	if var_1_1 == 1 then
		local var_1_2 = SurvivalMapModel.instance:getSceneMo()

		var_1_0 = var_1_2:isHaveIceEvent()
		var_1_2.panel = nil
	elseif var_1_1 == 2 then
		SurvivalShelterModel.instance:getWeekInfo().panel = nil
	end

	ViewMgr.instance:closeView(ViewName.SurvivalMapEventView)
	ViewMgr.instance:closeView(ViewName.SurvivalMapSearchView)
	ViewMgr.instance:closeView(ViewName.SurvivalDropSelectView)
	ViewMgr.instance:closeView(ViewName.SurvivalShopView)

	if var_1_0 then
		local var_1_3 = SurvivalMapHelper.instance:getEntity(0)

		if var_1_3 then
			var_1_3:playAnim("down_out")
			TaskDispatcher.runDelay(arg_1_0._delayDone, arg_1_0, 1.2)
		else
			arg_1_0:onDone(true)
		end
	else
		arg_1_0:onDone(true)
	end
end

function var_0_0._delayDone(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._delayDone, arg_3_0)
end

function var_0_0.getRunOrder(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1.havePanelUpdate then
		arg_4_1.havePanelUpdate = false

		return SurvivalEnum.StepRunOrder.After
	else
		return SurvivalEnum.StepRunOrder.Before
	end
end

return var_0_0
