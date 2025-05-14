module("modules.logic.scene.room.fsm.RoomTransitionUnUseBuilding", package.seeall)

local var_0_0 = class("RoomTransitionUnUseBuilding", SimpleFSMBaseTransition)

function var_0_0.start(arg_1_0)
	arg_1_0._scene = GameSceneMgr.instance:getCurScene()
end

function var_0_0.check(arg_2_0)
	return true
end

function var_0_0.onStart(arg_3_0, arg_3_1)
	arg_3_0._param = arg_3_1

	local var_3_0 = arg_3_0._param.buildingInfos
	local var_3_1 = RoomMapBuildingModel.instance:getTempBuildingMO()
	local var_3_2 = {}
	local var_3_3 = {}
	local var_3_4

	for iter_3_0 = 1, #var_3_0 do
		local var_3_5 = arg_3_0._scene.buildingmgr:getBuildingEntity(var_3_0[iter_3_0].uid, SceneTag.RoomBuilding)

		if var_3_5 then
			var_3_5:refreshRotation()
			var_3_5:refreshBuilding()

			local var_3_6 = var_3_5:getMO()

			arg_3_0._scene.buildingmgr:destroyBuilding(var_3_5)

			if var_3_6 then
				RoomBuildingController.instance:addWaitRefreshBuildingNearBlock(var_3_6.buildingId, var_3_6.hexPoint, var_3_6.rotate)
				RoomCharacterController.instance:interruptInteraction(var_3_6:getCurrentInteractionId())
			end

			RoomMapBuildingModel.instance:removeBuildingMO(var_3_6)

			if var_3_1 and var_3_1.id == var_3_5.id then
				RoomMapBuildingModel.instance:removeTempBuildingMO()
			end
		end
	end

	arg_3_0:onDone()
	RoomMapBuildingModel.instance:refreshAllOccupyDict()
	RoomBuildingController.instance:cancelPressBuilding()
	RoomResourceModel.instance:clearLightResourcePoint()
	RoomShowBuildingListModel.instance:clearSelect()
	RoomBuildingController.instance:dispatchEvent(RoomEvent.UnUseBuilding)
	RoomMapController.instance:dispatchEvent(RoomEvent.RefreshResourceUIShow)
	RoomMapController.instance:dispatchEvent(RoomEvent.BuildingCanConfirm)
	RoomBuildingController.instance:refreshBuildingOccupy()
end

function var_0_0._addBlockEntityList(arg_4_0, arg_4_1, arg_4_2)
	arg_4_1 = arg_4_1 or {}

	local var_4_0

	for iter_4_0 = 1, #arg_4_2 do
		local var_4_1 = arg_4_2[iter_4_0]

		if not tabletool.indexOf(arg_4_1, var_4_1) then
			table.insert(arg_4_1, var_4_1)
		end
	end

	return arg_4_1
end

function var_0_0.stop(arg_5_0)
	return
end

function var_0_0.clear(arg_6_0)
	return
end

return var_0_0
