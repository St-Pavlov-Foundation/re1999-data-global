module("modules.logic.guide.controller.action.impl.GuideActionExploreUseItem", package.seeall)

local var_0_0 = class("GuideActionExploreUseItem", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = string.splitToNumber(arg_1_0.actionParam, "#")
	local var_1_1 = var_1_0[1]
	local var_1_2 = var_1_0[2] == 1
	local var_1_3 = ExploreBackpackModel.instance:getItem(var_1_1)

	if var_1_3 and ExploreModel.instance:getUseItemUid() == var_1_3.id ~= var_1_2 then
		ExploreRpc.instance:sendExploreUseItemRequest(var_1_3.id, 0, 0)
	end

	arg_1_0:onDone(true)
end

return var_0_0
