module("modules.logic.explore.controller.trigger.ExploreTriggerDialogue", package.seeall)

local var_0_0 = class("ExploreTriggerDialogue", ExploreTriggerBase)

function var_0_0.handle(arg_1_0, arg_1_1, arg_1_2)
	arg_1_1 = tonumber(arg_1_1)

	if arg_1_0.isNoFirstDialog then
		local var_1_0 = {
			alwaysLast = true,
			stepType = ExploreEnum.StepType.Dialogue,
			id = arg_1_1
		}

		ExploreStepController.instance:insertClientStep(var_1_0)
		arg_1_0:onDone(true)

		return
	end

	local var_1_1 = {
		id = arg_1_1,
		unit = arg_1_2,
		callBack = arg_1_0.dialogueAccept,
		callBackObj = arg_1_0,
		refuseCallBack = arg_1_0.dialogueRefuse,
		refuseCallBackObj = arg_1_0
	}

	ViewMgr.instance:openView(ViewName.ExploreInteractView, var_1_1)
	ExploreController.instance:getMap():getHero():stopMoving(false)
end

function var_0_0.dialogueAccept(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.dialogueRefuse(arg_3_0)
	arg_3_0:onDone(false)
end

function var_0_0.clearWork(arg_4_0)
	ViewMgr.instance:closeView(ViewName.ExploreInteractView)
end

return var_0_0
