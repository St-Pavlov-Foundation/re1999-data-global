module("modules.logic.room.entity.RoomBuildingEntity", package.seeall)

slot0 = class("RoomBuildingEntity", RoomBaseEntity)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0)
	slot0:setEntityId(slot1)
end

function slot0.setEntityId(slot0, slot1)
	slot0.id = slot1
	slot0.entityId = slot0.id
end

function slot0.getTag(slot0)
	return SceneTag.RoomBuilding
end

function slot0.init(slot0, slot1)
	slot0.containerGO = gohelper.create3d(slot1, RoomEnum.EntityChildKey.ContainerGOKey)
	slot0.staticContainerGO = slot0.containerGO
	slot0.containerGOTrs = slot0.containerGO.transform
	slot0.goTrs = slot1.transform

	uv0.super.init(slot0, slot1)

	slot0._buildingPartCountDict = {}
end

function slot0.playAudio(slot0, slot1)
	if slot1 and slot1 ~= 0 then
		slot0.__isHasAuidoTrigger = true

		AudioMgr.instance:trigger(slot1, slot0.go)
	end
end

function slot0.initComponents(slot0)
	slot0:addComp("effect", RoomEffectComp)
	slot0:addComp("alphaThresholdComp", RoomAlphaThresholdComp)

	if RoomController.instance:isObMode() then
		slot0:addComp("atmosphere", RoomAtmosphereComp)
	end

	if slot1 or RoomController.instance:isDebugNormalMode() then
		slot0:addComp("collider", RoomColliderComp)
	end

	if slot0:getMO() and slot2.config then
		if slot2.config.crossload ~= 0 then
			slot0:addComp("crossloadComp", RoomCrossloadComp)
		end

		if slot3.vehicleType ~= 0 then
			slot0:addComp("buildingVehicleComp", RoomBuildingVehicleComp)
		end

		if slot3.audioExtendType == RoomBuildingEnum.AudioExtendType.Clock12Hour then
			slot0:addComp("buildingClockComp", RoomBuildingClockComp)
		elseif slot3.audioExtendType == RoomBuildingEnum.AudioExtendType.AnimatorEvent then
			slot0:addComp("animEventAudioComp", RoomAnimEventAudioComp)
		end

		if not string.nilorempty(slot2.config.linkBlock) then
			slot0:addComp("buildingLinkBlockComp", RoomBuildingLinkBlockComp)
		end

		if slot3.reflerction == 1 then
			slot0:addComp("reflerctionComp", RoomBuildingReflectionComp)
		end

		if slot3.canLevelUp then
			slot0:addComp("buildingLevelComp", RoomBuildingLevelComp)
		end

		if slot3.buildingType == RoomBuildingEnum.BuildingType.Rest then
			slot0:addComp("summonComp", RoomBuildingSummonComp)
		end

		if slot3.buildingType == RoomBuildingEnum.BuildingType.Interact then
			slot0:addComp("interactComp", RoomBuildingInteractComp)
		end
	end

	slot0:addComp("nightlight", RoomNightLightComp)
	slot0:addComp("critter", RoomBuildingCritterComp)
	slot0:addComp("cameraFollowTargetComp", RoomCameraFollowTargetComp)
end

function slot0.onStart(slot0)
	uv0.super.onStart(slot0)
	RoomBuildingController.instance:registerCallback(RoomEvent.PressBuildingUp, slot0._refreshPressEffect, slot0)
	RoomBuildingController.instance:registerCallback(RoomEvent.DropBuildingDown, slot0._refreshPressEffect, slot0)
	RoomBuildingController.instance:registerCallback(RoomEvent.SetBuildingColliderEnable, slot0._setColliderEnable, slot0)
	RoomCharacterController.instance:registerCallback(RoomEvent.CharacterListShowChanged, slot0._characterListShowChanged, slot0)
end

function slot0.refreshName(slot0)
	slot0.go.name = RoomResHelper.getBlockName(slot0:getMO().hexPoint)
end

function slot0.refreshRotation(slot0, slot1)
	slot1 = false
	slot2 = slot0:getMO()

	if slot0._rotationTweenId then
		ZProj.TweenHelper.KillById(slot0._rotationTweenId)
	end

	if slot1 then
		slot0._rotationTweenId = ZProj.TweenHelper.DOLocalRotate(slot0.containerGOTrs, 0, slot2.rotate * 60, 0, 0.1, nil, slot0, nil, EaseType.Linear)
	else
		transformhelper.setLocalRotation(slot0.containerGOTrs, 0, slot2.rotate * 60, 0)
	end
end

function slot0.refreshBuilding(slot0)
	slot0:_refreshBuilding()
	slot0:_refreshPressEffect()

	if slot0.buildingLinkBlockComp then
		slot0.buildingLinkBlockComp:refreshLink()
	end

	if slot0.reflerctionComp then
		slot0.reflerctionComp:refreshReflection()
	end
end

function slot0.transformPoint(slot0, slot1, slot2, slot3)
	return slot0.containerGOTrs:TransformPoint(slot1, slot2, slot3)
end

function slot0._refreshBuilding(slot0)
	slot2 = RoomEnum.EffectKey.BuildingGOKey

	if slot0:getMO() then
		if not slot0.effect:isHasEffectGOByKey(slot2) or slot1.config.canLevelUp and slot0._lastLevel ~= slot1.level then
			slot0._listalphaThresholdValue = slot3
			slot0._lastLevel = slot1.level

			slot0.effect:addParams({
				[slot2] = {
					deleteChildPath = "0",
					pathfinding = true,
					res = slot0:_getBuildingRes(),
					alphaThreshold = slot0:getAlphaThresholdValue() and true or false,
					alphaThresholdValue = slot3,
					localPos = Vector3(0, RoomBuildingEnum.VehicleTypeOffestY[slot1.config.vehicleType] or 0, 0)
				}
			})
			slot0.effect:refreshEffect()
		elseif slot0._listalphaThresholdValue ~= slot3 then
			slot0._listalphaThresholdValue = slot3

			slot0.effect:setMPB(slot2, false, slot4, slot3)
		end
	elseif slot0.effect:isHasKey(slot2) then
		slot0._listalphaThresholdValue = nil

		slot0.effect:removeParams({
			slot2
		})
		slot0.effect:refreshEffect()
	end
end

function slot0.getAlphaThresholdValue(slot0)
	if RoomMapBuildingModel.instance:getTempBuildingMO() and slot1.id == slot0.id then
		if RoomBuildingController.instance:isPressBuilding() then
			return RoomConfig.instance:getBuildingConfig(slot1.buildingId).alphaThreshold * 0.001
		end

		if RoomBuildingHelper.isInInitBlock(slot1.hexPoint) then
			return slot3
		end

		if RoomMapBlockModel.instance:getBlockMO(slot4.x, slot4.y) and RoomBuildingHelper.checkBuildResId(slot1.buildingId, slot5:getResourceList(true)) == false then
			return slot3
		end

		slot6, slot7 = RoomBuildingHelper.canConfirmPlace(slot1.buildingId, slot1.hexPoint, slot1.rotate, nil, , false, slot1.levels, true)

		if not slot6 then
			return slot3
		end
	end

	return nil
end

function slot0._refreshPressEffect(slot0)
	if RoomBuildingController.instance:isPressBuilding() and slot1 == slot0.id then
		if not slot0.effect:isHasKey(RoomEnum.EffectKey.BuildingPressEffectKey) then
			slot4 = RoomMapModel.instance:getBuildingConfigParam(slot0:getMO().buildingId).offset

			slot0.effect:addParams({
				[RoomEnum.EffectKey.BuildingPressEffectKey] = {
					res = RoomScenePreloader.ResVXXuXian,
					localPos = Vector3(slot4.x, slot4.y - 1, slot4.z)
				}
			})
		end

		slot0.effect:refreshEffect()
	elseif slot0.effect:isHasKey(RoomEnum.EffectKey.BuildingPressEffectKey) then
		slot0.effect:removeParams({
			RoomEnum.EffectKey.BuildingPressEffectKey
		})
		slot0.effect:refreshEffect()
	end
end

function slot0.onEffectRebuild(slot0)
	if not slot0._isSmokeAnimPlaying then
		slot0:_playSmokeAnim(false)
	end

	slot0:setSideIsActive(RoomEnum.EntityChildKey.OutSideKey, true)
	slot0:setSideIsActive(RoomEnum.EntityChildKey.InSideKey, false)

	if slot0:getBodyGO() then
		RoomMapController.instance:dispatchEvent(RoomEvent.RoomVieiwConfirmRefreshUI)
	end

	if RoomCameraController.instance:getRoomScene() then
		slot2.buildingcrittermgr:refreshCritterPosByBuilding(slot0.id)
	end
end

function slot0._characterListShowChanged(slot0, slot1)
	slot0:_setColliderEnable(not slot1)
end

function slot0._setColliderEnable(slot0, slot1, slot2)
	if slot2 and slot2 ~= slot0.id then
		return
	end

	if slot0.collider then
		slot0.collider:setEnable(slot1)
	end
end

function slot0.getHeadGO(slot0)
	return slot0:_findBuildingGOChild(RoomEnum.EntityChildKey.HeadGOKey)
end

function slot0.getBodyGO(slot0)
	return slot0:_findBuildingGOChild(RoomEnum.EntityChildKey.BodyGOKey)
end

function slot0.playAnimator(slot0, slot1)
	return slot0.effect:playEffectAnimator(RoomEnum.EffectKey.BuildingGOKey, slot1)
end

function slot0.playSmokeEffect(slot0)
	slot0:_returnSmokeEffect()
	slot0:_playSmokeAnim(true)

	slot0._isSmokeAnimPlaying = true

	TaskDispatcher.runDelay(slot0._delayReturnSmokeEffect, slot0, 3)
end

function slot0._delayReturnSmokeEffect(slot0)
	slot0._isSmokeAnimPlaying = false

	slot0:_playSmokeAnim(false)
end

function slot0._returnSmokeEffect(slot0)
	TaskDispatcher.cancelTask(slot0._delayReturnSmokeEffect, slot0)
end

function slot0._playSmokeAnim(slot0, slot1)
	if slot0:_findBuildingGOChild(RoomEnum.EntityChildKey.SmokeGOKey) then
		if slot1 then
			gohelper.setActive(slot2, false)
		end

		gohelper.setActive(slot2, slot1)
	end
end

function slot0.setSideIsActive(slot0, slot1, slot2)
	gohelper.setActive(slot0:_findBuildingGOChild(string.format("%s/%s", 1, slot1 or RoomEnum.EntityChildKey.InSideKey)), slot2)
end

function slot0.getPlayerInsideInteractionNode(slot0)
	return slot0:_findBuildingGOChild(RoomEnum.EntityChildKey.PositionZeroKey)
end

function slot0.getSpineWidgetNode(slot0, slot1)
	return slot0:_findBuildingGOChild(string.format(RoomEnum.EntityChildKey.InteractSpineNode, slot1))
end

function slot0.getCritterPoint(slot0, slot1)
	if not slot1 then
		return
	end

	return slot0:_findBuildingGOChild(string.format(RoomEnum.EntityChildKey.CritterPoint, slot1 + 1))
end

function slot0.getBuildingGO(slot0)
	return slot0.effect:getEffectGO(RoomEnum.EffectKey.BuildingGOKey)
end

function slot0._findBuildingGOChild(slot0, slot1)
	return slot0.effect:getGameObjectByPath(RoomEnum.EffectKey.BuildingGOKey, slot1)
end

function slot0.setLocalPos(slot0, slot1, slot2, slot3, slot4)
	ZProj.TweenHelper.KillByObj(slot0.go.transform)

	if slot4 then
		ZProj.TweenHelper.DOLocalMove(slot0.go.transform, slot1, slot2, slot3, 0.1)
	else
		transformhelper.setLocalPos(slot0.go.transform, slot1, slot2, slot3)
	end

	slot0:refreshName()
end

function slot0.tweenUp(slot0)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_board_drag)
	ZProj.TweenHelper.KillByObj(slot0.containerGO.transform)
	ZProj.TweenHelper.DOLocalMoveY(slot0.containerGO.transform, slot0:_getBuildingDragUp(), 0.2)
end

function slot0.tweenDown(slot0)
	if slot0:getMO() then
		AudioMgr.instance:trigger(slot1:getPlaceAudioId())
	end

	ZProj.TweenHelper.KillByObj(slot0.containerGO.transform)
	ZProj.TweenHelper.DOLocalMoveY(slot0.containerGO.transform, 0, 0.2)
end

function slot0._getBuildingDragUp(slot0)
	if RoomConfig.instance:getBuildingConfig(slot0:getMO().buildingId) and slot2.dragUpHeight then
		return slot2.dragUpHeight * 0.001
	end

	return 1
end

function slot0.tweenAlphaThreshold(slot0, slot1, slot2, slot3)
	if slot0.alphaThresholdComp then
		slot0.alphaThresholdComp:tweenAlphaThreshold(slot1, slot2, slot3)
	end
end

function slot0._getBuildingRes(slot0)
	slot1 = slot0:getMO()

	return RoomResHelper.getBuildingPath(slot1.buildingId, slot1.level)
end

function slot0._getBuildingPartRes(slot0, slot1, slot2)
	return RoomResHelper.getPartPathList(slot1, slot2)
end

function slot0.beforeDestroy(slot0)
	slot0:_returnSmokeEffect()
	ZProj.TweenHelper.KillByObj(slot0.go.transform)
	ZProj.TweenHelper.KillByObj(slot0.containerGO.transform)

	if slot0._rotationTweenId then
		ZProj.TweenHelper.KillById(slot0._rotationTweenId)
	end

	for slot4, slot5 in ipairs(slot0._compList) do
		if slot5.beforeDestroy then
			slot5:beforeDestroy()
		end
	end

	if slot0.__isHasAuidoTrigger then
		slot0.__isHasAuidoTrigger = false

		AudioMgr.instance:trigger(AudioEnum.Room.stop_amb_home, slot0.go)
	end

	slot0:removeEvent()
end

function slot0.removeEvent(slot0)
	RoomBuildingController.instance:unregisterCallback(RoomEvent.PressBuildingUp, slot0._refreshPressEffect, slot0)
	RoomBuildingController.instance:unregisterCallback(RoomEvent.DropBuildingDown, slot0._refreshPressEffect, slot0)
	RoomBuildingController.instance:unregisterCallback(RoomEvent.SetBuildingColliderEnable, slot0._setColliderEnable, slot0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.CharacterListShowChanged, slot0._characterListShowChanged, slot0)
end

function slot0.setBatchEnabled(slot0, slot1)
	slot0.effect:setBatch(RoomEnum.EffectKey.BuildingGOKey, slot1)
end

function slot0.getMO(slot0)
	return RoomMapBuildingModel.instance:getBuildingMOById(slot0.id)
end

function slot0.getVehicleMO(slot0)
	return RoomMapVehicleModel.instance:getVehicleMOByBuilingUid(slot0.id)
end

function slot0.getCharacterMeshRendererList(slot0)
	return slot0.effect:getMeshRenderersByKey(RoomEnum.EffectKey.BuildingGOKey)
end

function slot0.getOccupyDict(slot0)
	if not slot0:getMO() or not slot1.hexPoint then
		return nil
	end

	if slot0._lastHexPoint ~= slot1.hexPoint or slot0._lastRotate ~= slot1.rotate then
		slot0._lastHexPoint = HexPoint(slot1.hexPoint.x, slot1.hexPoint.y)
		slot0._lastRotate = slot1.rotate
		slot5 = slot1.rotate
		slot6 = slot1.buildingUid
		slot0._lastOccupyDict = RoomBuildingHelper.getOccupyDict(slot1.buildingId, slot1.hexPoint, slot5, slot6)
		slot0._lastHexPointList = {}

		for slot5, slot6 in pairs(slot0._lastOccupyDict) do
			for slot10, slot11 in pairs(slot6) do
				table.insert(slot0._lastHexPointList, slot11.hexPoint)
			end
		end
	end

	return slot0._lastOccupyDict, slot0._lastHexPointList
end

return slot0
