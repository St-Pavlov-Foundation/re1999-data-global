module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114AnswerWork", package.seeall)

local var_0_0 = class("Activity114AnswerWork", Activity114OpenViewWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	if Activity114Model.instance.serverData.testEventId > 0 then
		arg_1_0._viewName = ViewName.Activity114EventSelectView

		var_0_0.super.onStart(arg_1_0, arg_1_1)
	else
		arg_1_0.context.result = Activity114Enum.Result.Success

		arg_1_0:onDone(true)
	end
end

return var_0_0
