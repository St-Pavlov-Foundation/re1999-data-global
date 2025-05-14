module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114CheckWork", package.seeall)

local var_0_0 = class("Activity114CheckWork", Activity114OpenViewWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0.context.eventCo

	if var_1_0.config.isCheckEvent == 1 or var_1_0.config.testId > 0 and Activity114Model.instance.serverData.testEventId <= 0 then
		arg_1_0._viewName = ViewName.Activity114EventSelectView

		var_0_0.super.onStart(arg_1_0, arg_1_1)
	elseif Activity114Model.instance.serverData.checkEventId > 0 then
		Activity114Rpc.instance:checkRequest(Activity114Model.instance.id, true, arg_1_0.onCheckDone, arg_1_0)
	else
		arg_1_0.context.result = Activity114Enum.Result.Success

		arg_1_0:onDone(true)
	end
end

function var_0_0.onCheckDone(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0:onDone(arg_2_2 == 0)
end

return var_0_0
