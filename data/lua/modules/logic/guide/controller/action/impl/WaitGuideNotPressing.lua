module("modules.logic.guide.controller.action.impl.WaitGuideNotPressing", package.seeall)

local var_0_0 = class("WaitGuideNotPressing", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	if GamepadController.instance:isOpen() then
		arg_1_0:onDone(true)
	elseif arg_1_0:_notPressing() then
		arg_1_0:onDone(true)
	else
		TaskDispatcher.runRepeat(arg_1_0._onFrame, arg_1_0, 0.01)
	end
end

function var_0_0.clearWork(arg_2_0)
	TaskDispatcher.cancelTask(arg_2_0._onFrame, arg_2_0)
end

function var_0_0._onFrame(arg_3_0)
	if arg_3_0:_notPressing() then
		arg_3_0:onDone(true)
	end
end

function var_0_0._notPressing(arg_4_0)
	return not (UnityEngine.Input.touchCount > 0)
end

return var_0_0
