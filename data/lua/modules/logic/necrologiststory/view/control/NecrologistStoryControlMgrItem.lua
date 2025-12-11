module("modules.logic.necrologiststory.view.control.NecrologistStoryControlMgrItem", package.seeall)

local var_0_0 = class("NecrologistStoryControlMgrItem", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.mgrComp = arg_1_1
end

function var_0_0.setStoryId(arg_2_0, arg_2_1)
	arg_2_0.storyId = arg_2_1
end

function var_0_0.setParam(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0.controlParam = arg_3_1
	arg_3_0.controlDelay = arg_3_2
	arg_3_0.isSkip = arg_3_3
	arg_3_0.fromItem = arg_3_4
	arg_3_0._isFinish = false

	if arg_3_0.fromItem then
		arg_3_0:addEventCb(NecrologistStoryController.instance, NecrologistStoryEvent.OnStoryItemClickNext, arg_3_0.onStoryItemClickNextInternal, arg_3_0)
	end
end

function var_0_0.playControl(arg_4_0)
	local var_4_0 = tonumber(arg_4_0.controlDelay)

	if var_4_0 and var_4_0 > 0 and not arg_4_0.isSkip then
		TaskDispatcher.runDelay(arg_4_0.onPlayControl, arg_4_0, var_4_0)
		arg_4_0:onPlayControlFinish()
	else
		arg_4_0:onPlayControl()
	end
end

function var_0_0.getControlItem(arg_5_0, arg_5_1)
	arg_5_0.mgrComp:createControlItem(arg_5_1, arg_5_0.storyId, arg_5_0.controlParam, arg_5_0.onPlayControlFinish, arg_5_0)
end

function var_0_0.isFinish(arg_6_0)
	return arg_6_0._isFinish
end

function var_0_0.onPlayControl(arg_7_0)
	return
end

function var_0_0.onPlayControlFinish(arg_8_0)
	if arg_8_0._isFinish then
		return
	end

	arg_8_0._isFinish = true

	arg_8_0.mgrComp:onItemFinish(arg_8_0)
end

function var_0_0.onStoryItemClickNextInternal(arg_9_0, arg_9_1)
	if arg_9_1 ~= arg_9_0.storyId then
		return
	end

	arg_9_0:onStoryItemClickNext()
end

function var_0_0.onStoryItemClickNext(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0.onPlayControl, arg_10_0)
end

function var_0_0.onDestory(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0.onPlayControl, arg_11_0)
	arg_11_0:__onDispose()
end

return var_0_0
