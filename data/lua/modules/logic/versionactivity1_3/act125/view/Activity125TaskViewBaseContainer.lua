module("modules.logic.versionactivity1_3.act125.view.Activity125TaskViewBaseContainer", package.seeall)

local var_0_0 = class("Activity125TaskViewBaseContainer", Activity125ViewBaseContainer)

function var_0_0.onContainerInit(arg_1_0)
	var_0_0.super.onContainerInit(arg_1_0)

	arg_1_0._taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(arg_1_0._taskScrollView)

	arg_1_0._taskAnimRemoveItem:setMoveInterval(0)
end

function var_0_0.removeByIndex(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0._taskAnimRemoveItem:removeByIndex(arg_2_1, arg_2_2, arg_2_3)
end

return var_0_0
