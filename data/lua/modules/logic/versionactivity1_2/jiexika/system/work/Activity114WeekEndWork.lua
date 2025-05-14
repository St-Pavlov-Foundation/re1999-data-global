module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114WeekEndWork", package.seeall)

local var_0_0 = class("Activity114WeekEndWork", Activity114OpenViewWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	arg_1_0._viewName = ViewName.Activity114ScoreReportView

	var_0_0.super.onStart(arg_1_0, arg_1_1)
end

return var_0_0
