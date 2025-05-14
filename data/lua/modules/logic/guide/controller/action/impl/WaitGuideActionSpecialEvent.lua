module("modules.logic.guide.controller.action.impl.WaitGuideActionSpecialEvent", package.seeall)

local var_0_0 = class("WaitGuideActionSpecialEvent", BaseGuideAction)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	local var_1_0 = string.split(arg_1_3, "#")

	arg_1_0._eventName = #var_1_0 >= 1 and var_1_0[1]
	arg_1_0._eventEnum = arg_1_0._eventName and GuideEnum.SpecialEventEnum[arg_1_0._eventName] or 0
	arg_1_0._guideId = arg_1_1
	arg_1_0._stepId = arg_1_2
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	var_0_0.super.onStart(arg_2_0, arg_2_1)

	if arg_2_0._eventEnum == 0 then
		logError("找不到特殊事件: " .. tostring(arg_2_0._eventName))
		arg_2_0:onDone(true)

		return
	end

	GuideController.instance:registerCallback(GuideEvent.SpecialEventDone, arg_2_0._onEventDone, arg_2_0)
	GuideController.instance:dispatchEvent(GuideEvent.SpecialEventStart, arg_2_0._eventEnum, arg_2_0._guideId, arg_2_0._stepId)
end

function var_0_0._onEventDone(arg_3_0, arg_3_1)
	if arg_3_0._eventEnum == arg_3_1 then
		GuideController.instance:unregisterCallback(GuideEvent.SpecialEventDone, arg_3_0._onEventDone, arg_3_0)
		arg_3_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_4_0)
	GuideController.instance:unregisterCallback(GuideEvent.SpecialEventDone, arg_4_0._onEventDone, arg_4_0)
end

return var_0_0
