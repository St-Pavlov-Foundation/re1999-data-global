module("modules.logic.room.controller.RoomInteractionController", package.seeall)

local var_0_0 = class("RoomInteractionController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clear()
end

function var_0_0.clear(arg_3_0)
	RoomMapInteractionModel.instance:clear()
end

function var_0_0.init(arg_4_0)
	RoomMapInteractionModel.instance:initInteraction()
end

function var_0_0.tickRunInteraction(arg_5_0)
	local var_5_0 = RoomMapInteractionModel.instance:getBuildingInteractionMOList()

	for iter_5_0 = 1, #var_5_0 do
		local var_5_1 = var_5_0[iter_5_0]

		if var_5_1.hasInteraction and arg_5_0:showTimeByInteractionMO(var_5_1) then
			break
		end
	end
end

function var_0_0.gainAllCharacterFaith(arg_6_0)
	local var_6_0 = RoomMapInteractionModel.instance:getBuildingInteractionMOList()

	for iter_6_0 = 1, #var_6_0 do
		local var_6_1 = var_6_0[iter_6_0]

		if var_6_1.hasInteraction and arg_6_0:showTimeByInteractionMO(var_6_1) then
			var_6_1.hasInteraction = false

			break
		end
	end
end

function var_0_0.showTimeByInteractionMO(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0, var_7_1 = arg_7_1:getInteractionBuilingUidAndCarmeraId()

	if var_7_0 and var_7_1 then
		arg_7_1.hasInteraction = false

		GameSceneMgr.instance:getCurScene().fsm:triggerEvent(RoomSceneEvent.CharacterBuildingShowTime, {
			buildingUid = var_7_0,
			buildingId = arg_7_1.config.buildingId,
			heroId = arg_7_1.config.heroId,
			id = arg_7_1.config.id,
			cameraId = var_7_1,
			faithOp = arg_7_2
		})

		return true
	end

	return false
end

function var_0_0.refreshCharacterBuilding(arg_8_0)
	local var_8_0 = RoomMapInteractionModel.instance:getBuildingInteractionMOList()

	for iter_8_0 = 1, #var_8_0 do
		local var_8_1 = var_8_0[iter_8_0]

		if not var_8_1.hasInteraction then
			var_8_1.hasInteraction = var_8_1:isCanByRandom()
		end

		if var_8_1.hasInteraction and not RoomConditionHelper.isConditionStr(var_8_1.config and var_8_1.config.conditionStr) then
			var_8_1.hasInteraction = false
		end
	end
end

function var_0_0.tryPlaceCharacterInteraction(arg_9_0)
	local var_9_0 = RoomMapInteractionModel.instance:getBuildingInteractionMOList()

	for iter_9_0 = 1, #var_9_0 do
		local var_9_1 = var_9_0[iter_9_0]
		local var_9_2 = false

		if var_9_1.hasInteraction and RoomConditionHelper.isConditionStr(var_9_1.config and var_9_1.config.conditionStr) then
			local var_9_3 = var_9_1:getBuildingNodeList()
			local var_9_4 = var_9_1:getBuildingUids()

			for iter_9_1, iter_9_2 in ipairs(var_9_4) do
				if arg_9_0:_tryPlaceCharacterById(iter_9_2, var_9_1.config.heroId, var_9_3) then
					var_9_2 = true

					break
				end
			end
		end

		var_9_1.hasInteraction = var_9_2
	end
end

function var_0_0._tryPlaceCharacterById(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = RoomCharacterModel.instance:getCharacterMOById(arg_10_2)

	if not var_10_0 then
		logNormal(string.format("找不到角色:%s", arg_10_2))

		return nil
	end

	local var_10_1 = GameSceneMgr.instance:getCurScene()

	if not var_10_1 or not var_10_1.buildingmgr then
		return nil
	end

	local var_10_2 = var_10_1.buildingmgr:getBuildingEntity(arg_10_1, SceneTag.RoomBuilding)

	if not var_10_2 then
		logNormal(string.format("找不到建筑:%s", arg_10_1))

		return
	end

	for iter_10_0, iter_10_1 in ipairs(arg_10_3) do
		local var_10_3 = var_10_2:transformPoint(iter_10_1[1], 0, iter_10_1[3])
		local var_10_4 = Vector2.New(var_10_3.x, var_10_3.z)
		local var_10_5 = RoomCharacterHelper.getRecommendHexPoint(var_10_0.heroId, var_10_0.skinId, var_10_4)

		if var_10_5 and var_10_5.position then
			var_10_3.y = var_10_5.position.y

			if Vector3.Distance(var_10_3, var_10_5.position) <= RoomCharacterEnum.BuilingInteractionNodeRadius then
				RoomCharacterController.instance:moveCharacterTo(var_10_0, var_10_5.position, false)

				if var_10_0:isTraining() then
					var_10_1.crittermgr:delaySetFollow(var_10_0.trainCritterUid, 0.1)
				end

				logNormal(string.format("[%s] 放置:(%s,%s,%s)", var_10_0.heroConfig.name, var_10_5.position.x, var_10_5.position.y, var_10_5.position.z))

				return true
			end
		end
	end
end

function var_0_0.openInteractBuildingView(arg_11_0, arg_11_1)
	local var_11_0 = RoomMapBuildingModel.instance:getBuildingMOById(arg_11_1)

	if var_11_0 and var_11_0:checkSameType(RoomBuildingEnum.BuildingType.Interact) then
		RoomCameraController.instance:saveCameraStateByKey(ViewName.RoomInteractBuildingView)

		arg_11_0._followBuildingUid = arg_11_1

		local var_11_1 = var_11_0:getInteractMO()
		local var_11_2 = var_11_1 and var_11_1.config and var_11_1.config.cameraId or 0

		ViewMgr.instance:openView(ViewName.RoomInteractBuildingView, {
			buildingUid = arg_11_1
		})
		RoomCameraController.instance:tweenCameraByBuildingUid(arg_11_1, RoomEnum.CameraState.InteractBuilding, var_11_2, arg_11_0._cameraInteractFinishCallback, arg_11_0)

		local var_11_3 = RoomCameraController.instance:getRoomScene()
		local var_11_4 = var_11_3 and var_11_3.buildingmgr:getBuildingEntity(arg_11_1, SceneTag.RoomBuilding)

		if var_11_4 then
			var_11_4.cameraFollowTargetComp:setFollowGOPath(RoomEnum.EntityChildKey.ThirdPersonCameraGOKey)

			local var_11_5, var_11_6, var_11_7 = var_11_4.cameraFollowTargetComp:getPositionXYZ()

			var_11_3.cameraFollow:setFollowTarget(var_11_4.cameraFollowTargetComp)
			var_11_3.cameraFollow:setIsPass(true, var_11_6)
		end
	end
end

function var_0_0._cameraInteractFinishCallback(arg_12_0)
	if arg_12_0._followBuildingUid == nil then
		return
	end

	local var_12_0 = RoomCameraController.instance:getRoomScene()
	local var_12_1 = arg_12_0._followBuildingUid

	arg_12_0._followBuildingUid = nil

	if var_12_0 and var_12_0.camera:getCameraState() == RoomEnum.CameraState.InteractBuilding and ViewMgr.instance:isOpen(ViewName.RoomInteractBuildingView) then
		var_12_0.cameraFollow:setIsPass(false)
		var_12_0.fovblock:setLookBuildingUid(RoomEnum.CameraState.InteractBuilding, var_12_1)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
