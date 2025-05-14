module("modules.logic.guide.controller.trigger.GuideTriggerRoomConfirmBuilding", package.seeall)

local var_0_0 = class("GuideTriggerRoomConfirmBuilding", BaseGuideTrigger)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)
	RoomBuildingController.instance:registerCallback(RoomEvent.ConfirmBuilding, arg_1_0._onConfirmBuilding, arg_1_0)
end

function var_0_0.assertGuideSatisfy(arg_2_0, arg_2_1, arg_2_2)
	return arg_2_1 == tonumber(arg_2_2)
end

function var_0_0._onConfirmBuilding(arg_3_0, arg_3_1)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		arg_3_0:checkStartGuide(arg_3_1)
	end
end

return var_0_0
