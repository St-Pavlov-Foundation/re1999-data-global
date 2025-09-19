module("modules.logic.survival.controller.work.SurvivalShowEventPanelWork", package.seeall)

local var_0_0 = class("SurvivalShowEventPanelWork", SurvivalStepBaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)

	if arg_1_0._stepMo.panel.type == SurvivalEnum.PanelType.Search then
		local var_1_0 = SurvivalMapModel.instance:getSceneMo()
		local var_1_1 = var_1_0 and var_1_0.unitsById[arg_1_0._stepMo.panel.unitId]

		arg_1_0.isFirst = var_1_1 and var_1_1.extraParam ~= "true" or not var_1_1
	end
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0._stepMo.paramInt[1]
	local var_2_1 = arg_2_0._stepMo.panel

	if var_2_0 == 1 then
		SurvivalMapModel.instance:getSceneMo().panel = var_2_1

		if not ViewMgr.instance:isOpen(ViewName.SurvivalMapEventView) and var_2_1.type == SurvivalEnum.PanelType.TreeEvent then
			SurvivalStatHelper.instance:statSurvivalMapUnit("TriggerEvent", var_2_1.unitId)
		end
	elseif var_2_0 == 2 then
		SurvivalShelterModel.instance:getWeekInfo().panel = var_2_1
	end

	if not arg_2_0.context.fastExecute then
		SurvivalMapHelper.instance:tryShowServerPanel(var_2_1, arg_2_0.isFirst)
	end

	arg_2_0:onDone(true)
end

return var_0_0
