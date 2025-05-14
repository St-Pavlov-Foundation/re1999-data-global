module("modules.logic.scene.room.fsm.RoomTransitionConfirmPlaceBuilding", package.seeall)

local var_0_0 = class("RoomTransitionConfirmPlaceBuilding", SimpleFSMBaseTransition)

function var_0_0.start(arg_1_0)
	arg_1_0._scene = GameSceneMgr.instance:getCurScene()
end

function var_0_0.check(arg_2_0)
	return true
end

function var_0_0.onStart(arg_3_0, arg_3_1)
	arg_3_0._param = arg_3_1

	local var_3_0 = arg_3_0._param.buildingInfo
	local var_3_1 = arg_3_0._param.tempBuildingMO

	RoomBuildingController.instance:addWaitRefreshBuildingNearBlock(var_3_1.buildingId, var_3_1.hexPoint, var_3_1.rotate)

	local var_3_2 = arg_3_0._scene.buildingmgr:getBuildingEntity(var_3_1.id, SceneTag.RoomBuilding)

	if var_3_2 then
		arg_3_0._scene.buildingmgr:moveTo(var_3_2, var_3_1.hexPoint)
		var_3_2:refreshBuilding()
		var_3_2:refreshRotation()
		var_3_2:playSmokeEffect()
	end

	RoomBuildingController.instance:cancelPressBuilding()
	RoomResourceModel.instance:clearLightResourcePoint()
	RoomBuildingController.instance:dispatchEvent(RoomEvent.BuildingUIRefreshUI, var_3_1.id)
	RoomShowBuildingListModel.instance:clearSelect()
	RoomBuildingController.instance:dispatchEvent(RoomEvent.ConfirmBuilding, var_3_0.defineId)
	RoomMapController.instance:dispatchEvent(RoomEvent.RefreshResourceUIShow)
	arg_3_0:onDone()
	RoomMapController.instance:dispatchEvent(RoomEvent.BuildingCanConfirm)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_board_fix)
	RoomBuildingController.instance:refreshBuildingOccupy()
end

function var_0_0.stop(arg_4_0)
	return
end

function var_0_0.clear(arg_5_0)
	return
end

return var_0_0
