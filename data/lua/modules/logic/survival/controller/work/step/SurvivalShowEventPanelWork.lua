module("modules.logic.survival.controller.work.step.SurvivalShowEventPanelWork", package.seeall)

local var_0_0 = class("SurvivalShowEventPanelWork", SurvivalStepBaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)

	if arg_1_0._stepMo.panel.type == SurvivalEnum.PanelType.Search then
		local var_1_0 = SurvivalMapModel.instance:getSceneMo()
		local var_1_1 = var_1_0 and var_1_0.unitsById[arg_1_0._stepMo.panel.unitId]

		arg_1_0.isFirst = var_1_1 and not var_1_1:isSearched() or not var_1_1
	end
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0._stepMo.paramInt[1]
	local var_2_1 = arg_2_0._stepMo.panel
	local var_2_2 = SurvivalMapModel.instance:getSceneMo()

	if var_2_0 == 1 then
		var_2_2.panel = var_2_1

		if not ViewMgr.instance:isOpen(ViewName.SurvivalMapEventView) and var_2_1.type == SurvivalEnum.PanelType.TreeEvent then
			SurvivalStatHelper.instance:statSurvivalMapUnit("TriggerEvent", var_2_1.unitId)
		end
	elseif var_2_0 == 2 then
		SurvivalShelterModel.instance:getWeekInfo().panel = var_2_1
	end

	if not arg_2_0.context.fastExecute then
		if var_2_1.type == SurvivalEnum.PanelType.TreeEvent and var_2_2:isHaveIceEvent() then
			local var_2_3 = SurvivalMapHelper.instance:getEntity(0)

			if var_2_3 then
				var_2_3:playAnim("down_in")
			end

			UIBlockHelper.instance:startBlock("SurvivalShowEventPanelWork_Ice", 1.8)
			SurvivalMapHelper.instance:tweenToHeroPosIfNeed(0.2)
			TaskDispatcher.runDelay(arg_2_0._delayOpenPanel, arg_2_0, 1.8)

			return
		end

		var_2_1.isFirstSearch = arg_2_0.isFirst

		SurvivalMapHelper.instance:tryShowServerPanel(var_2_1)
	end

	arg_2_0:onDone(true)
end

function var_0_0._delayOpenPanel(arg_3_0)
	local var_3_0 = SurvivalMapModel.instance:getSceneMo().panel

	SurvivalMapHelper.instance:tryShowServerPanel(var_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._delayOpenPanel, arg_4_0)
end

function var_0_0.getRunOrder(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	for iter_5_0 = arg_5_3 + 1, #arg_5_4 do
		local var_5_0 = arg_5_4[iter_5_0]
		local var_5_1 = var_5_0 and var_5_0._stepMo

		if var_5_1 and var_5_1.type == SurvivalEnum.StepType.RemoveEventPanel then
			local var_5_2 = var_5_1.paramLong[1]

			if arg_5_0._stepMo.panel.uid == var_5_2 then
				return SurvivalEnum.StepRunOrder.None
			end
		end
	end

	arg_5_1.havePanelUpdate = true

	return SurvivalEnum.StepRunOrder.After
end

return var_0_0
