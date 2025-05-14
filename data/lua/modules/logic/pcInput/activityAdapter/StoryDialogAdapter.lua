module("modules.logic.pcInput.activityAdapter.StoryDialogAdapter", package.seeall)

local var_0_0 = class("StoryDialogAdapter", BaseActivityAdapter)

var_0_0.keytoFunction = {
	Space = function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyStoryDialogNext)
	end,
	F1 = function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyStoryDialogAuto)
	end,
	F2 = function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyStoryDialogSkip)
	end,
	F3 = function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyStoryDialogExit)
	end,
	Alpha1 = function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyStoryDialogSelect, 1)
	end,
	Alpha2 = function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyStoryDialogSelect, 2)
	end,
	Alpha3 = function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyStoryDialogSelect, 3)
	end
}

function var_0_0.ctor(arg_8_0)
	arg_8_0.keytoFunction = var_0_0.keytoFunction

	arg_8_0:registerFunction()
end

function var_0_0.registerFunction(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.keytoFunction) do
		PCInputController.instance:registerKey(iter_9_0, ZProj.PCInputManager.PCInputEvent.KeyUp)
	end
end

function var_0_0.unRegisterFunction(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.keytoFunction) do
		PCInputController.instance:unregisterKey(iter_10_0, ZProj.PCInputManager.PCInputEvent.KeyUp)
	end
end

function var_0_0.OnkeyUp(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.keytoFunction[arg_11_1]

	if var_11_0 then
		var_11_0()
	end
end

function var_0_0.OnkeyDown(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.keytoFunction[arg_12_1]

	if var_12_0 then
		var_12_0()
	end
end

function var_0_0.destroy(arg_13_0)
	arg_13_0:unRegisterFunction()
end

return var_0_0
