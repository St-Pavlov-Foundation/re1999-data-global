module("modules.logic.guide.controller.action.impl.GuideActionExploreShowOutline", package.seeall)

local var_0_0 = class("GuideActionExploreShowOutline", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = string.splitToNumber(arg_1_0.actionParam, "#")
	local var_1_1 = var_1_0[1]
	local var_1_2 = var_1_0[2] == 1
	local var_1_3 = ExploreController.instance:getMap()

	if var_1_3 then
		local var_1_4 = var_1_3:getUnit(var_1_1)

		if var_1_4 then
			var_1_4:forceOutLine(var_1_2)
		end
	else
		logError("不在密室中？？？")
	end

	arg_1_0:onDone(true)
end

return var_0_0
