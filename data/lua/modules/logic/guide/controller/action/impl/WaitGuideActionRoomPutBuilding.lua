module("modules.logic.guide.controller.action.impl.WaitGuideActionRoomPutBuilding", package.seeall)

local var_0_0 = class("WaitGuideActionRoomPutBuilding", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	arg_1_0._sceneType = SceneType.Room

	var_0_0.super.onStart(arg_1_0, arg_1_1)
	RoomMapController.instance:registerCallback(RoomEvent.UseBuildingReply, arg_1_0._onUseBuildingReply, arg_1_0)
	GameSceneMgr.instance:registerCallback(arg_1_0._sceneType, arg_1_0._onEnterScene, arg_1_0)

	local var_1_0 = string.splitToNumber(arg_1_0.actionParam, "#")

	arg_1_0._buildingId = var_1_0[1]
	arg_1_0._notAutoPutBuilding = var_1_0[2] == 1
	arg_1_0._toastId = var_1_0[3]

	arg_1_0:_check()
end

function var_0_0._check(arg_2_0)
	if arg_2_0._waitUseBuildingReply or arg_2_0._waitManufactureBuildingInfoChange then
		return
	end

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Room then
		return
	end

	local var_2_0 = RoomModel.instance:getBuildingInfoList()
	local var_2_1

	if var_2_0 then
		for iter_2_0, iter_2_1 in pairs(var_2_0) do
			if iter_2_1.buildingId == arg_2_0._buildingId then
				var_2_1 = iter_2_1

				break
			end
		end
	end

	if var_2_1 and var_2_1.use then
		arg_2_0:onDone(true)
	elseif var_2_1 then
		if not arg_2_0._notAutoPutBuilding then
			arg_2_0:putBuilding(var_2_1)
		elseif arg_2_0._toastId then
			GameFacade.showToast(arg_2_0._toastId)
		end
	else
		arg_2_0:onDone(true)
	end
end

function var_0_0._onUseBuildingReply(arg_3_0)
	arg_3_0._waitUseBuildingReply = false

	arg_3_0:_check()
end

function var_0_0._onManufactureBuildingInfoChange(arg_4_0)
	arg_4_0._waitManufactureBuildingInfoChange = false

	arg_4_0:_check()
end

function var_0_0._onEnterScene(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_2 == 1 then
		arg_5_0:_check()
	end
end

function var_0_0.clearWork(arg_6_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.UseBuildingReply, arg_6_0._onUseBuildingReply, arg_6_0)
	GameSceneMgr.instance:unregisterCallback(arg_6_0._sceneType, arg_6_0._onEnterScene, arg_6_0)
	ManufactureController.instance:unregisterCallback(ManufactureEvent.ManufactureBuildingInfoChange, arg_6_0._onManufactureBuildingInfoChange, arg_6_0)
end

function var_0_0.putBuilding(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.uid
	local var_7_1 = arg_7_0:getNearRotate(arg_7_0._buildingId)
	local var_7_2 = RoomBuildingHelper.getRecommendHexPoint(arg_7_0._buildingId, nil, nil, nil, var_7_1)
	local var_7_3 = var_7_2 and var_7_2.rotate or var_7_1
	local var_7_4 = var_7_2 and var_7_2.hexPoint

	if var_7_4 then
		local var_7_5 = {
			buildingUid = var_7_0,
			hexPoint = var_7_4,
			rotate = var_7_3
		}

		RoomCameraController.instance:getRoomScene().fsm:triggerEvent(RoomSceneEvent.TryPlaceBuilding, var_7_5)

		arg_7_0._waitUseBuildingReply = true

		if arg_7_0._buildingId == 22001 then
			arg_7_0._waitManufactureBuildingInfoChange = true

			ManufactureController.instance:registerCallback(ManufactureEvent.ManufactureBuildingInfoChange, arg_7_0._onManufactureBuildingInfoChange, arg_7_0)
		end

		RoomMapController.instance:useBuildingRequest(var_7_0, var_7_3, var_7_4.x, var_7_4.y)
	else
		arg_7_0:onDone(true)
	end
end

function var_0_0.getNearRotate(arg_8_0, arg_8_1)
	local var_8_0 = RoomCameraController.instance:getRoomScene().camera:getCameraRotate() * Mathf.Rad2Deg

	return RoomRotateHelper.getCameraNearRotate(var_8_0) + RoomConfig.instance:getBuildingConfig(arg_8_1).rotate
end

return var_0_0
