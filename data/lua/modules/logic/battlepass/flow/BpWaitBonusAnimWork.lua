module("modules.logic.battlepass.flow.BpWaitBonusAnimWork", package.seeall)

local var_0_0 = class("BpWaitBonusAnimWork", BaseWork)

function var_0_0.onStart(arg_1_0)
	if not BpModel.instance.preStatus or not ViewMgr.instance:isOpen(ViewName.BpView) then
		arg_1_0:onDone(true)
	else
		BpController.instance:registerCallback(BpEvent.BonusAnimEnd, arg_1_0.onAnimDone, arg_1_0)
		BpController.instance:dispatchEvent(BpEvent.ForcePlayBonusAnim)
	end
end

function var_0_0.onAnimDone(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	BpController.instance:unregisterCallback(BpEvent.BonusAnimEnd, arg_3_0.onAnimDone, arg_3_0)
end

return var_0_0
