module("modules.logic.guide.controller.trigger.GuideTriggerRoomLv", package.seeall)

local var_0_0 = class("GuideTriggerRoomLv", BaseGuideTrigger)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)
	RoomMapController.instance:registerCallback(RoomEvent.UpdateRoomLevel, arg_1_0._checkStartGuide, arg_1_0)
	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, arg_1_0._onEnterOneSceneFinish, arg_1_0)
end

function var_0_0.assertGuideSatisfy(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_1 == SceneType.Room
	local var_2_1 = tonumber(arg_2_2)

	return var_2_0 and var_2_1 <= arg_2_0:getParam()
end

function var_0_0.getParam(arg_3_0)
	return RoomMapModel.instance:getRoomLevel()
end

function var_0_0._onEnterOneSceneFinish(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:checkStartGuide(arg_4_1)
end

function var_0_0._checkStartGuide(arg_5_0)
	local var_5_0 = GameSceneMgr.instance:getCurSceneType()

	if var_5_0 == SceneType.Room then
		arg_5_0:checkStartGuide(var_5_0)
	end
end

return var_0_0
