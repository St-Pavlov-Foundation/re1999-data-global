module("modules.logic.explore.controller.trigger.ExploreTriggerItem", package.seeall)

local var_0_0 = class("ExploreTriggerItem", ExploreTriggerBase)

function var_0_0.handle(arg_1_0, arg_1_1, arg_1_2)
	ExploreRpc.instance:sendExploreItemInteractRequest(arg_1_2.id, arg_1_1, arg_1_0.onRequestCallBack, arg_1_0)
end

function var_0_0.onReply(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if arg_2_2 == 0 then
		arg_2_0:onDone(true)
	end
end

return var_0_0
