module("modules.logic.room.entity.comp.RoomCritterSpineComp", package.seeall)

slot0 = class("RoomCritterSpineComp", RoomBaseSpineComp)

function slot0.onInit(slot0)
	slot1 = slot0.entity:getMO()
	slot0._critterId = slot1.critterId
	slot0._skinId = slot1:getSkinId()
	slot0._spinePrefabRes = RoomResHelper.getCritterPath(slot0._skinId)
	slot0._materialRes = RoomCharacterEnum.MaterialPath
	slot0._shouldShowSpine = false
	slot0._isInDistance = false
	slot0._isShow = false
	slot0._isHide = false
	slot0._touchTamingRate = 0.6

	slot0:_cameraTransformUpdate()
	slot0:_refreshSpineShow()
end

function slot0.resetInit(slot0)
	if not slot0.entity:getMO() then
		return
	end

	if slot0._skinId ~= slot1:getSkinId() then
		slot0._critterId = slot1.critterId
		slot0._skinId = slot1:getSkinId()

		slot0:clearSpine()
		slot0:_refreshSpineShow()
	end
end

function slot0.addResToLoader(slot0, slot1)
	slot1:addPath(slot0._spinePrefabRes)
	slot1:addPath(slot0._materialRes)
	slot0.entity.critterspineeffect:addResToLoader(slot1)
end

function slot0._onLoadOneFail(slot0, slot1, slot2)
	logError("RoomCritterSpineComp: 加载失败, url: " .. slot2.ResPath)
end

function slot0._onLoadFinish(slot0, slot1)
	uv0.super._onLoadFinish(slot0, slot1)

	slot0._mountheadGO = gohelper.findChild(slot0._spineGO, "mountroot/mounthead")

	if slot0._mountheadGO then
		slot0._mountheadGOTrs = slot0._mountheadGO.transform
	end

	slot0:_spawnShadowGO(slot1)
	slot0:_updateShadowOffset()
	slot0:_cameraTransformUpdate()
	slot0:setScale(slot0._initScale)
	slot0.entity.critterspineeffect:spawnEffect(slot1)
	slot0:refreshAnimState()
end

function slot0._spawnShadowGO(slot0, slot1)
	slot0._shadowGO = gohelper.clone(slot0._scene.preloader:getResource(RoomScenePreloader.ResEffectCharacterShadow), slot0.entity.containerGO, "shadow")
	slot0._shadowGOTrs = slot0._shadowGO.transform
	slot0._shadowGO:GetComponent(typeof(UnityEngine.MeshRenderer)).sortingLayerName = "Default"

	transformhelper.setLocalPos(slot0._shadowGOTrs, 0, 0.01, 0)
end

function slot0.setScale(slot0, slot1)
	if not slot1 then
		return
	end

	if gohelper.isNil(slot0._spineGOTrs) then
		slot0._initScale = slot1
	else
		transformhelper.setLocalScale(slot0._spineGOTrs, slot1, slot1, slot1)
	end
end

function slot0.addEventListeners(slot0)
	RoomMapController.instance:registerCallback(RoomEvent.CameraTransformUpdate, slot0._cameraTransformUpdate, slot0)
	RoomCharacterController.instance:registerCallback(RoomEvent.RefreshSpineShow, slot0._refreshSpineShow, slot0)
	RoomMapController.instance:registerCallback(RoomEvent.CameraTransformUpdate, slot0._updateShadowOffset, slot0)
	RoomCharacterController.instance:registerCallback(RoomEvent.UpdateCharacterMove, slot0._onUpdate, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, slot0._onManufactureInfoUpdate, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, slot0._onManufactureInfoUpdate, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterFeedFood, slot0._onFeedFood, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterInfoPushUpdate, slot0._onCritterInfoUpdate, slot0)
end

function slot0.removeEventListeners(slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.CameraTransformUpdate, slot0._cameraTransformUpdate, slot0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.RefreshSpineShow, slot0._refreshSpineShow, slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.CameraTransformUpdate, slot0._updateShadowOffset, slot0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.UpdateCharacterMove, slot0._onUpdate, slot0)
	slot0:removeEventCb(ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, slot0._onManufactureInfoUpdate, slot0)
	slot0:removeEventCb(ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, slot0._onManufactureInfoUpdate, slot0)
	slot0:removeEventCb(CritterController.instance, CritterEvent.CritterFeedFood, slot0._onFeedFood, slot0)
	slot0:removeEventCb(CritterController.instance, CritterEvent.CritterInfoPushUpdate, slot0._onCritterInfoUpdate, slot0)
end

function slot0._onUpdate(slot0)
	if slot0._shadowPointGOTrs and slot0._shadowGOTrs then
		slot1, slot2, slot3 = transformhelper.getPos(slot0._shadowPointGOTrs)

		transformhelper.setPos(slot0._shadowGOTrs, slot1, slot2, slot3)
	end
end

function slot0.touch(slot0, slot1)
	slot2 = slot0.entity:getMO()

	if slot0._touchTamingRate <= math.random() then
		return
	end

	TaskDispatcher.cancelTask(slot0._touchAfter, slot0)

	if slot1 and slot2 then
		slot2.isTouch = true
		slot0._touchAction = true

		TaskDispatcher.runDelay(slot0._touchAfter, slot0, 10)
		slot0:play(slot0:_getTouchStateName(), false, true)
	else
		slot0:refreshAnimState()
	end
end

function slot0._touchAfter(slot0)
	TaskDispatcher.cancelTask(slot0._touchAfter, slot0)

	if slot0.entity:getMO() then
		slot1.isTouch = false
	end

	slot0._touchAction = false
end

function slot0._getTouchStateName(slot0)
	slot1 = RoomCharacterEnum.CharacterTamingAnimList

	return slot1[math.random(1, #slot1)] or slot1[1]
end

function slot0._onManufactureInfoUpdate(slot0, slot1)
	if not (slot0.entity:getMO() and slot2:getStayBuilding()) then
		return
	end

	if slot1 and not slot1[slot3] then
		return
	end

	slot0:refreshAnimState()
end

function slot0._onFeedFood(slot0, slot1)
	if not slot0.entity:getMO() or not slot2:getId() or slot1 and not slot1[slot3] then
		return
	end

	slot5 = CritterModel.instance:getCritterMOByUid(slot3):getMoodValue()
	slot7 = tonumber(ManufactureConfig.instance:getManufactureConst(RoomManufactureEnum.ConstId.CritterMaxMood)) or 0
	slot8 = RoomCharacterEnum.CharacterAnimStateName.SleepEnd

	if slot0._curAnimState == RoomCharacterEnum.CharacterAnimStateName.Idle or slot0._curAnimState == RoomCharacterEnum.CharacterAnimStateName.SpecialIdle then
		slot8 = RoomCharacterEnum.CharacterAnimStateName.Eat
	end

	if slot7 <= slot5 then
		slot0:_realSetMoveState(RoomCharacterEnum.CharacterMoveState.MaxMoodEating)
	end

	slot0:play(slot8, false)
end

function slot0._onCritterInfoUpdate(slot0, slot1)
	if not slot0.entity:getMO() or not slot2:getId() or slot1 and not slot1[slot3] then
		return
	end

	slot0:refreshAnimState()
end

function slot0._refreshSpineShow(slot0)
	slot0._shouldShowSpine = RoomCharacterController.instance:checkCanSpineShow(slot0._scene.camera:getCameraState())

	slot0:_refreshShowSpine()
end

function slot0._refreshShowSpine(slot0, slot1)
	if slot0._isInDistance and slot0._shouldShowSpine then
		if not slot0._isShow or slot1 then
			slot0._isShow = true
			slot0._isHide = false

			slot0:showSpine()
		end
	elseif not slot0._isHide or slot1 then
		slot0._isShow = false
		slot0._isHide = true

		slot0:hideSpine()
	end
end

function slot0.refreshAnimState(slot0)
	if not slot0.entity:getMO() then
		return
	end

	slot0.entity:stopCommonInteractionEff(RoomCharacterEnum.CommonEffect.CritterAngry)

	if RoomMapBuildingModel.instance:getBuildingMOById(slot1:getStayBuilding()) and slot3.buildingId then
		slot5 = RoomConfig.instance:getBuildingType(slot4)

		if ManufactureConfig.instance:isManufactureBuilding(slot4) then
			slot0:playManufactureAnim(slot3)
		elseif slot5 == RoomBuildingEnum.BuildingType.Rest then
			slot0:playRestingAnim()
		end
	elseif slot1.isTouch then
		if slot0._touchAction then
			slot0:play(slot0:_getTouchStateName(), false, false)
		else
			slot5, slot6 = slot0:getIdleAnim()

			slot0:play(slot5, slot6, false)
		end
	else
		slot5 = slot1.critterId
		slot7 = RoomCritterModel.instance:getTempCritterMO()

		if slot0:getAnimState() ~= RoomCharacterEnum.CharacterAnimStateName.SpecialIdle or RoomCharacterHelper.getAnimStateName(slot0._moveState, slot5) ~= RoomCharacterHelper.getIdleAnimStateName(slot5) or slot7 and slot7.id == slot0.entity.id then
			slot8 = nil

			slot0:play((slot0._moveState ~= RoomCharacterEnum.CharacterMoveState.Idle or slot0:getIdleAnim()) and RoomCharacterHelper.getAnimStateName(slot0._moveState, slot5), RoomCharacterEnum.CharacterLoopAnimState[slot0._moveState] or false, false)
		end
	end
end

function slot0.play(slot0, slot1, slot2, slot3)
	if not slot1 then
		return
	end

	if not slot0._skeletonAnim then
		return
	end

	if not (slot3 or false or slot1 ~= slot0._curAnimState or (slot2 or false) ~= slot0._isLoop) then
		return
	end

	slot0._curAnimState = slot1
	slot0._isLoop = slot2

	if slot0._skeletonAnim:HasAnimation(slot1) then
		slot0._skeletonAnim:SetAnimation(0, slot1, slot0._isLoop, 0)
		slot0.entity.critterspineeffect:play(slot1)
	else
		logError(string.format("critterId:%s  skinId:%s  animName:%s  goName:%s  Animation Name not exist ", slot0._critterId, slot0._skinId, slot1, gohelper.isNil(slot0._spineGO) and "nil" or slot0._spineGO.name))
	end
end

function slot0.playManufactureAnim(slot0, slot1)
	slot6, slot7 = slot0:getIdleAnim()

	if CritterModel.instance:getCritterMOByUid(slot0.entity:getMO():getId()):getMoodValue() > 0 then
		if slot1:getManufactureState() == RoomManufactureEnum.ManufactureState.Running then
			slot6 = RoomCharacterEnum.CharacterAnimStateName.Produce

			if RoomConfig.instance:getBuildingType(slot1.buildingId) == RoomBuildingEnum.BuildingType.Collect then
				slot6 = RoomCharacterEnum.CharacterAnimStateName.Collect
			end

			slot7 = true
		elseif slot8 == RoomManufactureEnum.ManufactureState.Stop then
			slot6 = RoomCharacterEnum.CharacterAnimStateName.Sleep
			slot7 = true
		end
	else
		slot0.entity:playCommonInteractionEff(RoomCharacterEnum.CommonEffect.CritterAngry)
	end

	slot0:play(slot6, slot7)
end

function slot0.playRestingAnim(slot0)
	slot7, slot8 = slot0:getIdleAnim()
	slot11 = slot2 == ManufactureModel.instance:getNewRestCritter()

	if CritterModel.instance:getCritterMOByUid(slot0.entity:getMO():getId()):getMoodValue() < (tonumber(ManufactureConfig.instance:getManufactureConst(RoomManufactureEnum.ConstId.CritterMaxMood)) or 0) then
		if slot0._curAnimState and slot0._moveState == RoomCharacterEnum.CharacterMoveState.Sleep then
			return
		end

		if slot11 then
			slot8 = false

			ManufactureModel.instance:setNewRestCritter()

			slot7 = RoomCharacterEnum.CharacterAnimStateName.SleepStart
		else
			slot7 = RoomCharacterEnum.CharacterAnimStateName.Sleep
		end

		slot0:_realSetMoveState(RoomCharacterEnum.CharacterMoveState.Sleep)
	elseif not slot11 and slot0._curAnimState then
		if not slot9 then
			return
		end

		slot8 = false
		slot7 = RoomCharacterEnum.CharacterAnimStateName.SleepEnd

		slot0:_realSetMoveState(RoomCharacterEnum.CharacterMoveState.Idle)
	end

	slot0:play(slot7, slot8)
end

function slot0._onAnimCallback(slot0, slot1, slot2, slot3)
	if not (slot2 == SpineAnimEvent.ActionComplete) then
		return
	end

	slot5 = nil
	slot6 = true

	if slot1 == RoomCharacterEnum.CharacterAnimStateName.Idle then
		slot5, slot6 = slot0:getIdleAnim()
	else
		if slot0._curAnimState ~= slot1 or slot0._isLoop then
			return
		end

		if slot0._moveState == RoomCharacterEnum.CharacterMoveState.MaxMoodEating and (RoomCharacterHelper.getNextAnimStateName(slot0._moveState, slot1) and slot5 == slot1 or RoomCharacterHelper.getIdleAnimStateName(slot0._critterId)) == RoomCharacterEnum.CharacterAnimStateName.Idle then
			slot0:_realSetMoveState(RoomCharacterEnum.CharacterMoveState.Idle)
		end
	end

	slot0:play(slot5, slot6, false)
end

function slot0.playAnim(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0._callback = slot4
	slot0._callbackObj = slot5

	if not slot4 then
		if slot0:_checkAnimator(slot1) then
			slot0._animator.enabled = true

			slot0._animator:Play(slot2, 0, slot3 or 0)
		end
	else
		TaskDispatcher.cancelTask(slot0._animDone, slot0)

		if slot6 then
			slot0._animatorPlayer:Play(slot2, slot0._animDone, slot0)
		else
			TaskDispatcher.runDelay(slot0._animDone, slot0, 0.1)
		end
	end
end

function slot0._checkAnimator(slot0, slot1)
	if slot0._scene.preloader:getResource(slot1) then
		slot0._animator = gohelper.onceAddComponent(slot0.entity.containerGO, typeof(UnityEngine.Animator))
		slot0._animatorPlayer = gohelper.onceAddComponent(slot0.entity.containerGO, typeof(SLFramework.AnimatorPlayer))
		slot0._animator.runtimeAnimatorController = slot2

		return true
	end

	return false
end

function slot0.clearAnim(slot0)
	slot0._callback = nil
	slot0._callbackObj = nil

	if slot0._animatorPlayer then
		UnityEngine.Component.DestroyImmediate(slot0._animatorPlayer)

		slot0._animatorPlayer = nil
	end

	if slot0._animator then
		UnityEngine.Component.DestroyImmediate(slot0._animator)

		slot0._animator = nil
	end
end

function slot0._animDone(slot0)
	if slot0._callback then
		slot0._callback(slot0._callbackObj)
	end
end

function slot0.changeMoveState(slot0, slot1)
	if slot0._moveState == slot1 then
		return
	end

	slot0:_realSetMoveState(slot1)
	slot0:refreshAnimState()
end

function slot0._realSetMoveState(slot0, slot1)
	slot0._moveState = slot1
end

function slot0.characterPosChanged(slot0)
	slot0:_cameraTransformUpdate()
end

function slot0._cameraTransformUpdate(slot0)
	slot2, slot3, slot4 = transformhelper.getPos(slot0.goTrs)

	if Vector2.Distance(slot0._scene.camera:getCameraFocus(), Vector2(slot2, slot4)) < 3.5 then
		slot0._isInDistance = true
	elseif slot6 > 4.5 then
		slot0._isInDistance = false
	end

	slot0:_refreshShowSpine()

	if slot0._spineGO and slot0._spineGO.activeInHierarchy then
		slot0:refreshRotation()
	end
end

function slot0._updateShadowOffset(slot0)
	if not slot0._material then
		return
	end

	slot0._material:SetVector("_ShadowOffset", slot0._scene.character:getShadowOffset())
end

function slot0.getIdleAnim(slot0)
	slot1 = true
	slot2 = RoomCharacterHelper.getIdleAnimStateName(slot0._critterId)

	if slot0:isRandomSpecialRate() then
		slot1 = false
		slot2 = RoomCharacterEnum.CharacterAnimStateName.SpecialIdle
	end

	return slot2, slot1
end

function slot0.isRandomSpecialRate(slot0)
	slot1 = false

	if math.random() < slot0.entity:getMO():getSpecialRate() then
		slot1 = true
	end

	return slot1
end

function slot0.isShowAnimShadow(slot0)
	return true
end

function slot0.getShadowGO(slot0)
	return slot0._shadowGO
end

function slot0.getMountheadGO(slot0)
	return slot0._mountheadGO
end

function slot0.getMountheadGOTrs(slot0)
	return slot0._mountheadGOTrs
end

function slot0.clearSpine(slot0)
	if slot0.entity and slot0.entity.critterspineeffect then
		slot0.entity.critterspineeffect:clearEffect()
	end

	uv0.super.clearSpine(slot0)

	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end

	if slot0._shadowGO then
		gohelper.destroy(slot0._shadowGO)

		slot0._shadowGO = nil
		slot0._shadowGOTrs = nil
	end

	slot0._skeletonAnim = nil
	slot0._curAnimState = nil
	slot0._isLoop = nil
	slot0._mountheadGO = nil
	slot0._mountheadGOTrs = nil
	slot0._shadowPointGOTrs = nil

	slot0.entity:stopAllCommonInteractionEff()
	TaskDispatcher.cancelTask(slot0._animDone, slot0)
end

function slot0.beforeDestroy(slot0)
	slot0:removeEventListeners()
	slot0:clearSpine()
end

return slot0
