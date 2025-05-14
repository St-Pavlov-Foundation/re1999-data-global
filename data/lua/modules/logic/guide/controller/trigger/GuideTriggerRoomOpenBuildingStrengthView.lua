module("modules.logic.guide.controller.trigger.GuideTriggerRoomOpenBuildingStrengthView", package.seeall)

local var_0_0 = class("GuideTriggerRoomOpenBuildingStrengthView", BaseGuideTrigger)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)
end

function var_0_0.assertGuideSatisfy(arg_2_0, arg_2_1, arg_2_2)
	return GameSceneMgr.instance:getCurSceneType() == SceneType.Room
end

function var_0_0._onOpenBuildingStrengthView(arg_3_0, arg_3_1)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		arg_3_0:checkStartGuide(arg_3_1)
	end
end

return var_0_0
