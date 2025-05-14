module("modules.logic.scene.room.fsm.RoomTransitionCancelPlaceBuilding", package.seeall)

local var_0_0 = class("RoomTransitionCancelPlaceBuilding", SimpleFSMBaseTransition)

function var_0_0.start(arg_1_0)
	arg_1_0._scene = GameSceneMgr.instance:getCurScene()
end

function var_0_0.check(arg_2_0)
	return true
end

function var_0_0.onStart(arg_3_0, arg_3_1)
	arg_3_0._param = arg_3_1

	local var_3_0 = RoomMapBuildingModel.instance:getTempBuildingMO()

	if var_3_0 then
		RoomBuildingController.instance:addWaitRefreshBuildingNearBlock(var_3_0.buildingId, var_3_0.hexPoint, var_3_0.rotate)

		local var_3_1 = arg_3_0._scene.buildingmgr:getBuildingEntity(var_3_0.id, SceneTag.RoomBuilding)

		RoomResourceModel.instance:clearLightResourcePoint()

		if var_3_0.buildingState == RoomBuildingEnum.BuildingState.Temp then
			RoomMapBuildingModel.instance:removeTempBuildingMO()

			if var_3_1 then
				local var_3_2 = var_3_1
				local var_3_3 = arg_3_0._scene.buildingmgr
				local var_3_4 = var_3_2:getAlphaThresholdValue() or 0
				local var_3_5 = 0.16666666666666666

				var_3_2:playAnimator("close")
				var_3_2:tweenAlphaThreshold(var_3_4, 1, var_3_5)
				var_3_3:removeUnitData(SceneTag.RoomBuilding, var_3_0.id)
				var_3_2:removeEvent()
				TaskDispatcher.runDelay(function()
					var_3_3:destroyUnit(var_3_2)
				end, arg_3_0, var_3_5 + 0.01)
			end
		elseif var_3_0.buildingState == RoomBuildingEnum.BuildingState.Revert then
			local var_3_6, var_3_7, var_3_8 = RoomMapBuildingModel.instance:removeRevertBuildingMO()

			if var_3_1 then
				arg_3_0._scene.buildingmgr:moveTo(var_3_1, var_3_7)
				var_3_1:refreshRotation()
				var_3_1:refreshBuilding()
			end

			RoomBuildingController.instance:dispatchEvent(RoomEvent.BuildingUIRefreshUI, var_3_0.id)
			RoomBuildingController.instance:addWaitRefreshBuildingNearBlock(var_3_6, var_3_7, var_3_8)
		end

		RoomBuildingController.instance:cancelPressBuilding()
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.RefreshResourceUIShow)
	RoomShowBuildingListModel.instance:clearSelect()
	arg_3_0:onDone()
	RoomBuildingController.instance:dispatchEvent(RoomEvent.ClientCancelBuilding)
	RoomMapController.instance:dispatchEvent(RoomEvent.BuildingCanConfirm)
	RoomBuildingController.instance:refreshBuildingOccupy()
end

function var_0_0.stop(arg_5_0)
	return
end

function var_0_0.clear(arg_6_0)
	return
end

return var_0_0
