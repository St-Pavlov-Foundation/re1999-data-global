module("modules.logic.guide.controller.trigger.GuideTriggerRoomCheckGatherFactoryNum", package.seeall)

local var_0_0 = class("GuideTriggerRoomCheckGatherFactoryNum", BaseGuideTrigger)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)
	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, arg_1_0._onEnterOneSceneFinish, arg_1_0)
	RoomMapController.instance:registerCallback(RoomEvent.UseBuildingReply, arg_1_0._onUseBuildingReply, arg_1_0)
end

function var_0_0._onUseBuildingReply(arg_2_0)
	arg_2_0:checkStartGuide(SceneType.Room)
end

function var_0_0.assertGuideSatisfy(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_1 == SceneType.Room
	local var_3_1 = RoomController.instance:isObMode()

	if not var_3_0 or not var_3_1 then
		return
	end

	local var_3_2 = RoomMapBuildingModel.instance:getBuildingMOList()
	local var_3_3 = 0

	for iter_3_0, iter_3_1 in ipairs(var_3_2) do
		if iter_3_1.config.buildingType == RoomBuildingEnum.BuildingType.Gather and iter_3_1.buildingState == RoomBuildingEnum.BuildingState.Map then
			var_3_3 = var_3_3 + 1
		end
	end

	return var_3_3 >= 4
end

function var_0_0._onEnterOneSceneFinish(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:checkStartGuide(arg_4_1)
end

return var_0_0
