module("modules.logic.explore.controller.trigger.ExploreTriggerBonusScene", package.seeall)

local var_0_0 = class("ExploreTriggerBonusScene", ExploreTriggerBase)

function var_0_0.handle(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = tonumber(arg_1_2.mo.specialDatas[1])
	local var_1_1 = {
		id = var_1_0,
		unit = arg_1_2,
		callBack = arg_1_0.onFinish,
		callBackObj = arg_1_0
	}

	ViewMgr.instance:openView(ViewName.ExploreBonusSceneView, var_1_1)
end

function var_0_0.onFinish(arg_2_0, arg_2_1)
	ExploreSimpleModel.instance:onGetBonus(tonumber(arg_2_0._unit.mo.specialDatas[1]), arg_2_1)

	local var_2_0 = {
		stepType = ExploreEnum.StepType.BonusSceneClient
	}

	ExploreStepController.instance:insertClientStep(var_2_0, 1)
	arg_2_0:sendTriggerRequest(table.concat(arg_2_1, "#"))
end

function var_0_0.clearWork(arg_3_0)
	ViewMgr.instance:closeView(ViewName.ExploreBonusSceneView)
end

return var_0_0
