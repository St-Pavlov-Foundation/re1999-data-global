module("modules.logic.fight.system.work.FightWorkOpenLoadingBlackView", package.seeall)

local var_0_0 = class("FightWorkOpenLoadingBlackView", BaseWork)
local var_0_1 = 0.5

function var_0_0.onStart(arg_1_0, arg_1_1)
	if GameGlobalMgr.instance:getLoadingState():getLoadingType() == GameLoadingState.LoadingBlackView then
		arg_1_0._openViewTime = BaseViewContainer.openViewTime
		BaseViewContainer.openViewTime = var_0_1

		TaskDispatcher.runDelay(arg_1_0._delayDone, arg_1_0, var_0_1)
		ViewMgr.instance:openView(ViewName.LoadingBlackView)
	else
		arg_1_0:onDone(true)
	end
end

function var_0_0._delayDone(arg_2_0)
	BaseViewContainer.openViewTime = arg_2_0._openViewTime

	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._delayDone, arg_3_0)
end

return var_0_0
