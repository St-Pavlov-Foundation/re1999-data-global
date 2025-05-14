module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114OpenAttrViewWork", package.seeall)

local var_0_0 = class("Activity114OpenAttrViewWork", Activity114OpenViewWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	if not Activity114Helper.haveAttrOrFeatureChange(arg_1_0.context) then
		arg_1_0:onDone(true)

		return
	end

	arg_1_0._viewName = ViewName.Activity114FinishEventView

	var_0_0.super.onStart(arg_1_0, arg_1_1)
end

return var_0_0
