module("modules.logic.room.entity.comp.RoomCritterSpineComp", package.seeall)

local var_0_0 = class("RoomCritterSpineComp", RoomBaseSpineComp)

function var_0_0.onInit(arg_1_0)
	local var_1_0 = arg_1_0.entity:getMO()

	arg_1_0._critterId = var_1_0.critterId
	arg_1_0._skinId = var_1_0:getSkinId()
	arg_1_0._spinePrefabRes = RoomResHelper.getCritterPath(arg_1_0._skinId)
	arg_1_0._materialRes = RoomCharacterEnum.MaterialPath
	arg_1_0._shouldShowSpine = false
	arg_1_0._isInDistance = false
	arg_1_0._isShow = false
	arg_1_0._isHide = false
	arg_1_0._touchTamingRate = 0.6

	arg_1_0:_cameraTransformUpdate()
	arg_1_0:_refreshSpineShow()
end

function var_0_0.resetInit(arg_2_0)
	local var_2_0 = arg_2_0.entity:getMO()

	if not var_2_0 then
		return
	end

	if arg_2_0._skinId ~= var_2_0:getSkinId() then
		arg_2_0._critterId = var_2_0.critterId
		arg_2_0._skinId = var_2_0:getSkinId()

		arg_2_0:clearSpine()
		arg_2_0:_refreshSpineShow()
	end
end

function var_0_0.addResToLoader(arg_3_0, arg_3_1)
	arg_3_1:addPath(arg_3_0._spinePrefabRes)
	arg_3_1:addPath(arg_3_0._materialRes)
	arg_3_0.entity.critterspineeffect:addResToLoader(arg_3_1)
end

function var_0_0._onLoadOneFail(arg_4_0, arg_4_1, arg_4_2)
	logError("RoomCritterSpineComp: 加载失败, url: " .. arg_4_2.ResPath)
end

function var_0_0._onLoadFinish(arg_5_0, arg_5_1)
	var_0_0.super._onLoadFinish(arg_5_0, arg_5_1)

	arg_5_0._mountheadGO = gohelper.findChild(arg_5_0._spineGO, "mountroot/mounthead")

	if arg_5_0._mountheadGO then
		arg_5_0._mountheadGOTrs = arg_5_0._mountheadGO.transform
	end

	arg_5_0:_spawnShadowGO(arg_5_1)
	arg_5_0:_updateShadowOffset()
	arg_5_0:_cameraTransformUpdate()
	arg_5_0:setScale(arg_5_0._initScale)
	arg_5_0.entity.critterspineeffect:spawnEffect(arg_5_1)
	arg_5_0:refreshAnimState()
end

function var_0_0._spawnShadowGO(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._scene.preloader:getResource(RoomScenePreloader.ResEffectCharacterShadow)

	arg_6_0._shadowGO = gohelper.clone(var_6_0, arg_6_0.entity.containerGO, "shadow")
	arg_6_0._shadowGOTrs = arg_6_0._shadowGO.transform
	arg_6_0._shadowGO:GetComponent(typeof(UnityEngine.MeshRenderer)).sortingLayerName = "Default"

	transformhelper.setLocalPos(arg_6_0._shadowGOTrs, 0, 0.01, 0)
end

function var_0_0.setScale(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return
	end

	if gohelper.isNil(arg_7_0._spineGOTrs) then
		arg_7_0._initScale = arg_7_1
	else
		transformhelper.setLocalScale(arg_7_0._spineGOTrs, arg_7_1, arg_7_1, arg_7_1)
	end
end

function var_0_0.addEventListeners(arg_8_0)
	RoomMapController.instance:registerCallback(RoomEvent.CameraTransformUpdate, arg_8_0._cameraTransformUpdate, arg_8_0)
	RoomCharacterController.instance:registerCallback(RoomEvent.RefreshSpineShow, arg_8_0._refreshSpineShow, arg_8_0)
	RoomMapController.instance:registerCallback(RoomEvent.CameraTransformUpdate, arg_8_0._updateShadowOffset, arg_8_0)
	RoomCharacterController.instance:registerCallback(RoomEvent.UpdateCharacterMove, arg_8_0._onUpdate, arg_8_0)
	arg_8_0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, arg_8_0._onManufactureInfoUpdate, arg_8_0)
	arg_8_0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, arg_8_0._onManufactureInfoUpdate, arg_8_0)
	arg_8_0:addEventCb(CritterController.instance, CritterEvent.CritterFeedFood, arg_8_0._onFeedFood, arg_8_0)
	arg_8_0:addEventCb(CritterController.instance, CritterEvent.CritterInfoPushUpdate, arg_8_0._onCritterInfoUpdate, arg_8_0)
end

function var_0_0.removeEventListeners(arg_9_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.CameraTransformUpdate, arg_9_0._cameraTransformUpdate, arg_9_0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.RefreshSpineShow, arg_9_0._refreshSpineShow, arg_9_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.CameraTransformUpdate, arg_9_0._updateShadowOffset, arg_9_0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.UpdateCharacterMove, arg_9_0._onUpdate, arg_9_0)
	arg_9_0:removeEventCb(ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, arg_9_0._onManufactureInfoUpdate, arg_9_0)
	arg_9_0:removeEventCb(ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, arg_9_0._onManufactureInfoUpdate, arg_9_0)
	arg_9_0:removeEventCb(CritterController.instance, CritterEvent.CritterFeedFood, arg_9_0._onFeedFood, arg_9_0)
	arg_9_0:removeEventCb(CritterController.instance, CritterEvent.CritterInfoPushUpdate, arg_9_0._onCritterInfoUpdate, arg_9_0)
end

function var_0_0._onUpdate(arg_10_0)
	if arg_10_0._shadowPointGOTrs and arg_10_0._shadowGOTrs then
		local var_10_0, var_10_1, var_10_2 = transformhelper.getPos(arg_10_0._shadowPointGOTrs)

		transformhelper.setPos(arg_10_0._shadowGOTrs, var_10_0, var_10_1, var_10_2)
	end
end

function var_0_0.touch(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.entity:getMO()

	if math.random() >= arg_11_0._touchTamingRate then
		return
	end

	TaskDispatcher.cancelTask(arg_11_0._touchAfter, arg_11_0)

	if arg_11_1 and var_11_0 then
		local var_11_1 = 10

		var_11_0.isTouch = true
		arg_11_0._touchAction = true

		TaskDispatcher.runDelay(arg_11_0._touchAfter, arg_11_0, var_11_1)
		arg_11_0:play(arg_11_0:_getTouchStateName(), false, true)
	else
		arg_11_0:refreshAnimState()
	end
end

function var_0_0._touchAfter(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._touchAfter, arg_12_0)

	local var_12_0 = arg_12_0.entity:getMO()

	if var_12_0 then
		var_12_0.isTouch = false
	end

	arg_12_0._touchAction = false
end

function var_0_0._getTouchStateName(arg_13_0)
	local var_13_0 = RoomCharacterEnum.CharacterTamingAnimList

	return var_13_0[math.random(1, #var_13_0)] or var_13_0[1]
end

function var_0_0._onManufactureInfoUpdate(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.entity:getMO()
	local var_14_1 = var_14_0 and var_14_0:getStayBuilding()

	if not var_14_1 then
		return
	end

	if arg_14_1 and not arg_14_1[var_14_1] then
		return
	end

	arg_14_0:refreshAnimState()
end

function var_0_0._onFeedFood(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.entity:getMO()
	local var_15_1 = var_15_0 and var_15_0:getId()

	if not var_15_1 or arg_15_1 and not arg_15_1[var_15_1] then
		return
	end

	local var_15_2 = CritterModel.instance:getCritterMOByUid(var_15_1):getMoodValue()
	local var_15_3 = ManufactureConfig.instance:getManufactureConst(RoomManufactureEnum.ConstId.CritterMaxMood)
	local var_15_4 = tonumber(var_15_3) or 0
	local var_15_5 = RoomCharacterEnum.CharacterAnimStateName.SleepEnd

	if arg_15_0._curAnimState == RoomCharacterEnum.CharacterAnimStateName.Idle or arg_15_0._curAnimState == RoomCharacterEnum.CharacterAnimStateName.SpecialIdle then
		var_15_5 = RoomCharacterEnum.CharacterAnimStateName.Eat
	end

	if var_15_4 <= var_15_2 then
		arg_15_0:_realSetMoveState(RoomCharacterEnum.CharacterMoveState.MaxMoodEating)
	end

	arg_15_0:play(var_15_5, false)
end

function var_0_0._onCritterInfoUpdate(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.entity:getMO()
	local var_16_1 = var_16_0 and var_16_0:getId()

	if not var_16_1 or arg_16_1 and not arg_16_1[var_16_1] then
		return
	end

	arg_16_0:refreshAnimState()
end

function var_0_0._refreshSpineShow(arg_17_0)
	local var_17_0 = arg_17_0._scene.camera:getCameraState()

	arg_17_0._shouldShowSpine = RoomCharacterController.instance:checkCanSpineShow(var_17_0)

	arg_17_0:_refreshShowSpine()
end

function var_0_0._refreshShowSpine(arg_18_0, arg_18_1)
	if arg_18_0._isInDistance and arg_18_0._shouldShowSpine then
		if not arg_18_0._isShow or arg_18_1 then
			arg_18_0._isShow = true
			arg_18_0._isHide = false

			arg_18_0:showSpine()
		end
	elseif not arg_18_0._isHide or arg_18_1 then
		arg_18_0._isShow = false
		arg_18_0._isHide = true

		arg_18_0:hideSpine()
	end
end

function var_0_0.refreshAnimState(arg_19_0)
	local var_19_0 = arg_19_0.entity:getMO()

	if not var_19_0 then
		return
	end

	arg_19_0.entity:stopCommonInteractionEff(RoomCharacterEnum.CommonEffect.CritterAngry)

	local var_19_1 = var_19_0:getStayBuilding()
	local var_19_2 = RoomMapBuildingModel.instance:getBuildingMOById(var_19_1)
	local var_19_3 = var_19_2 and var_19_2.buildingId

	if var_19_3 then
		local var_19_4 = RoomConfig.instance:getBuildingType(var_19_3)

		if ManufactureConfig.instance:isManufactureBuilding(var_19_3) then
			arg_19_0:playManufactureAnim(var_19_2)
		elseif var_19_4 == RoomBuildingEnum.BuildingType.Rest then
			arg_19_0:playRestingAnim()
		end
	elseif var_19_0.isTouch then
		if arg_19_0._touchAction then
			arg_19_0:play(arg_19_0:_getTouchStateName(), false, false)
		else
			local var_19_5, var_19_6 = arg_19_0:getIdleAnim()

			arg_19_0:play(var_19_5, var_19_6, false)
		end
	else
		local var_19_7 = var_19_0.critterId
		local var_19_8 = arg_19_0:getAnimState()
		local var_19_9 = RoomCritterModel.instance:getTempCritterMO()

		if var_19_8 ~= RoomCharacterEnum.CharacterAnimStateName.SpecialIdle or RoomCharacterHelper.getAnimStateName(arg_19_0._moveState, var_19_7) ~= RoomCharacterHelper.getIdleAnimStateName(var_19_7) or var_19_9 and var_19_9.id == arg_19_0.entity.id then
			local var_19_10

			if arg_19_0._moveState == RoomCharacterEnum.CharacterMoveState.Idle then
				var_19_10 = arg_19_0:getIdleAnim()
			else
				var_19_10 = RoomCharacterHelper.getAnimStateName(arg_19_0._moveState, var_19_7)
			end

			arg_19_0:play(var_19_10, RoomCharacterEnum.CharacterLoopAnimState[arg_19_0._moveState] or false, false)
		end
	end
end

function var_0_0.play(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if not arg_20_1 then
		return
	end

	if not arg_20_0._skeletonAnim then
		return
	end

	arg_20_2 = arg_20_2 or false
	arg_20_3 = arg_20_3 or false

	if not (arg_20_3 or arg_20_1 ~= arg_20_0._curAnimState or arg_20_2 ~= arg_20_0._isLoop) then
		return
	end

	arg_20_0._curAnimState = arg_20_1
	arg_20_0._isLoop = arg_20_2

	if arg_20_0._skeletonAnim:HasAnimation(arg_20_1) then
		arg_20_0._skeletonAnim:SetAnimation(0, arg_20_1, arg_20_0._isLoop, 0)
		arg_20_0.entity.critterspineeffect:play(arg_20_1)
	else
		local var_20_0 = gohelper.isNil(arg_20_0._spineGO) and "nil" or arg_20_0._spineGO.name

		logError(string.format("critterId:%s  skinId:%s  animName:%s  goName:%s  Animation Name not exist ", arg_20_0._critterId, arg_20_0._skinId, arg_20_1, var_20_0))
	end
end

function var_0_0.playManufactureAnim(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0.entity:getMO():getId()
	local var_21_1 = CritterModel.instance:getCritterMOByUid(var_21_0):getMoodValue()
	local var_21_2, var_21_3 = arg_21_0:getIdleAnim()
	local var_21_4 = arg_21_1:getManufactureState()

	if var_21_1 > 0 then
		if var_21_4 == RoomManufactureEnum.ManufactureState.Running then
			var_21_2 = RoomCharacterEnum.CharacterAnimStateName.Produce

			if RoomConfig.instance:getBuildingType(arg_21_1.buildingId) == RoomBuildingEnum.BuildingType.Collect then
				var_21_2 = RoomCharacterEnum.CharacterAnimStateName.Collect
			end

			var_21_3 = true
		elseif var_21_4 == RoomManufactureEnum.ManufactureState.Stop then
			var_21_2 = RoomCharacterEnum.CharacterAnimStateName.Sleep
			var_21_3 = true
		end
	else
		arg_21_0.entity:playCommonInteractionEff(RoomCharacterEnum.CommonEffect.CritterAngry)
	end

	arg_21_0:play(var_21_2, var_21_3)
end

function var_0_0.playRestingAnim(arg_22_0)
	local var_22_0 = arg_22_0.entity:getMO():getId()
	local var_22_1 = CritterModel.instance:getCritterMOByUid(var_22_0):getMoodValue()
	local var_22_2 = ManufactureConfig.instance:getManufactureConst(RoomManufactureEnum.ConstId.CritterMaxMood)
	local var_22_3 = tonumber(var_22_2) or 0
	local var_22_4, var_22_5 = arg_22_0:getIdleAnim()
	local var_22_6 = arg_22_0._moveState == RoomCharacterEnum.CharacterMoveState.Sleep
	local var_22_7 = var_22_0 == ManufactureModel.instance:getNewRestCritter()

	if var_22_1 < var_22_3 then
		if arg_22_0._curAnimState and var_22_6 then
			return
		end

		if var_22_7 then
			var_22_5 = false

			ManufactureModel.instance:setNewRestCritter()

			var_22_4 = RoomCharacterEnum.CharacterAnimStateName.SleepStart
		else
			var_22_4 = RoomCharacterEnum.CharacterAnimStateName.Sleep
		end

		arg_22_0:_realSetMoveState(RoomCharacterEnum.CharacterMoveState.Sleep)
	elseif not var_22_7 and arg_22_0._curAnimState then
		if not var_22_6 then
			return
		end

		var_22_5 = false
		var_22_4 = RoomCharacterEnum.CharacterAnimStateName.SleepEnd

		arg_22_0:_realSetMoveState(RoomCharacterEnum.CharacterMoveState.Idle)
	end

	arg_22_0:play(var_22_4, var_22_5)
end

function var_0_0._onAnimCallback(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	if not (arg_23_2 == SpineAnimEvent.ActionComplete) then
		return
	end

	local var_23_0
	local var_23_1 = true

	if arg_23_1 == RoomCharacterEnum.CharacterAnimStateName.Idle then
		var_23_0, var_23_1 = arg_23_0:getIdleAnim()
	else
		if arg_23_0._curAnimState ~= arg_23_1 or arg_23_0._isLoop then
			return
		end

		var_23_0 = RoomCharacterHelper.getNextAnimStateName(arg_23_0._moveState, arg_23_1)

		if var_23_0 then
			var_23_1 = var_23_0 == arg_23_1
		else
			var_23_0 = RoomCharacterHelper.getIdleAnimStateName(arg_23_0._critterId)
		end

		if arg_23_0._moveState == RoomCharacterEnum.CharacterMoveState.MaxMoodEating and var_23_0 == RoomCharacterEnum.CharacterAnimStateName.Idle then
			arg_23_0:_realSetMoveState(RoomCharacterEnum.CharacterMoveState.Idle)
		end
	end

	arg_23_0:play(var_23_0, var_23_1, false)
end

function var_0_0.playAnim(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4, arg_24_5)
	local var_24_0 = arg_24_0:_checkAnimator(arg_24_1)

	arg_24_0._callback = arg_24_4
	arg_24_0._callbackObj = arg_24_5

	if not arg_24_4 then
		if var_24_0 then
			arg_24_0._animator.enabled = true

			arg_24_0._animator:Play(arg_24_2, 0, arg_24_3 or 0)
		end
	else
		TaskDispatcher.cancelTask(arg_24_0._animDone, arg_24_0)

		if var_24_0 then
			arg_24_0._animatorPlayer:Play(arg_24_2, arg_24_0._animDone, arg_24_0)
		else
			TaskDispatcher.runDelay(arg_24_0._animDone, arg_24_0, 0.1)
		end
	end
end

function var_0_0._checkAnimator(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0._scene.preloader:getResource(arg_25_1)

	if var_25_0 then
		arg_25_0._animator = gohelper.onceAddComponent(arg_25_0.entity.containerGO, typeof(UnityEngine.Animator))
		arg_25_0._animatorPlayer = gohelper.onceAddComponent(arg_25_0.entity.containerGO, typeof(SLFramework.AnimatorPlayer))
		arg_25_0._animator.runtimeAnimatorController = var_25_0

		return true
	end

	return false
end

function var_0_0.clearAnim(arg_26_0)
	arg_26_0._callback = nil
	arg_26_0._callbackObj = nil

	if arg_26_0._animatorPlayer then
		UnityEngine.Component.DestroyImmediate(arg_26_0._animatorPlayer)

		arg_26_0._animatorPlayer = nil
	end

	if arg_26_0._animator then
		UnityEngine.Component.DestroyImmediate(arg_26_0._animator)

		arg_26_0._animator = nil
	end
end

function var_0_0._animDone(arg_27_0)
	if arg_27_0._callback then
		arg_27_0._callback(arg_27_0._callbackObj)
	end
end

function var_0_0.changeMoveState(arg_28_0, arg_28_1)
	if arg_28_0._moveState == arg_28_1 then
		return
	end

	arg_28_0:_realSetMoveState(arg_28_1)
	arg_28_0:refreshAnimState()
end

function var_0_0._realSetMoveState(arg_29_0, arg_29_1)
	arg_29_0._moveState = arg_29_1
end

function var_0_0.characterPosChanged(arg_30_0)
	arg_30_0:_cameraTransformUpdate()
end

function var_0_0._cameraTransformUpdate(arg_31_0)
	local var_31_0 = arg_31_0._scene.camera:getCameraFocus()
	local var_31_1, var_31_2, var_31_3 = transformhelper.getPos(arg_31_0.goTrs)
	local var_31_4 = Vector2(var_31_1, var_31_3)
	local var_31_5 = Vector2.Distance(var_31_0, var_31_4)

	if var_31_5 < 3.5 then
		arg_31_0._isInDistance = true
	elseif var_31_5 > 4.5 then
		arg_31_0._isInDistance = false
	end

	arg_31_0:_refreshShowSpine()

	if arg_31_0._spineGO and arg_31_0._spineGO.activeInHierarchy then
		arg_31_0:refreshRotation()
	end
end

function var_0_0._updateShadowOffset(arg_32_0)
	if not arg_32_0._material then
		return
	end

	local var_32_0 = arg_32_0._scene.character:getShadowOffset()

	arg_32_0._material:SetVector("_ShadowOffset", var_32_0)
end

function var_0_0.getIdleAnim(arg_33_0)
	local var_33_0 = true
	local var_33_1 = RoomCharacterHelper.getIdleAnimStateName(arg_33_0._critterId)

	if arg_33_0:isRandomSpecialRate() then
		var_33_0 = false
		var_33_1 = RoomCharacterEnum.CharacterAnimStateName.SpecialIdle
	end

	return var_33_1, var_33_0
end

function var_0_0.isRandomSpecialRate(arg_34_0)
	local var_34_0 = false

	if arg_34_0.entity:getMO():getSpecialRate() > math.random() then
		var_34_0 = true
	end

	return var_34_0
end

function var_0_0.isShowAnimShadow(arg_35_0)
	return true
end

function var_0_0.getShadowGO(arg_36_0)
	return arg_36_0._shadowGO
end

function var_0_0.getMountheadGO(arg_37_0)
	return arg_37_0._mountheadGO
end

function var_0_0.getMountheadGOTrs(arg_38_0)
	return arg_38_0._mountheadGOTrs
end

function var_0_0.clearSpine(arg_39_0)
	if arg_39_0.entity and arg_39_0.entity.critterspineeffect then
		arg_39_0.entity.critterspineeffect:clearEffect()
	end

	var_0_0.super.clearSpine(arg_39_0)

	if arg_39_0._loader then
		arg_39_0._loader:dispose()

		arg_39_0._loader = nil
	end

	if arg_39_0._shadowGO then
		gohelper.destroy(arg_39_0._shadowGO)

		arg_39_0._shadowGO = nil
		arg_39_0._shadowGOTrs = nil
	end

	arg_39_0._skeletonAnim = nil
	arg_39_0._curAnimState = nil
	arg_39_0._isLoop = nil
	arg_39_0._mountheadGO = nil
	arg_39_0._mountheadGOTrs = nil
	arg_39_0._shadowPointGOTrs = nil

	arg_39_0.entity:stopAllCommonInteractionEff()
	TaskDispatcher.cancelTask(arg_39_0._animDone, arg_39_0)
end

function var_0_0.beforeDestroy(arg_40_0)
	arg_40_0:removeEventListeners()
	arg_40_0:clearSpine()
end

return var_0_0
