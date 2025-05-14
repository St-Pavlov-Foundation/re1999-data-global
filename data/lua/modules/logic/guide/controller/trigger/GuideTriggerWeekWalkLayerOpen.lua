module("modules.logic.guide.controller.trigger.GuideTriggerWeekWalkLayerOpen", package.seeall)

local var_0_0 = class("GuideTriggerWeekWalkLayerOpen", BaseGuideTrigger)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)
	WeekWalkController.instance:registerCallback(WeekWalkEvent.OnGetInfo, arg_1_0._checkStartGuide, arg_1_0)
	WeekWalkController.instance:registerCallback(WeekWalkEvent.OnWeekwalkInfoUpdate, arg_1_0._checkStartGuide, arg_1_0)
	GameSceneMgr.instance:registerCallback(SceneType.Main, arg_1_0._onMainScene, arg_1_0)
end

function var_0_0.assertGuideSatisfy(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = tonumber(arg_2_2)

	return (WeekWalkModel.instance:getMapInfo(var_2_0))
end

function var_0_0._onMainScene(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_2 == 1 then
		arg_3_0:checkStartGuide()
	end
end

function var_0_0._checkStartGuide(arg_4_0)
	arg_4_0:checkStartGuide()
end

return var_0_0
