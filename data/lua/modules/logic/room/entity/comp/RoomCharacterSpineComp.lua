module("modules.logic.room.entity.comp.RoomCharacterSpineComp", package.seeall)

local var_0_0 = class("RoomCharacterSpineComp", RoomBaseSpineComp)
local var_0_1 = 0.01

function var_0_0.onInit(arg_1_0)
	local var_1_0 = arg_1_0.entity:getMO()

	arg_1_0._skinId = var_1_0.skinId
	arg_1_0._heroId = var_1_0.heroId
	arg_1_0._roomCharacterCfg = var_1_0.roomCharacterConfig
	arg_1_0._characterRes = RoomResHelper.getCharacterPath(arg_1_0._skinId)
	arg_1_0._animalRes = RoomResHelper.getAnimalPath(arg_1_0._skinId)
	arg_1_0._cameraAnimABRes = RoomResHelper.getCharacterCameraAnimABPath(var_1_0.roomCharacterConfig.cameraAnimPath)
	arg_1_0._cameraAnimRes = RoomResHelper.getCharacterCameraAnimPath(var_1_0.roomCharacterConfig.cameraAnimPath)
	arg_1_0._effectABRes = RoomResHelper.getCharacterEffectABPath(var_1_0.roomCharacterConfig.effectPath)
	arg_1_0._effectRes = RoomResHelper.getCharacterEffectPath(var_1_0.roomCharacterConfig.effectPath)
	arg_1_0._isShow = false
	arg_1_0._isHide = false
	arg_1_0._shouldShowCharacter = false
	arg_1_0._isInDistance = false
	arg_1_0._alpha = 1
	arg_1_0._zeroMix = var_1_0.roomCharacterConfig.zeroMix
	arg_1_0._spinePrefabRes = arg_1_0._characterRes

	if var_1_0.isAnimal then
		arg_1_0._spinePrefabRes = arg_1_0._animalRes
	end

	arg_1_0:refreshAnimal()
	arg_1_0:_cameraTransformUpdate()
	arg_1_0:_refreshSpineShow()
end

function var_0_0.refreshAnimal(arg_2_0)
	local var_2_0 = arg_2_0.entity:getMO()

	if not var_2_0 then
		return
	end

	local var_2_1 = var_2_0.isAnimal or false
	local var_2_2 = arg_2_0._isAnimal ~= var_2_1

	arg_2_0._isAnimal = var_2_1

	if var_2_2 then
		arg_2_0._spinePrefabRes = var_2_1 and arg_2_0._animalRes or arg_2_0._characterRes

		arg_2_0:clearSpine()
		arg_2_0:_refreshShowCharacter(true)
	end
end

function var_0_0.addEventListeners(arg_3_0)
	RoomMapController.instance:registerCallback(RoomEvent.CameraTransformUpdate, arg_3_0._cameraTransformUpdate, arg_3_0)
	RoomCharacterController.instance:registerCallback(RoomEvent.RefreshSpineShow, arg_3_0._refreshSpineShow, arg_3_0)
	RoomMapController.instance:registerCallback(RoomEvent.CameraTransformUpdate, arg_3_0._updateShadowOffset, arg_3_0)
	RoomCharacterController.instance:registerCallback(RoomEvent.UpdateCharacterMove, arg_3_0._onUpdate, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.CameraTransformUpdate, arg_4_0._cameraTransformUpdate, arg_4_0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.RefreshSpineShow, arg_4_0._refreshSpineShow, arg_4_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.CameraTransformUpdate, arg_4_0._updateShadowOffset, arg_4_0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.UpdateCharacterMove, arg_4_0._onUpdate, arg_4_0)
end

function var_0_0.characterPosChanged(arg_5_0)
	arg_5_0:_cameraTransformUpdate()
end

function var_0_0._cameraTransformUpdate(arg_6_0)
	local var_6_0 = arg_6_0._scene.camera:getCameraFocus()
	local var_6_1, var_6_2, var_6_3 = transformhelper.getPos(arg_6_0.goTrs)
	local var_6_4 = Vector2(var_6_1, var_6_3)
	local var_6_5 = Vector2.Distance(var_6_0, var_6_4)

	if var_6_5 < 3.5 then
		arg_6_0._isInDistance = true
	elseif var_6_5 > 4.5 then
		arg_6_0._isInDistance = false
	end

	arg_6_0:_refreshShowCharacter()

	if arg_6_0._spineGO and arg_6_0._spineGO.activeInHierarchy then
		arg_6_0:refreshRotation()
	end

	arg_6_0:refreshEffectPos()
end

function var_0_0._onUpdate(arg_7_0)
	if arg_7_0._shadowPointGOTrs and arg_7_0._shadowGOTrs then
		local var_7_0, var_7_1, var_7_2 = transformhelper.getPos(arg_7_0._shadowPointGOTrs)

		transformhelper.setPos(arg_7_0._shadowGOTrs, var_7_0, var_7_1, var_7_2)
	end
end

function var_0_0.refreshEffectPos(arg_8_0)
	if not arg_8_0._specialIdleGO then
		return
	end

	local var_8_0 = arg_8_0._specialIdleGOTrs.position
	local var_8_1 = RoomBendingHelper.worldToBendingSimple(var_8_0)

	arg_8_0._specialIdleGOTrs.localPosition = Vector3(0, var_8_1.y, 0)
end

function var_0_0._refreshSpineShow(arg_9_0)
	local var_9_0 = arg_9_0._scene.camera:getCameraState()

	arg_9_0._shouldShowCharacter = RoomCharacterController.instance:checkCanSpineShow(var_9_0)

	arg_9_0:_refreshShowCharacter()
end

function var_0_0.changeMoveState(arg_10_0, arg_10_1)
	if arg_10_0._moveState == arg_10_1 then
		return
	end

	arg_10_0._moveState = arg_10_1

	arg_10_0:refreshAnimState()
end

function var_0_0.touch(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.entity:getMO()

	TaskDispatcher.cancelTask(arg_11_0._touchAfter, arg_11_0)

	if arg_11_1 then
		arg_11_0._touchAction = true

		TaskDispatcher.runDelay(arg_11_0._touchAfter, arg_11_0, 13)

		if arg_11_0:isRandomSpecialRate() then
			arg_11_0:tryPlaySpecialIdle()
		else
			arg_11_0:play(RoomCharacterEnum.CharacterAnimStateName.Touch, false, true)
		end

		local var_11_1 = var_11_0.roomCharacterConfig.roleVoice

		if not string.nilorempty(var_11_1) then
			local var_11_2 = string.splitToNumber(var_11_1, "|")
			local var_11_3 = #var_11_2

			if var_11_3 > 0 then
				local var_11_4

				if arg_11_0._heroId then
					local var_11_5, var_11_6, var_11_7 = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(arg_11_0._heroId)
					local var_11_8 = LangSettings.shortcutTab[var_11_5]

					if not string.nilorempty(var_11_8) and not var_11_7 then
						var_11_4 = var_11_8
					end
				end

				local var_11_9 = math.random(1, var_11_3)

				if var_11_4 then
					arg_11_0:playVoiceWithLang(var_11_2[var_11_9], var_11_4)
				else
					arg_11_0:playVoice(var_11_2[var_11_9])
				end
			end
		end
	else
		arg_11_0:refreshAnimState()
	end
end

function var_0_0.isRandomSpecialRate(arg_12_0)
	local var_12_0 = arg_12_0.entity:getMO()

	if not var_12_0:isHasSpecialIdle() then
		return false
	end

	if var_12_0:getSpecialRate() <= math.random() then
		return false
	end

	local var_12_1 = var_12_0:getSpecialIdleWaterDistance()

	if var_12_1 > 0 and RoomCharacterHelper.hasWaterNodeNear(arg_12_0.goTrs.position, var_12_1) then
		return false
	end

	return true
end

function var_0_0.refreshAnimState(arg_13_0)
	local var_13_0 = arg_13_0.entity:getMO()

	if not var_13_0 then
		return
	end

	if arg_13_0._isAnimal then
		arg_13_0:play(RoomCharacterEnum.CharacterAnimalAnimStateName.Jump, false, true)
	elseif var_13_0.isTouch then
		if arg_13_0._touchAction then
			arg_13_0:play(RoomCharacterEnum.CharacterAnimStateName.Touch, false, false)
		else
			arg_13_0:play(RoomCharacterHelper.getIdleAnimStateName(var_13_0.heroId), true, false)
		end
	else
		local var_13_1 = arg_13_0:getAnimState()
		local var_13_2 = RoomCharacterModel.instance:getTempCharacterMO()

		if var_13_1 ~= RoomCharacterEnum.CharacterAnimStateName.SpecialIdle or RoomCharacterHelper.getAnimStateName(arg_13_0._moveState, var_13_0.heroId) ~= RoomCharacterHelper.getIdleAnimStateName(var_13_0.heroId) or var_13_2 and var_13_2.id == arg_13_0.entity.id then
			local var_13_3 = RoomCharacterEnum.CharacterLoopAnimState[arg_13_0._moveState] or false
			local var_13_4 = not var_13_3 and arg_13_0._isAnimalActionComplete and true or false

			arg_13_0:play(RoomCharacterHelper.getAnimStateName(arg_13_0._moveState, var_13_0.heroId), var_13_3, var_13_4)
		end
	end
end

function var_0_0.changeLookDir(arg_14_0, arg_14_1)
	arg_14_0:setLookDir(arg_14_1)
end

function var_0_0._refreshShowCharacter(arg_15_0, arg_15_1)
	if arg_15_0._isInDistance and arg_15_0._shouldShowCharacter then
		if not arg_15_0._isShow or arg_15_1 then
			arg_15_0._isShow = true
			arg_15_0._isHide = false

			arg_15_0:showSpine()
		end
	elseif not arg_15_0._isHide or arg_15_1 then
		arg_15_0._isShow = false
		arg_15_0._isHide = true

		arg_15_0:hideSpine()
	end
end

function var_0_0.addResToLoader(arg_16_0, arg_16_1)
	var_0_0.super.addResToLoader(arg_16_0, arg_16_1)

	if not string.nilorempty(arg_16_0._cameraAnimABRes) then
		arg_16_1:addPath(arg_16_0._cameraAnimABRes)
	end

	if not string.nilorempty(arg_16_0._effectABRes) then
		arg_16_1:addPath(arg_16_0._effectABRes)
	end

	arg_16_0.entity.characterspineeffect:addResToLoader(arg_16_1)
end

function var_0_0._onLoadFinish(arg_17_0, arg_17_1)
	var_0_0.super._onLoadFinish(arg_17_0, arg_17_1)

	if not string.nilorempty(arg_17_0._cameraAnimABRes) then
		arg_17_0._cameraAnimController = arg_17_1:getAssetItem(arg_17_0._cameraAnimABRes):GetResource(arg_17_0._cameraAnimRes)
	end

	if not string.nilorempty(arg_17_0._effectABRes) then
		arg_17_0._effectPrefab = arg_17_1:getAssetItem(arg_17_0._effectABRes):GetResource(arg_17_0._effectRes)
	end

	arg_17_0._mountheadGO = gohelper.findChild(arg_17_0._spineGO, "mountroot/mounthead")

	if arg_17_0._mountheadGO then
		arg_17_0._mountheadGOTrs = arg_17_0._mountheadGO.transform
	end

	arg_17_0._shadowPointGOTrs = nil

	if not string.nilorempty(arg_17_0._roomCharacterCfg.shadow) then
		local var_17_0 = gohelper.findChild(arg_17_0._spineGO, "mountroot/" .. arg_17_0._roomCharacterCfg.shadow)

		if var_17_0 then
			arg_17_0._shadowPointGOTrs = var_17_0.transform
		end
	end

	arg_17_0:_spawnShadowGO(arg_17_1)
	arg_17_0:_updateShadowOffset()
	arg_17_0.entity.characterspineeffect:spawnEffect(arg_17_1)
	arg_17_0:refreshAnimState()
	arg_17_0:_cameraTransformUpdate()
end

function var_0_0._spawnShadowGO(arg_18_0, arg_18_1)
	if arg_18_0.entity:getMO():getCanWade() then
		return
	end

	local var_18_0 = arg_18_0._scene.preloader:getResource(RoomScenePreloader.ResEffectCharacterShadow)

	arg_18_0._shadowGO = gohelper.clone(var_18_0, arg_18_0.entity.containerGO, "shadow")
	arg_18_0._shadowGOTrs = arg_18_0._shadowGO.transform
	arg_18_0._shadowGO:GetComponent(typeof(UnityEngine.MeshRenderer)).sortingLayerName = "Default"

	transformhelper.setLocalPos(arg_18_0._shadowGOTrs, 0, var_0_1, 0)
end

function var_0_0._updateShadowOffset(arg_19_0)
	if not arg_19_0._material then
		return
	end

	local var_19_0 = arg_19_0._scene.character:getShadowOffset()

	arg_19_0._material:SetVector("_ShadowOffset", var_19_0)
end

function var_0_0._onLoadOneFail(arg_20_0, arg_20_1, arg_20_2)
	logError("RoomCharacterSpineComp: 加载失败, url: " .. arg_20_2.ResPath)
end

function var_0_0.play(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	if not arg_21_1 then
		return
	end

	if not arg_21_0._skeletonAnim then
		return
	end

	arg_21_2 = arg_21_2 or false
	arg_21_3 = arg_21_3 or false
	arg_21_0._playAnimal = arg_21_0._playAnimal or false

	if not (arg_21_3 or arg_21_1 ~= arg_21_0._curAnimState or arg_21_2 ~= arg_21_0._isLoop or arg_21_0._playAnimal ~= arg_21_0._isAnimal) then
		return
	end

	if arg_21_1 ~= RoomCharacterEnum.CharacterAnimStateName.SpecialIdle then
		arg_21_0:_stopPlaySpecialIdle()
	end

	local var_21_0 = arg_21_0._curAnimState

	arg_21_0._curAnimState = arg_21_1
	arg_21_0._isLoop = arg_21_2
	arg_21_0._playAnimal = arg_21_0._isAnimal

	if arg_21_0._skeletonAnim:HasAnimation(arg_21_1) then
		if arg_21_0._zeroMix and (arg_21_1 ~= var_21_0 or arg_21_3) then
			arg_21_0._skeletonAnim:SetAnimation(0, arg_21_1, arg_21_0._isLoop, 0)

			arg_21_0._skeletonAnim.loop = arg_21_0._isLoop
		else
			arg_21_0._skeletonAnim:PlayAnim(arg_21_1, arg_21_0._isLoop, arg_21_3)
		end

		arg_21_0:_moveCharacterUp(arg_21_1)
		arg_21_0:_updateAnimShadow(arg_21_1)
		arg_21_0.entity.characterspineeffect:play(arg_21_1)
	else
		local var_21_1 = gohelper.isNil(arg_21_0._spineGO) and "nil" or arg_21_0._spineGO.name

		logError(string.format("heroId:%s  skinId:%s  animName:%s  goName:%s  Animation Name not exist ", arg_21_0._heroId, arg_21_0._skinId, arg_21_1, var_21_1))
	end
end

function var_0_0._moveCharacterUp(arg_22_0, arg_22_1)
	TaskDispatcher.cancelTask(arg_22_0._moveUp, arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0._moveDown, arg_22_0)

	local var_22_0 = arg_22_0.entity:getMO()

	if not var_22_0 then
		return
	end

	local var_22_1 = var_22_0.skinId

	arg_22_0._moveConfig = RoomConfig.instance:getCharacterAnimConfig(var_22_1, arg_22_1)

	if not arg_22_0._moveConfig then
		arg_22_0:_killMoveTween()

		if arg_22_0._spineGO then
			arg_22_0._spineMoveTweenId = ZProj.TweenHelper.DOLocalMoveY(arg_22_0._spineGOTrs, var_0_1, 0.05)
		end

		if arg_22_0._shadowGO then
			arg_22_0._shadowMoveTweenId = ZProj.TweenHelper.DOLocalMoveY(arg_22_0._shadowGOTrs, var_0_1, 0.05)
		end

		return
	end

	if arg_22_0._moveConfig.upTime > 0 then
		TaskDispatcher.runDelay(arg_22_0._moveUp, arg_22_0, arg_22_0._moveConfig.upTime / 1000)
	else
		arg_22_0:_moveUp()
	end

	if arg_22_0._moveConfig.downTime > 0 then
		TaskDispatcher.runDelay(arg_22_0._moveDown, arg_22_0, arg_22_0._moveConfig.downTime / 1000)
	end
end

function var_0_0._moveUp(arg_23_0)
	if not arg_23_0._moveConfig then
		return
	end

	arg_23_0:_killMoveTween()

	arg_23_0._spineMoveTweenId = ZProj.TweenHelper.DOLocalMoveY(arg_23_0._spineGOTrs, arg_23_0._moveConfig.upDistance / 1000, arg_23_0._moveConfig.upDuration / 1000)
	arg_23_0._shadowMoveTweenId = ZProj.TweenHelper.DOLocalMoveY(arg_23_0._shadowGOTrs, arg_23_0._moveConfig.upDistance / 1000, arg_23_0._moveConfig.upDuration / 1000)
end

function var_0_0._moveDown(arg_24_0)
	if not arg_24_0._moveConfig then
		return
	end

	arg_24_0:_killMoveTween()

	arg_24_0._spineMoveTweenId = ZProj.TweenHelper.DOLocalMoveY(arg_24_0._spineGOTrs, var_0_1, arg_24_0._moveConfig.downDuration / 1000)
	arg_24_0._shadowMoveTweenId = ZProj.TweenHelper.DOLocalMoveY(arg_24_0._shadowGOTrs, var_0_1, arg_24_0._moveConfig.downDuration / 1000)
end

function var_0_0._killMoveTween(arg_25_0)
	if arg_25_0._spineMoveTweenId then
		ZProj.TweenHelper.KillById(arg_25_0._spineMoveTweenId)
	end

	if arg_25_0._shadowMoveTweenId then
		ZProj.TweenHelper.KillById(arg_25_0._shadowMoveTweenId)
	end
end

function var_0_0._onAnimCallback(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = GameSceneMgr.instance:getCurScene()
	local var_26_1 = arg_26_0.entity:getMO()

	arg_26_0._isAnimalActionComplete = arg_26_2 == SpineAnimEvent.ActionComplete

	if arg_26_0._isAnimal and arg_26_1 == RoomCharacterEnum.CharacterAnimalAnimStateName.Jump and arg_26_2 == SpineAnimEvent.ActionComplete then
		var_26_0.character:setCharacterAnimal(arg_26_0.entity.id, false)
	elseif not arg_26_0._isAnimal and arg_26_0._touchAction and arg_26_2 == SpineAnimEvent.ActionComplete then
		arg_26_0._touchAction = false

		if arg_26_1 == RoomCharacterEnum.CharacterAnimStateName.SpecialIdle then
			arg_26_0:_stopPlaySpecialIdle()
		end

		arg_26_0:refreshAnimState()
		TaskDispatcher.cancelTask(arg_26_0._touchAfter, arg_26_0)
		TaskDispatcher.runDelay(arg_26_0._touchAfter, arg_26_0, RoomCharacterEnum.WaitingTimeAfterTouch)
	elseif not arg_26_0._isAnimal and arg_26_1 == RoomCharacterEnum.CharacterAnimStateName.SpecialIdle and arg_26_2 == SpineAnimEvent.ActionComplete then
		arg_26_0:_stopPlaySpecialIdle()

		local var_26_2 = RoomCharacterHelper.getAnimStateName(arg_26_0._moveState, var_26_1.heroId)

		arg_26_0:play(var_26_2, RoomCharacterEnum.CharacterLoopAnimState[arg_26_0._moveState] or false, false)
	elseif not arg_26_0._isAnimal and arg_26_0._curAnimState == arg_26_1 and arg_26_0._isLoop ~= true and arg_26_2 == SpineAnimEvent.ActionComplete then
		local var_26_3 = RoomCharacterHelper.getNextAnimStateName(arg_26_0._moveState, arg_26_1)

		if var_26_3 then
			arg_26_0:play(var_26_3, var_26_3 == arg_26_1, false)
		else
			arg_26_0:play(RoomCharacterHelper.getIdleAnimStateName(var_26_1.heroId), true, false)
		end
	end
end

function var_0_0._stopPlaySpecialIdle(arg_27_0)
	if arg_27_0._specialIdleAnimator then
		arg_27_0._specialIdleAnimator.enabled = false
	end

	if arg_27_0._specialIdleGO then
		gohelper.setActive(arg_27_0._specialIdleGO, false)
	end

	if arg_27_0._spineGO then
		ZProj.CharacterSetVariantHelper.Disable(arg_27_0._spineGO)
	end

	if arg_27_0._meshRenderer and arg_27_0._material then
		arg_27_0._meshRenderer.material = arg_27_0._material
	end
end

function var_0_0.tryPlaySpecialIdle(arg_28_0)
	if not arg_28_0._spineGO then
		return
	end

	if arg_28_0.entity:getMO():isHasSpecialIdle() and arg_28_0._curAnimState ~= RoomCharacterEnum.CharacterAnimStateName.SpecialIdle then
		arg_28_0:play(RoomCharacterEnum.CharacterAnimStateName.SpecialIdle, false, false)

		if arg_28_0._cameraAnimController then
			if not arg_28_0._specialIdleAnimator then
				arg_28_0._specialIdleAnimator = gohelper.onceAddComponent(arg_28_0._spineGO, typeof(UnityEngine.Animator))
				arg_28_0._specialIdleAnimator.runtimeAnimatorController = arg_28_0._cameraAnimController
			else
				arg_28_0._specialIdleAnimator.runtimeAnimatorController = nil
				arg_28_0._specialIdleAnimator.enabled = false
				arg_28_0._specialIdleAnimator.enabled = true
				arg_28_0._specialIdleAnimator.runtimeAnimatorController = arg_28_0._cameraAnimController
			end
		end

		if arg_28_0._effectPrefab then
			if not arg_28_0._specialIdleGO then
				local var_28_0 = gohelper.findChild(arg_28_0._spineGO, "mountroot/mountbottom")

				arg_28_0._specialIdleGO = gohelper.clone(arg_28_0._effectPrefab, var_28_0 or arg_28_0._spineGO, "special_idle_effect")
				arg_28_0._specialIdleGOTrs = arg_28_0._specialIdleGO.transform
			else
				gohelper.setActive(arg_28_0._specialIdleGO, false)
				gohelper.setActive(arg_28_0._specialIdleGO, true)
			end

			local var_28_1 = gohelper.findChild(arg_28_0._specialIdleGO, arg_28_0._effectPrefab.name .. "_r")
			local var_28_2 = gohelper.findChild(arg_28_0._specialIdleGO, arg_28_0._effectPrefab.name .. "_l")

			gohelper.setActive(var_28_1, arg_28_0._lookDir == SpineLookDir.Left)
			gohelper.setActive(var_28_2, arg_28_0._lookDir == SpineLookDir.Right)
		end
	end
end

function var_0_0._updateAnimShadow(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0:_isShowAnimShadow(arg_29_1)

	if arg_29_0._isLastAminShadow ~= var_29_0 then
		arg_29_0._isLastAminShadow = var_29_0

		if var_29_0 then
			arg_29_0._meshRenderer.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.On
		else
			arg_29_0._meshRenderer.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off
		end
	end
end

function var_0_0._isShowAnimShadow(arg_30_0, arg_30_1)
	local var_30_0 = RoomConfig.instance:getCharacterShadowConfig(arg_30_0._skinId, arg_30_1 or arg_30_0._curAnimState)

	if var_30_0 and var_30_0.shadow == 1 then
		return false
	end

	return true
end

function var_0_0._touchAfter(arg_31_0)
	TaskDispatcher.cancelTask(arg_31_0._touchAfter, arg_31_0)
	GameSceneMgr.instance:getCurScene().character:setCharacterTouch(arg_31_0.entity.id, false)
end

function var_0_0.getCharacterGO(arg_32_0)
	return arg_32_0:getSpineGO()
end

function var_0_0.getShadowGO(arg_33_0)
	return arg_33_0._shadowGO
end

function var_0_0.getMountheadGO(arg_34_0)
	return arg_34_0._mountheadGO
end

function var_0_0.getMountheadGOTrs(arg_35_0)
	return arg_35_0._mountheadGOTrs
end

function var_0_0._checkAnimator(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0._scene.preloader:getResource(arg_36_1)

	if var_36_0 then
		arg_36_0._animator = gohelper.onceAddComponent(arg_36_0.entity.containerGO, typeof(UnityEngine.Animator))
		arg_36_0._animatorPlayer = gohelper.onceAddComponent(arg_36_0.entity.containerGO, typeof(SLFramework.AnimatorPlayer))
		arg_36_0._animator.runtimeAnimatorController = var_36_0

		return true
	end

	return false
end

function var_0_0.playAnim(arg_37_0, arg_37_1, arg_37_2, arg_37_3, arg_37_4, arg_37_5)
	local var_37_0 = arg_37_0:_checkAnimator(arg_37_1)

	arg_37_0._callback = arg_37_4
	arg_37_0._callbackObj = arg_37_5

	if not arg_37_4 then
		if var_37_0 then
			arg_37_0._animator.enabled = true

			arg_37_0._animator:Play(arg_37_2, 0, arg_37_3 or 0)
		end
	else
		TaskDispatcher.cancelTask(arg_37_0._animDone, arg_37_0)

		if var_37_0 then
			arg_37_0._animatorPlayer:Play(arg_37_2, arg_37_0._animDone, arg_37_0)
		else
			TaskDispatcher.runDelay(arg_37_0._animDone, arg_37_0, 0.1)
		end
	end
end

function var_0_0.clearAnim(arg_38_0)
	arg_38_0._callback = nil
	arg_38_0._callbackObj = nil

	if arg_38_0._animatorPlayer then
		UnityEngine.Component.DestroyImmediate(arg_38_0._animatorPlayer)

		arg_38_0._animatorPlayer = nil
	end

	if arg_38_0._animator then
		UnityEngine.Component.DestroyImmediate(arg_38_0._animator)

		arg_38_0._animator = nil
	end
end

function var_0_0._animDone(arg_39_0)
	if arg_39_0._callback then
		arg_39_0._callback(arg_39_0._callbackObj)
	end
end

function var_0_0.clearSpine(arg_40_0)
	if arg_40_0.entity and arg_40_0.entity.characterspineeffect then
		arg_40_0.entity.characterspineeffect:clearEffect()
	end

	arg_40_0:_killMoveTween()
	arg_40_0:clearAnim()
	TaskDispatcher.cancelTask(arg_40_0._moveUp, arg_40_0)
	TaskDispatcher.cancelTask(arg_40_0._moveDown, arg_40_0)
	TaskDispatcher.cancelTask(arg_40_0._animDone, arg_40_0)
	var_0_0.super.clearSpine(arg_40_0)

	if arg_40_0._shadowGO then
		gohelper.destroy(arg_40_0._shadowGO)

		arg_40_0._shadowGO = nil
		arg_40_0._shadowGOTrs = nil
	end

	arg_40_0._cameraAnimController = nil
	arg_40_0._specialIdleAnimator = nil
	arg_40_0._specialIdleGO = nil
	arg_40_0._specialIdleGOTrs = nil
	arg_40_0._effectPrefab = nil
	arg_40_0._isLoop = nil
	arg_40_0._mountheadGO = nil
	arg_40_0._mountheadGOTrs = nil
	arg_40_0._shadowPointGOTrs = nil

	arg_40_0:_touchAfter()
end

function var_0_0.beforeDestroy(arg_41_0)
	arg_41_0:removeEventListeners()
	var_0_0.super.beforeDestroy(arg_41_0)
end

return var_0_0
