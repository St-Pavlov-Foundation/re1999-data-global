module("modules.logic.guide.controller.action.impl.GuideActionCloseView", package.seeall)

local var_0_0 = class("GuideActionCloseView", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	if string.nilorempty(arg_1_0.actionParam) then
		ViewMgr.instance:closeAllModalViews()
	else
		local var_1_0 = string.split(arg_1_0.actionParam, "#")

		for iter_1_0, iter_1_1 in ipairs(var_1_0) do
			ViewMgr.instance:closeView(iter_1_1, true)
		end
	end

	arg_1_0:onDone(true)
end

return var_0_0
