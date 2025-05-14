module("modules.logic.versionactivity1_2.yaxian.controller.game.step.YaXianStepMove", package.seeall)

local var_0_0 = class("YaXianStepMove", YaXianStepBase)

function var_0_0.start(arg_1_0)
	local var_1_0 = YaXianGameController.instance:getInteractItem(arg_1_0.originData.id)

	if not var_1_0 then
		logError("not found interactObj, id : " .. tostring(arg_1_0.originData.id))
		arg_1_0:finish()
	end

	arg_1_0.interactItem = var_1_0

	local var_1_1 = var_1_0:getHandler()

	if var_1_1 then
		var_1_1:moveToFromMoveStep(arg_1_0.originData, arg_1_0.finish, arg_1_0)

		return
	end

	logError("interact not found handle, interactId : " .. arg_1_0.originData.id)
	arg_1_0:finish()
end

function var_0_0.finish(arg_2_0)
	var_0_0.super.finish(arg_2_0)
end

function var_0_0.dispose(arg_3_0)
	if arg_3_0.interactItem then
		local var_3_0 = arg_3_0.interactItem:getHandler()

		if var_3_0 then
			var_3_0:stopAllAction()
		end
	end
end

return var_0_0
