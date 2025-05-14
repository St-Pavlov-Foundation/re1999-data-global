module("modules.logic.explore.controller.trigger.ExploreTriggerNormal", package.seeall)

local var_0_0 = class("ExploreTriggerNormal", ExploreTriggerBase)

function var_0_0.handle(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:sendTriggerRequest()
end

function var_0_0.onReply(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0:onDone(true)
end

return var_0_0
