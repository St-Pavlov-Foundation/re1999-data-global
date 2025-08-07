module("modules.logic.sp01.odyssey.view.work.OdysseyCheckCloseRewardWork", package.seeall)

local var_0_0 = class("OdysseyCheckCloseRewardWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.nextElementId = arg_1_1
	arg_1_0.isForceFocus = arg_1_2

	OdysseyDungeonController.instance:registerCallback(OdysseyEvent.OnCloseDungeonRewardView, arg_1_0.onSetDone, arg_1_0)
end

function var_0_0.onStart(arg_2_0)
	if not OdysseyDungeonController.instance:checkNeedPopupRewardView() then
		arg_2_0:onSetDone()
	end
end

function var_0_0.onSetDone(arg_3_0)
	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnFocusElement, arg_3_0.nextElementId, arg_3_0.isForceFocus)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	OdysseyDungeonController.instance:unregisterCallback(OdysseyEvent.OnCloseDungeonRewardView, arg_4_0.onSetDone, arg_4_0)
end

return var_0_0
