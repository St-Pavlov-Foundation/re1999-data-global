module("modules.logic.guide.controller.action.impl.GuideActionAdditionCondition", package.seeall)

local var_0_0 = class("GuideActionAdditionCondition", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	local var_1_0 = string.split(arg_1_0.actionParam, "#")
	local var_1_1 = var_1_0[1]
	local var_1_2 = var_1_0[2]
	local var_1_3 = var_1_0[3]
	local var_1_4 = var_1_0[4]
	local var_1_5 = arg_1_0[var_1_1]

	if var_1_5 and var_1_5(arg_1_0, var_1_2) then
		arg_1_0:additionStepId(arg_1_0.sourceGuideId or arg_1_0.guideId, var_1_3)
	else
		arg_1_0:additionStepId(arg_1_0.sourceGuideId or arg_1_0.guideId, var_1_4)
	end

	arg_1_0:onDone(true)
end

function var_0_0.additionStepId(arg_2_0, arg_2_1, arg_2_2)
	if not arg_2_1 then
		return
	end

	local var_2_0 = GuideStepController.instance:getActionFlow(arg_2_1)

	if not var_2_0 then
		return
	end

	if not string.nilorempty(arg_2_2) then
		arg_2_2 = string.gsub(arg_2_2, "&", "|")
		arg_2_2 = string.gsub(arg_2_2, "*", "#")

		local var_2_1 = GuideActionBuilder.buildAction(arg_2_1, 0, arg_2_2)

		var_2_0:addWork(var_2_1)
	end
end

function var_0_0.checkRoomTaskHasFinished(arg_3_0)
	local var_3_0, var_3_1 = RoomSceneTaskController.instance:isFirstTaskFinished()

	return var_3_0
end

return var_0_0
