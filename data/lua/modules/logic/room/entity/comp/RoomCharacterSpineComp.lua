module("modules.logic.room.entity.comp.RoomCharacterSpineComp", package.seeall)

slot0 = class("RoomCharacterSpineComp", RoomBaseSpineComp)
slot1 = 0.01

function slot0.onInit(slot0)
	slot1 = slot0.entity:getMO()
	slot0._skinId = slot1.skinId
	slot0._heroId = slot1.heroId
	slot0._roomCharacterCfg = slot1.roomCharacterConfig
	slot0._characterRes = RoomResHelper.getCharacterPath(slot0._skinId)
	slot0._animalRes = RoomResHelper.getAnimalPath(slot0._skinId)
	slot0._cameraAnimABRes = RoomResHelper.getCharacterCameraAnimABPath(slot1.roomCharacterConfig.cameraAnimPath)
	slot0._cameraAnimRes = RoomResHelper.getCharacterCameraAnimPath(slot1.roomCharacterConfig.cameraAnimPath)
	slot0._effectABRes = RoomResHelper.getCharacterEffectABPath(slot1.roomCharacterConfig.effectPath)
	slot0._effectRes = RoomResHelper.getCharacterEffectPath(slot1.roomCharacterConfig.effectPath)
	slot0._isShow = false
	slot0._isHide = false
	slot0._shouldShowCharacter = false
	slot0._isInDistance = false
	slot0._alpha = 1
	slot0._zeroMix = slot1.roomCharacterConfig.zeroMix
	slot0._spinePrefabRes = slot0._characterRes

	if slot1.isAnimal then
		slot0._spinePrefabRes = slot0._animalRes
	end

	slot0:refreshAnimal()
	slot0:_cameraTransformUpdate()
	slot0:_refreshSpineShow()
end

function slot0.refreshAnimal(slot0)
	if not slot0.entity:getMO() then
		return
	end

	slot2 = slot1.isAnimal or false
	slot0._isAnimal = slot2

	if slot0._isAnimal ~= slot2 then
		slot0._spinePrefabRes = slot2 and slot0._animalRes or slot0._characterRes

		slot0:clearSpine()
		slot0:_refreshShowCharacter(true)
	end
end

function slot0.addEventListeners(slot0)
	RoomMapController.instance:registerCallback(RoomEvent.CameraTransformUpdate, slot0._cameraTransformUpdate, slot0)
	RoomCharacterController.instance:registerCallback(RoomEvent.RefreshSpineShow, slot0._refreshSpineShow, slot0)
	RoomMapController.instance:registerCallback(RoomEvent.CameraTransformUpdate, slot0._updateShadowOffset, slot0)
	RoomCharacterController.instance:registerCallback(RoomEvent.UpdateCharacterMove, slot0._onUpdate, slot0)
end

function slot0.removeEventListeners(slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.CameraTransformUpdate, slot0._cameraTransformUpdate, slot0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.RefreshSpineShow, slot0._refreshSpineShow, slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.CameraTransformUpdate, slot0._updateShadowOffset, slot0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.UpdateCharacterMove, slot0._onUpdate, slot0)
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

	slot0:_refreshShowCharacter()

	if slot0._spineGO and slot0._spineGO.activeInHierarchy then
		slot0:refreshRotation()
	end

	slot0:refreshEffectPos()
end

function slot0._onUpdate(slot0)
	if slot0._shadowPointGOTrs and slot0._shadowGOTrs then
		slot1, slot2, slot3 = transformhelper.getPos(slot0._shadowPointGOTrs)

		transformhelper.setPos(slot0._shadowGOTrs, slot1, slot2, slot3)
	end
end

function slot0.refreshEffectPos(slot0)
	if not slot0._specialIdleGO then
		return
	end

	slot0._specialIdleGOTrs.localPosition = Vector3(0, RoomBendingHelper.worldToBendingSimple(slot0._specialIdleGOTrs.position).y, 0)
end

function slot0._refreshSpineShow(slot0)
	slot0._shouldShowCharacter = RoomCharacterController.instance:checkCanSpineShow(slot0._scene.camera:getCameraState())

	slot0:_refreshShowCharacter()
end

function slot0.changeMoveState(slot0, slot1)
	if slot0._moveState == slot1 then
		return
	end

	slot0._moveState = slot1

	slot0:refreshAnimState()
end

function slot0.touch(slot0, slot1)
	slot2 = slot0.entity:getMO()

	TaskDispatcher.cancelTask(slot0._touchAfter, slot0)

	if slot1 then
		slot0._touchAction = true

		TaskDispatcher.runDelay(slot0._touchAfter, slot0, 13)

		if slot0:isRandomSpecialRate() then
			slot0:tryPlaySpecialIdle()
		else
			slot0:play(RoomCharacterEnum.CharacterAnimStateName.Touch, false, true)
		end

		if not string.nilorempty(slot2.roomCharacterConfig.roleVoice) and #string.splitToNumber(slot3, "|") > 0 then
			slot6 = nil

			if slot0._heroId then
				slot7, slot8, slot9 = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(slot0._heroId)

				if not string.nilorempty(LangSettings.shortcutTab[slot7]) and not slot9 then
					slot6 = slot10
				end
			end

			if slot6 then
				slot0:playVoiceWithLang(slot4[math.random(1, slot5)], slot6)
			else
				slot0:playVoice(slot4[slot7])
			end
		end
	else
		slot0:refreshAnimState()
	end
end

function slot0.isRandomSpecialRate(slot0)
	if not slot0.entity:getMO():isHasSpecialIdle() then
		return false
	end

	if slot1:getSpecialRate() <= math.random() then
		return false
	end

	if slot1:getSpecialIdleWaterDistance() > 0 and RoomCharacterHelper.hasWaterNodeNear(slot0.goTrs.position, slot3) then
		return false
	end

	return true
end

function slot0.refreshAnimState(slot0)
	if not slot0.entity:getMO() then
		return
	end

	if slot0._isAnimal then
		slot0:play(RoomCharacterEnum.CharacterAnimalAnimStateName.Jump, false, true)
	elseif slot1.isTouch then
		if slot0._touchAction then
			slot0:play(RoomCharacterEnum.CharacterAnimStateName.Touch, false, false)
		else
			slot0:play(RoomCharacterHelper.getIdleAnimStateName(slot1.heroId), true, false)
		end
	else
		slot3 = RoomCharacterModel.instance:getTempCharacterMO()

		if slot0:getAnimState() ~= RoomCharacterEnum.CharacterAnimStateName.SpecialIdle or RoomCharacterHelper.getAnimStateName(slot0._moveState, slot1.heroId) ~= RoomCharacterHelper.getIdleAnimStateName(slot1.heroId) or slot3 and slot3.id == slot0.entity.id then
			slot4 = RoomCharacterEnum.CharacterLoopAnimState[slot0._moveState] or false

			slot0:play(RoomCharacterHelper.getAnimStateName(slot0._moveState, slot1.heroId), slot4, not slot4 and slot0._isAnimalActionComplete and true or false)
		end
	end
end

function slot0.changeLookDir(slot0, slot1)
	slot0:setLookDir(slot1)
end

function slot0._refreshShowCharacter(slot0, slot1)
	if slot0._isInDistance and slot0._shouldShowCharacter then
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

function slot0.addResToLoader(slot0, slot1)
	uv0.super.addResToLoader(slot0, slot1)

	if not string.nilorempty(slot0._cameraAnimABRes) then
		slot1:addPath(slot0._cameraAnimABRes)
	end

	if not string.nilorempty(slot0._effectABRes) then
		slot1:addPath(slot0._effectABRes)
	end

	slot0.entity.characterspineeffect:addResToLoader(slot1)
end

function slot0._onLoadFinish(slot0, slot1)
	uv0.super._onLoadFinish(slot0, slot1)

	if not string.nilorempty(slot0._cameraAnimABRes) then
		slot0._cameraAnimController = slot1:getAssetItem(slot0._cameraAnimABRes):GetResource(slot0._cameraAnimRes)
	end

	if not string.nilorempty(slot0._effectABRes) then
		slot0._effectPrefab = slot1:getAssetItem(slot0._effectABRes):GetResource(slot0._effectRes)
	end

	slot0._mountheadGO = gohelper.findChild(slot0._spineGO, "mountroot/mounthead")

	if slot0._mountheadGO then
		slot0._mountheadGOTrs = slot0._mountheadGO.transform
	end

	slot0._shadowPointGOTrs = nil

	if not string.nilorempty(slot0._roomCharacterCfg.shadow) and gohelper.findChild(slot0._spineGO, "mountroot/" .. slot0._roomCharacterCfg.shadow) then
		slot0._shadowPointGOTrs = slot2.transform
	end

	slot0:_spawnShadowGO(slot1)
	slot0:_updateShadowOffset()
	slot0.entity.characterspineeffect:spawnEffect(slot1)
	slot0:refreshAnimState()
	slot0:_cameraTransformUpdate()
end

function slot0._spawnShadowGO(slot0, slot1)
	if slot0.entity:getMO():getCanWade() then
		return
	end

	slot0._shadowGO = gohelper.clone(slot0._scene.preloader:getResource(RoomScenePreloader.ResEffectCharacterShadow), slot0.entity.containerGO, "shadow")
	slot0._shadowGOTrs = slot0._shadowGO.transform
	slot0._shadowGO:GetComponent(typeof(UnityEngine.MeshRenderer)).sortingLayerName = "Default"

	transformhelper.setLocalPos(slot0._shadowGOTrs, 0, uv0, 0)
end

function slot0._updateShadowOffset(slot0)
	if not slot0._material then
		return
	end

	slot0._material:SetVector("_ShadowOffset", slot0._scene.character:getShadowOffset())
end

function slot0._onLoadOneFail(slot0, slot1, slot2)
	logError("RoomCharacterSpineComp: 加载失败, url: " .. slot2.ResPath)
end

function slot0.play(slot0, slot1, slot2, slot3)
	if not slot1 then
		return
	end

	if not slot0._skeletonAnim then
		return
	end

	slot0._playAnimal = slot0._playAnimal or false

	if not (slot3 or false or slot1 ~= slot0._curAnimState or (slot2 or false) ~= slot0._isLoop or slot0._playAnimal ~= slot0._isAnimal) then
		return
	end

	if slot1 ~= RoomCharacterEnum.CharacterAnimStateName.SpecialIdle then
		slot0:_stopPlaySpecialIdle()
	end

	slot0._curAnimState = slot1
	slot0._isLoop = slot2
	slot0._playAnimal = slot0._isAnimal

	if slot0._skeletonAnim:HasAnimation(slot1) then
		if slot0._zeroMix and (slot1 ~= slot0._curAnimState or slot3) then
			slot0._skeletonAnim:SetAnimation(0, slot1, slot0._isLoop, 0)

			slot0._skeletonAnim.loop = slot0._isLoop
		else
			slot0._skeletonAnim:PlayAnim(slot1, slot0._isLoop, slot3)
		end

		slot0:_moveCharacterUp(slot1)
		slot0:_updateAnimShadow(slot1)
		slot0.entity.characterspineeffect:play(slot1)
	else
		logError(string.format("heroId:%s  skinId:%s  animName:%s  goName:%s  Animation Name not exist ", slot0._heroId, slot0._skinId, slot1, gohelper.isNil(slot0._spineGO) and "nil" or slot0._spineGO.name))
	end
end

function slot0._moveCharacterUp(slot0, slot1)
	TaskDispatcher.cancelTask(slot0._moveUp, slot0)
	TaskDispatcher.cancelTask(slot0._moveDown, slot0)

	if not slot0.entity:getMO() then
		return
	end

	slot0._moveConfig = RoomConfig.instance:getCharacterAnimConfig(slot2.skinId, slot1)

	if not slot0._moveConfig then
		slot0:_killMoveTween()

		if slot0._spineGO then
			slot0._spineMoveTweenId = ZProj.TweenHelper.DOLocalMoveY(slot0._spineGOTrs, uv0, 0.05)
		end

		if slot0._shadowGO then
			slot0._shadowMoveTweenId = ZProj.TweenHelper.DOLocalMoveY(slot0._shadowGOTrs, uv0, 0.05)
		end

		return
	end

	if slot0._moveConfig.upTime > 0 then
		TaskDispatcher.runDelay(slot0._moveUp, slot0, slot0._moveConfig.upTime / 1000)
	else
		slot0:_moveUp()
	end

	if slot0._moveConfig.downTime > 0 then
		TaskDispatcher.runDelay(slot0._moveDown, slot0, slot0._moveConfig.downTime / 1000)
	end
end

function slot0._moveUp(slot0)
	if not slot0._moveConfig then
		return
	end

	slot0:_killMoveTween()

	slot0._spineMoveTweenId = ZProj.TweenHelper.DOLocalMoveY(slot0._spineGOTrs, slot0._moveConfig.upDistance / 1000, slot0._moveConfig.upDuration / 1000)
	slot0._shadowMoveTweenId = ZProj.TweenHelper.DOLocalMoveY(slot0._shadowGOTrs, slot0._moveConfig.upDistance / 1000, slot0._moveConfig.upDuration / 1000)
end

function slot0._moveDown(slot0)
	if not slot0._moveConfig then
		return
	end

	slot0:_killMoveTween()

	slot0._spineMoveTweenId = ZProj.TweenHelper.DOLocalMoveY(slot0._spineGOTrs, uv0, slot0._moveConfig.downDuration / 1000)
	slot0._shadowMoveTweenId = ZProj.TweenHelper.DOLocalMoveY(slot0._shadowGOTrs, uv0, slot0._moveConfig.downDuration / 1000)
end

function slot0._killMoveTween(slot0)
	if slot0._spineMoveTweenId then
		ZProj.TweenHelper.KillById(slot0._spineMoveTweenId)
	end

	if slot0._shadowMoveTweenId then
		ZProj.TweenHelper.KillById(slot0._shadowMoveTweenId)
	end
end

function slot0._onAnimCallback(slot0, slot1, slot2, slot3)
	slot5 = slot0.entity:getMO()
	slot0._isAnimalActionComplete = slot2 == SpineAnimEvent.ActionComplete

	if slot0._isAnimal and slot1 == RoomCharacterEnum.CharacterAnimalAnimStateName.Jump and slot2 == SpineAnimEvent.ActionComplete then
		GameSceneMgr.instance:getCurScene().character:setCharacterAnimal(slot0.entity.id, false)
	elseif not slot0._isAnimal and slot0._touchAction and slot2 == SpineAnimEvent.ActionComplete then
		slot0._touchAction = false

		if slot1 == RoomCharacterEnum.CharacterAnimStateName.SpecialIdle then
			slot0:_stopPlaySpecialIdle()
		end

		slot0:refreshAnimState()
		TaskDispatcher.cancelTask(slot0._touchAfter, slot0)
		TaskDispatcher.runDelay(slot0._touchAfter, slot0, RoomCharacterEnum.WaitingTimeAfterTouch)
	elseif not slot0._isAnimal and slot1 == RoomCharacterEnum.CharacterAnimStateName.SpecialIdle and slot2 == SpineAnimEvent.ActionComplete then
		slot0:_stopPlaySpecialIdle()
		slot0:play(RoomCharacterHelper.getAnimStateName(slot0._moveState, slot5.heroId), RoomCharacterEnum.CharacterLoopAnimState[slot0._moveState] or false, false)
	elseif not slot0._isAnimal and slot0._curAnimState == slot1 and slot0._isLoop ~= true and slot2 == SpineAnimEvent.ActionComplete then
		if RoomCharacterHelper.getNextAnimStateName(slot0._moveState, slot1) then
			slot0:play(slot6, slot6 == slot1, false)
		else
			slot0:play(RoomCharacterHelper.getIdleAnimStateName(slot5.heroId), true, false)
		end
	end
end

function slot0._stopPlaySpecialIdle(slot0)
	if slot0._specialIdleAnimator then
		slot0._specialIdleAnimator.enabled = false
	end

	if slot0._specialIdleGO then
		gohelper.setActive(slot0._specialIdleGO, false)
	end

	if slot0._spineGO then
		ZProj.CharacterSetVariantHelper.Disable(slot0._spineGO)
	end

	if slot0._meshRenderer and slot0._material then
		slot0._meshRenderer.material = slot0._material
	end
end

function slot0.tryPlaySpecialIdle(slot0)
	if not slot0._spineGO then
		return
	end

	if slot0.entity:getMO():isHasSpecialIdle() and slot0._curAnimState ~= RoomCharacterEnum.CharacterAnimStateName.SpecialIdle then
		slot0:play(RoomCharacterEnum.CharacterAnimStateName.SpecialIdle, false, false)

		if slot0._cameraAnimController then
			if not slot0._specialIdleAnimator then
				slot0._specialIdleAnimator = gohelper.onceAddComponent(slot0._spineGO, typeof(UnityEngine.Animator))
				slot0._specialIdleAnimator.runtimeAnimatorController = slot0._cameraAnimController
			else
				slot0._specialIdleAnimator.runtimeAnimatorController = nil
				slot0._specialIdleAnimator.enabled = false
				slot0._specialIdleAnimator.enabled = true
				slot0._specialIdleAnimator.runtimeAnimatorController = slot0._cameraAnimController
			end
		end

		if slot0._effectPrefab then
			if not slot0._specialIdleGO then
				slot0._specialIdleGO = gohelper.clone(slot0._effectPrefab, gohelper.findChild(slot0._spineGO, "mountroot/mountbottom") or slot0._spineGO, "special_idle_effect")
				slot0._specialIdleGOTrs = slot0._specialIdleGO.transform
			else
				gohelper.setActive(slot0._specialIdleGO, false)
				gohelper.setActive(slot0._specialIdleGO, true)
			end

			gohelper.setActive(gohelper.findChild(slot0._specialIdleGO, slot0._effectPrefab.name .. "_r"), slot0._lookDir == SpineLookDir.Left)
			gohelper.setActive(gohelper.findChild(slot0._specialIdleGO, slot0._effectPrefab.name .. "_l"), slot0._lookDir == SpineLookDir.Right)
		end
	end
end

function slot0._updateAnimShadow(slot0, slot1)
	if slot0._isLastAminShadow ~= slot0:_isShowAnimShadow(slot1) then
		slot0._isLastAminShadow = slot2

		if slot2 then
			slot0._meshRenderer.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.On
		else
			slot0._meshRenderer.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off
		end
	end
end

function slot0._isShowAnimShadow(slot0, slot1)
	if RoomConfig.instance:getCharacterShadowConfig(slot0._skinId, slot1 or slot0._curAnimState) and slot2.shadow == 1 then
		return false
	end

	return true
end

function slot0._touchAfter(slot0)
	TaskDispatcher.cancelTask(slot0._touchAfter, slot0)
	GameSceneMgr.instance:getCurScene().character:setCharacterTouch(slot0.entity.id, false)
end

function slot0.getCharacterGO(slot0)
	return slot0:getSpineGO()
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

function slot0._checkAnimator(slot0, slot1)
	if slot0._scene.preloader:getResource(slot1) then
		slot0._animator = gohelper.onceAddComponent(slot0.entity.containerGO, typeof(UnityEngine.Animator))
		slot0._animatorPlayer = gohelper.onceAddComponent(slot0.entity.containerGO, typeof(SLFramework.AnimatorPlayer))
		slot0._animator.runtimeAnimatorController = slot2

		return true
	end

	return false
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

function slot0.clearSpine(slot0)
	if slot0.entity and slot0.entity.characterspineeffect then
		slot0.entity.characterspineeffect:clearEffect()
	end

	slot0:_killMoveTween()
	slot0:clearAnim()
	TaskDispatcher.cancelTask(slot0._moveUp, slot0)
	TaskDispatcher.cancelTask(slot0._moveDown, slot0)
	TaskDispatcher.cancelTask(slot0._animDone, slot0)
	uv0.super.clearSpine(slot0)

	if slot0._shadowGO then
		gohelper.destroy(slot0._shadowGO)

		slot0._shadowGO = nil
		slot0._shadowGOTrs = nil
	end

	slot0._cameraAnimController = nil
	slot0._specialIdleAnimator = nil
	slot0._specialIdleGO = nil
	slot0._specialIdleGOTrs = nil
	slot0._effectPrefab = nil
	slot0._isLoop = nil
	slot0._mountheadGO = nil
	slot0._mountheadGOTrs = nil
	slot0._shadowPointGOTrs = nil

	slot0:_touchAfter()
end

function slot0.beforeDestroy(slot0)
	slot0:removeEventListeners()
	uv0.super.beforeDestroy(slot0)
end

return slot0
