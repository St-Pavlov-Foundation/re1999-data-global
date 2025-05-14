module("modules.logic.guide.controller.trigger.GuideTriggerRoomEnterEdit", package.seeall)

local var_0_0 = class("GuideTriggerRoomEnterEdit", BaseGuideTrigger)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)
	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, arg_1_0._onEnterOneSceneFinish, arg_1_0)
end

function var_0_0.assertGuideSatisfy(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_1 == SceneType.Room
	local var_2_1 = RoomController.instance:isEditMode()

	return var_2_0 and var_2_1
end

function var_0_0._onEnterOneSceneFinish(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:checkStartGuide(arg_3_1)
end

return var_0_0
