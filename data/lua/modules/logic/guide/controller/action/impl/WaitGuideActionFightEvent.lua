module("modules.logic.guide.controller.action.impl.WaitGuideActionFightEvent", package.seeall)

local var_0_0 = class("WaitGuideActionFightEvent", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	arg_1_0._eventName = FightEvent[arg_1_0.actionParam]

	if not arg_1_0._eventName then
		logError("WaitGuideActionFightEvent param error:" .. tostring(arg_1_0.actionParam))

		return
	end

	FightController.instance:registerCallback(arg_1_0._eventName, arg_1_0._onReceiveFightEvent, arg_1_0)
end

function var_0_0._onReceiveFightEvent(arg_2_0)
	FightController.instance:unregisterCallback(arg_2_0._eventName, arg_2_0._onReceiveFightEvent, arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	FightController.instance:unregisterCallback(arg_3_0._eventName, arg_3_0._onReceiveFightEvent, arg_3_0)
end

return var_0_0
