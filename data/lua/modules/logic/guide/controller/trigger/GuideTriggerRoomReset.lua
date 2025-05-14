module("modules.logic.guide.controller.trigger.GuideTriggerRoomReset", package.seeall)

local var_0_0 = class("GuideTriggerRoomReset", BaseGuideTrigger)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)
	RoomMapController.instance:registerCallback(RoomEvent.Reset, arg_1_0._onReset, arg_1_0)
end

function var_0_0.assertGuideSatisfy(arg_2_0, arg_2_1, arg_2_2)
	return GameSceneMgr.instance:getCurSceneType() == SceneType.Room
end

function var_0_0._onReset(arg_3_0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		arg_3_0:checkStartGuide()
	end
end

return var_0_0
