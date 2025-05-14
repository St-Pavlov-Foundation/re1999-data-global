module("modules.logic.guide.controller.action.impl.WaitGuideActionRoomCritterMood", package.seeall)

local var_0_0 = class("WaitGuideActionRoomCritterMood", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)
	CritterController.instance:registerCallback(CritterEvent.CritterInfoPushUpdate, arg_1_0._onCritterInfoPushUpdate, arg_1_0)

	arg_1_0._moodValue = tonumber(arg_1_0.actionParam)

	arg_1_0:_check()
end

function var_0_0._check(arg_2_0)
	if #CritterModel.instance:getMoodCritters(arg_2_0._moodValue) > 0 then
		arg_2_0:onDone(true)
	end
end

function var_0_0._onCritterInfoPushUpdate(arg_3_0)
	arg_3_0:_check()
end

function var_0_0.clearWork(arg_4_0)
	CritterController.instance:unregisterCallback(CritterEvent.CritterInfoPushUpdate, arg_4_0._onCritterInfoPushUpdate, arg_4_0)
end

return var_0_0
