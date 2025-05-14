module("modules.logic.room.entity.RoomBuildingEntity", package.seeall)

local var_0_0 = class("RoomBuildingEntity", RoomBaseEntity)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0)
	arg_1_0:setEntityId(arg_1_1)
end

function var_0_0.setEntityId(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1
	arg_2_0.entityId = arg_2_0.id
end

function var_0_0.getTag(arg_3_0)
	return SceneTag.RoomBuilding
end

function var_0_0.init(arg_4_0, arg_4_1)
	arg_4_0.containerGO = gohelper.create3d(arg_4_1, RoomEnum.EntityChildKey.ContainerGOKey)
	arg_4_0.staticContainerGO = arg_4_0.containerGO
	arg_4_0.containerGOTrs = arg_4_0.containerGO.transform
	arg_4_0.goTrs = arg_4_1.transform

	var_0_0.super.init(arg_4_0, arg_4_1)

	arg_4_0._buildingPartCountDict = {}
end

function var_0_0.playAudio(arg_5_0, arg_5_1)
	if arg_5_1 and arg_5_1 ~= 0 then
		arg_5_0.__isHasAuidoTrigger = true

		AudioMgr.instance:trigger(arg_5_1, arg_5_0.go)
	end
end

function var_0_0.initComponents(arg_6_0)
	arg_6_0:addComp("effect", RoomEffectComp)
	arg_6_0:addComp("alphaThresholdComp", RoomAlphaThresholdComp)

	local var_6_0 = RoomController.instance:isObMode()

	if var_6_0 then
		arg_6_0:addComp("atmosphere", RoomAtmosphereComp)
	end

	if var_6_0 or RoomController.instance:isDebugNormalMode() then
		arg_6_0:addComp("collider", RoomColliderComp)
	end

	local var_6_1 = arg_6_0:getMO()

	if var_6_1 and var_6_1.config then
		local var_6_2 = var_6_1.config

		if var_6_2.crossload ~= 0 then
			arg_6_0:addComp("crossloadComp", RoomCrossloadComp)
		end

		if var_6_2.vehicleType ~= 0 then
			arg_6_0:addComp("buildingVehicleComp", RoomBuildingVehicleComp)
		end

		if var_6_2.audioExtendType == RoomBuildingEnum.AudioExtendType.Clock12Hour then
			arg_6_0:addComp("buildingClockComp", RoomBuildingClockComp)
		elseif var_6_2.audioExtendType == RoomBuildingEnum.AudioExtendType.AnimatorEvent then
			arg_6_0:addComp("animEventAudioComp", RoomAnimEventAudioComp)
		end

		if not string.nilorempty(var_6_1.config.linkBlock) then
			arg_6_0:addComp("buildingLinkBlockComp", RoomBuildingLinkBlockComp)
		end

		if var_6_2.reflerction == 1 then
			arg_6_0:addComp("reflerctionComp", RoomBuildingReflectionComp)
		end

		if var_6_2.canLevelUp then
			arg_6_0:addComp("buildingLevelComp", RoomBuildingLevelComp)
		end

		if var_6_2.buildingType == RoomBuildingEnum.BuildingType.Rest then
			arg_6_0:addComp("summonComp", RoomBuildingSummonComp)
		end

		if var_6_2.buildingType == RoomBuildingEnum.BuildingType.Interact then
			arg_6_0:addComp("interactComp", RoomBuildingInteractComp)
		end
	end

	arg_6_0:addComp("nightlight", RoomNightLightComp)
	arg_6_0:addComp("critter", RoomBuildingCritterComp)
	arg_6_0:addComp("cameraFollowTargetComp", RoomCameraFollowTargetComp)
end

function var_0_0.onStart(arg_7_0)
	var_0_0.super.onStart(arg_7_0)
	RoomBuildingController.instance:registerCallback(RoomEvent.PressBuildingUp, arg_7_0._refreshPressEffect, arg_7_0)
	RoomBuildingController.instance:registerCallback(RoomEvent.DropBuildingDown, arg_7_0._refreshPressEffect, arg_7_0)
	RoomBuildingController.instance:registerCallback(RoomEvent.SetBuildingColliderEnable, arg_7_0._setColliderEnable, arg_7_0)
	RoomCharacterController.instance:registerCallback(RoomEvent.CharacterListShowChanged, arg_7_0._characterListShowChanged, arg_7_0)
end

function var_0_0.refreshName(arg_8_0)
	local var_8_0 = arg_8_0:getMO()

	arg_8_0.go.name = RoomResHelper.getBlockName(var_8_0.hexPoint)
end

function var_0_0.refreshRotation(arg_9_0, arg_9_1)
	arg_9_1 = false

	local var_9_0 = arg_9_0:getMO()

	if arg_9_0._rotationTweenId then
		ZProj.TweenHelper.KillById(arg_9_0._rotationTweenId)
	end

	if arg_9_1 then
		arg_9_0._rotationTweenId = ZProj.TweenHelper.DOLocalRotate(arg_9_0.containerGOTrs, 0, var_9_0.rotate * 60, 0, 0.1, nil, arg_9_0, nil, EaseType.Linear)
	else
		transformhelper.setLocalRotation(arg_9_0.containerGOTrs, 0, var_9_0.rotate * 60, 0)
	end
end

function var_0_0.refreshBuilding(arg_10_0)
	arg_10_0:_refreshBuilding()
	arg_10_0:_refreshPressEffect()

	if arg_10_0.buildingLinkBlockComp then
		arg_10_0.buildingLinkBlockComp:refreshLink()
	end

	if arg_10_0.reflerctionComp then
		arg_10_0.reflerctionComp:refreshReflection()
	end
end

function var_0_0.transformPoint(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	return (arg_11_0.containerGOTrs:TransformPoint(arg_11_1, arg_11_2, arg_11_3))
end

function var_0_0._refreshBuilding(arg_12_0)
	local var_12_0 = arg_12_0:getMO()
	local var_12_1 = RoomEnum.EffectKey.BuildingGOKey

	if var_12_0 then
		local var_12_2 = arg_12_0:getAlphaThresholdValue()
		local var_12_3 = var_12_2 and true or false

		if not arg_12_0.effect:isHasEffectGOByKey(var_12_1) or var_12_0.config.canLevelUp and arg_12_0._lastLevel ~= var_12_0.level then
			arg_12_0._listalphaThresholdValue = var_12_2
			arg_12_0._lastLevel = var_12_0.level

			local var_12_4 = RoomBuildingEnum.VehicleTypeOffestY[var_12_0.config.vehicleType] or 0

			arg_12_0.effect:addParams({
				[var_12_1] = {
					deleteChildPath = "0",
					pathfinding = true,
					res = arg_12_0:_getBuildingRes(),
					alphaThreshold = var_12_3,
					alphaThresholdValue = var_12_2,
					localPos = Vector3(0, var_12_4, 0)
				}
			})
			arg_12_0.effect:refreshEffect()
		elseif arg_12_0._listalphaThresholdValue ~= var_12_2 then
			arg_12_0._listalphaThresholdValue = var_12_2

			arg_12_0.effect:setMPB(var_12_1, false, var_12_3, var_12_2)
		end
	elseif arg_12_0.effect:isHasKey(var_12_1) then
		arg_12_0._listalphaThresholdValue = nil

		arg_12_0.effect:removeParams({
			var_12_1
		})
		arg_12_0.effect:refreshEffect()
	end
end

function var_0_0.getAlphaThresholdValue(arg_13_0)
	local var_13_0 = RoomMapBuildingModel.instance:getTempBuildingMO()

	if var_13_0 and var_13_0.id == arg_13_0.id then
		local var_13_1 = RoomConfig.instance:getBuildingConfig(var_13_0.buildingId).alphaThreshold * 0.001

		if RoomBuildingController.instance:isPressBuilding() then
			return var_13_1
		end

		local var_13_2 = var_13_0.hexPoint

		if RoomBuildingHelper.isInInitBlock(var_13_2) then
			return var_13_1
		end

		local var_13_3 = RoomMapBlockModel.instance:getBlockMO(var_13_2.x, var_13_2.y)

		if var_13_3 and RoomBuildingHelper.checkBuildResId(var_13_0.buildingId, var_13_3:getResourceList(true)) == false then
			return var_13_1
		end

		local var_13_4, var_13_5 = RoomBuildingHelper.canConfirmPlace(var_13_0.buildingId, var_13_0.hexPoint, var_13_0.rotate, nil, nil, false, var_13_0.levels, true)

		if not var_13_4 then
			return var_13_1
		end
	end

	return nil
end

function var_0_0._refreshPressEffect(arg_14_0)
	local var_14_0 = RoomBuildingController.instance:isPressBuilding()

	if var_14_0 and var_14_0 == arg_14_0.id then
		if not arg_14_0.effect:isHasKey(RoomEnum.EffectKey.BuildingPressEffectKey) then
			local var_14_1 = arg_14_0:getMO()
			local var_14_2 = RoomMapModel.instance:getBuildingConfigParam(var_14_1.buildingId).offset

			arg_14_0.effect:addParams({
				[RoomEnum.EffectKey.BuildingPressEffectKey] = {
					res = RoomScenePreloader.ResVXXuXian,
					localPos = Vector3(var_14_2.x, var_14_2.y - 1, var_14_2.z)
				}
			})
		end

		arg_14_0.effect:refreshEffect()
	elseif arg_14_0.effect:isHasKey(RoomEnum.EffectKey.BuildingPressEffectKey) then
		arg_14_0.effect:removeParams({
			RoomEnum.EffectKey.BuildingPressEffectKey
		})
		arg_14_0.effect:refreshEffect()
	end
end

function var_0_0.onEffectRebuild(arg_15_0)
	if not arg_15_0._isSmokeAnimPlaying then
		arg_15_0:_playSmokeAnim(false)
	end

	arg_15_0:setSideIsActive(RoomEnum.EntityChildKey.OutSideKey, true)
	arg_15_0:setSideIsActive(RoomEnum.EntityChildKey.InSideKey, false)

	if arg_15_0:getBodyGO() then
		RoomMapController.instance:dispatchEvent(RoomEvent.RoomVieiwConfirmRefreshUI)
	end

	local var_15_0 = RoomCameraController.instance:getRoomScene()

	if var_15_0 then
		var_15_0.buildingcrittermgr:refreshCritterPosByBuilding(arg_15_0.id)
	end
end

function var_0_0._characterListShowChanged(arg_16_0, arg_16_1)
	arg_16_0:_setColliderEnable(not arg_16_1)
end

function var_0_0._setColliderEnable(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_2 and arg_17_2 ~= arg_17_0.id then
		return
	end

	if arg_17_0.collider then
		arg_17_0.collider:setEnable(arg_17_1)
	end
end

function var_0_0.getHeadGO(arg_18_0)
	return arg_18_0:_findBuildingGOChild(RoomEnum.EntityChildKey.HeadGOKey)
end

function var_0_0.getBodyGO(arg_19_0)
	return arg_19_0:_findBuildingGOChild(RoomEnum.EntityChildKey.BodyGOKey)
end

function var_0_0.playAnimator(arg_20_0, arg_20_1)
	return arg_20_0.effect:playEffectAnimator(RoomEnum.EffectKey.BuildingGOKey, arg_20_1)
end

function var_0_0.playSmokeEffect(arg_21_0)
	arg_21_0:_returnSmokeEffect()
	arg_21_0:_playSmokeAnim(true)

	arg_21_0._isSmokeAnimPlaying = true

	TaskDispatcher.runDelay(arg_21_0._delayReturnSmokeEffect, arg_21_0, 3)
end

function var_0_0._delayReturnSmokeEffect(arg_22_0)
	arg_22_0._isSmokeAnimPlaying = false

	arg_22_0:_playSmokeAnim(false)
end

function var_0_0._returnSmokeEffect(arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._delayReturnSmokeEffect, arg_23_0)
end

function var_0_0._playSmokeAnim(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0:_findBuildingGOChild(RoomEnum.EntityChildKey.SmokeGOKey)

	if var_24_0 then
		if arg_24_1 then
			gohelper.setActive(var_24_0, false)
		end

		gohelper.setActive(var_24_0, arg_24_1)
	end
end

function var_0_0.setSideIsActive(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_1 or RoomEnum.EntityChildKey.InSideKey
	local var_25_1 = string.format("%s/%s", 1, var_25_0)
	local var_25_2 = arg_25_0:_findBuildingGOChild(var_25_1)

	gohelper.setActive(var_25_2, arg_25_2)
end

function var_0_0.getPlayerInsideInteractionNode(arg_26_0)
	return (arg_26_0:_findBuildingGOChild(RoomEnum.EntityChildKey.PositionZeroKey))
end

function var_0_0.getSpineWidgetNode(arg_27_0, arg_27_1)
	local var_27_0 = string.format(RoomEnum.EntityChildKey.InteractSpineNode, arg_27_1)

	return (arg_27_0:_findBuildingGOChild(var_27_0))
end

function var_0_0.getCritterPoint(arg_28_0, arg_28_1)
	if not arg_28_1 then
		return
	end

	local var_28_0 = string.format(RoomEnum.EntityChildKey.CritterPoint, arg_28_1 + 1)

	return (arg_28_0:_findBuildingGOChild(var_28_0))
end

function var_0_0.getBuildingGO(arg_29_0)
	return arg_29_0.effect:getEffectGO(RoomEnum.EffectKey.BuildingGOKey)
end

function var_0_0._findBuildingGOChild(arg_30_0, arg_30_1)
	return arg_30_0.effect:getGameObjectByPath(RoomEnum.EffectKey.BuildingGOKey, arg_30_1)
end

function var_0_0.setLocalPos(arg_31_0, arg_31_1, arg_31_2, arg_31_3, arg_31_4)
	ZProj.TweenHelper.KillByObj(arg_31_0.go.transform)

	if arg_31_4 then
		ZProj.TweenHelper.DOLocalMove(arg_31_0.go.transform, arg_31_1, arg_31_2, arg_31_3, 0.1)
	else
		transformhelper.setLocalPos(arg_31_0.go.transform, arg_31_1, arg_31_2, arg_31_3)
	end

	arg_31_0:refreshName()
end

function var_0_0.tweenUp(arg_32_0)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_board_drag)
	ZProj.TweenHelper.KillByObj(arg_32_0.containerGO.transform)
	ZProj.TweenHelper.DOLocalMoveY(arg_32_0.containerGO.transform, arg_32_0:_getBuildingDragUp(), 0.2)
end

function var_0_0.tweenDown(arg_33_0)
	local var_33_0 = arg_33_0:getMO()

	if var_33_0 then
		AudioMgr.instance:trigger(var_33_0:getPlaceAudioId())
	end

	ZProj.TweenHelper.KillByObj(arg_33_0.containerGO.transform)
	ZProj.TweenHelper.DOLocalMoveY(arg_33_0.containerGO.transform, 0, 0.2)
end

function var_0_0._getBuildingDragUp(arg_34_0)
	local var_34_0 = arg_34_0:getMO()
	local var_34_1 = RoomConfig.instance:getBuildingConfig(var_34_0.buildingId)

	if var_34_1 and var_34_1.dragUpHeight then
		return var_34_1.dragUpHeight * 0.001
	end

	return 1
end

function var_0_0.tweenAlphaThreshold(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	if arg_35_0.alphaThresholdComp then
		arg_35_0.alphaThresholdComp:tweenAlphaThreshold(arg_35_1, arg_35_2, arg_35_3)
	end
end

function var_0_0._getBuildingRes(arg_36_0)
	local var_36_0 = arg_36_0:getMO()

	return (RoomResHelper.getBuildingPath(var_36_0.buildingId, var_36_0.level))
end

function var_0_0._getBuildingPartRes(arg_37_0, arg_37_1, arg_37_2)
	return RoomResHelper.getPartPathList(arg_37_1, arg_37_2)
end

function var_0_0.beforeDestroy(arg_38_0)
	arg_38_0:_returnSmokeEffect()
	ZProj.TweenHelper.KillByObj(arg_38_0.go.transform)
	ZProj.TweenHelper.KillByObj(arg_38_0.containerGO.transform)

	if arg_38_0._rotationTweenId then
		ZProj.TweenHelper.KillById(arg_38_0._rotationTweenId)
	end

	for iter_38_0, iter_38_1 in ipairs(arg_38_0._compList) do
		if iter_38_1.beforeDestroy then
			iter_38_1:beforeDestroy()
		end
	end

	if arg_38_0.__isHasAuidoTrigger then
		arg_38_0.__isHasAuidoTrigger = false

		AudioMgr.instance:trigger(AudioEnum.Room.stop_amb_home, arg_38_0.go)
	end

	arg_38_0:removeEvent()
end

function var_0_0.removeEvent(arg_39_0)
	RoomBuildingController.instance:unregisterCallback(RoomEvent.PressBuildingUp, arg_39_0._refreshPressEffect, arg_39_0)
	RoomBuildingController.instance:unregisterCallback(RoomEvent.DropBuildingDown, arg_39_0._refreshPressEffect, arg_39_0)
	RoomBuildingController.instance:unregisterCallback(RoomEvent.SetBuildingColliderEnable, arg_39_0._setColliderEnable, arg_39_0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.CharacterListShowChanged, arg_39_0._characterListShowChanged, arg_39_0)
end

function var_0_0.setBatchEnabled(arg_40_0, arg_40_1)
	arg_40_0.effect:setBatch(RoomEnum.EffectKey.BuildingGOKey, arg_40_1)
end

function var_0_0.getMO(arg_41_0)
	return RoomMapBuildingModel.instance:getBuildingMOById(arg_41_0.id)
end

function var_0_0.getVehicleMO(arg_42_0)
	return RoomMapVehicleModel.instance:getVehicleMOByBuilingUid(arg_42_0.id)
end

function var_0_0.getCharacterMeshRendererList(arg_43_0)
	return arg_43_0.effect:getMeshRenderersByKey(RoomEnum.EffectKey.BuildingGOKey)
end

function var_0_0.getOccupyDict(arg_44_0)
	local var_44_0 = arg_44_0:getMO()

	if not var_44_0 or not var_44_0.hexPoint then
		return nil
	end

	if arg_44_0._lastHexPoint ~= var_44_0.hexPoint or arg_44_0._lastRotate ~= var_44_0.rotate then
		arg_44_0._lastHexPoint = HexPoint(var_44_0.hexPoint.x, var_44_0.hexPoint.y)
		arg_44_0._lastRotate = var_44_0.rotate
		arg_44_0._lastOccupyDict = RoomBuildingHelper.getOccupyDict(var_44_0.buildingId, var_44_0.hexPoint, var_44_0.rotate, var_44_0.buildingUid)
		arg_44_0._lastHexPointList = {}

		for iter_44_0, iter_44_1 in pairs(arg_44_0._lastOccupyDict) do
			for iter_44_2, iter_44_3 in pairs(iter_44_1) do
				table.insert(arg_44_0._lastHexPointList, iter_44_3.hexPoint)
			end
		end
	end

	return arg_44_0._lastOccupyDict, arg_44_0._lastHexPointList
end

return var_0_0
