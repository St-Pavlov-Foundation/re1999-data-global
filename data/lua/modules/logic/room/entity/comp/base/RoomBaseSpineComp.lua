module("modules.logic.room.entity.comp.base.RoomBaseSpineComp", package.seeall)

slot0 = class("RoomBaseSpineComp", LuaCompBase)
slot1 = "_MainColor"
slot2 = 0.5
slot3 = 0.5
slot0.DefaulSpineHeight = 0.01

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
	slot0._spinePrefabRes = nil
	slot0._lookDir = SpineLookDir.Default
	slot0._moveState = RoomCharacterEnum.CharacterMoveState.Idle
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.goTrs = slot1.transform
	slot0._scene = GameSceneMgr.instance:getCurScene()
	slot0._materialRes = RoomCharacterEnum.MaterialPath
	slot0._loader = nil
	slot0._spineGO = nil
	slot0._material = nil
	slot0._meshRenderer = nil
	slot0._skeletonAnim = nil
	slot0._curAnimState = nil
	slot0._isLoop = nil
	slot0._alpha = 1

	slot0:onInit()
end

function slot0.onInit(slot0)
end

function slot0.getLookDir(slot0)
	return slot0._lookDir
end

function slot0.setLookDir(slot0, slot1)
	if slot0._lookDir == slot1 then
		return
	end

	slot0._lookDir = slot1

	slot0:refreshFlip()
end

function slot0.refreshFlip(slot0)
	if slot0._skeletonAnim then
		if slot0._lookDir == SpineLookDir.Right then
			slot0._skeletonAnim:SetScaleX(SpineLookDir.Right)
		else
			slot0._skeletonAnim:SetScaleX(SpineLookDir.Left)
		end
	end
end

function slot0.refreshRotation(slot0)
	if not slot0._spineGO then
		return
	end

	slot2 = Quaternion.New()

	slot2:SetEuler(0, Mathf.Rad2Deg * slot0._scene.camera:getCameraRotate(), 0)

	slot0._spineGOTrs.rotation = slot2
end

function slot0.showSpine(slot0)
	if slot0._spineGO then
		slot1 = slot0:getAlpha()

		slot0:tweenAlpha(slot1, 1, (1 - slot1) * uv0)
	else
		if slot0._loader then
			slot0._loader:dispose()

			slot0._loader = nil
		end

		slot0._loader = SequenceAbLoader.New()

		slot0:addResToLoader(slot0._loader)
		slot0._loader:setConcurrentCount(10)
		slot0._loader:setLoadFailCallback(slot0._onLoadOneFail)
		slot0._loader:startLoad(slot0._onLoadFinish, slot0)
	end
end

function slot0.hideSpine(slot0)
	if slot0._spineGO then
		slot1 = slot0:getAlpha()

		slot0:tweenAlpha(slot1, 0, slot1 * uv0, slot0._hideCallback, slot0)
	else
		slot0:clearSpine()
	end
end

function slot0._hideCallback(slot0)
	slot0:clearSpine()
end

function slot0.isShowAnimShadow(slot0)
	return true
end

function slot0.addResToLoader(slot0, slot1)
	slot1:addPath(slot0._spinePrefabRes)
	slot1:addPath(slot0._materialRes)
end

function slot0._onLoadOneFail(slot0, slot1, slot2)
	logError(string.format("%s:_onLoadOneFail 加载失败, url:%s", slot0.__cname, slot2.ResPath))
end

function slot0._onLoadFinish(slot0, slot1)
	if not slot1:getAssetItem(slot0._spinePrefabRes) then
		logError("can not find :" .. slot0._spinePrefabRes)
	end

	slot0._spineGO = gohelper.clone(slot2:GetResource(slot0._spinePrefabRes), slot0.entity.containerGO, "spine")
	slot0._spineGOTrs = slot0._spineGO.transform

	gohelper.setLayer(slot0._spineGO, LayerMask.NameToLayer("Scene"), true)

	slot0._meshRenderer = slot0._spineGO:GetComponent(typeof(UnityEngine.MeshRenderer))
	slot0._skeletonAnim = slot0._spineGO:GetComponent(typeof(Spine.Unity.SkeletonAnimation))

	gohelper.onceAddComponent(slot0._spineGO, UnitSpine.TypeSpineAnimationEvent)
	TaskDispatcher.cancelTask(slot0._onSpineAnimEvent, slot0)
	TaskDispatcher.runDelay(slot0._onSpineAnimEvent, slot0, 0.02)
	transformhelper.setLocalPos(slot0._spineGOTrs, 0, uv0.DefaulSpineHeight, 0)
	transformhelper.setLocalScale(slot0._spineGOTrs, 0.07, 0.07, 0.07)
	slot0:_replaceMaterial(slot1:getAssetItem(slot0._materialRes):GetResource(slot0._materialRes))
	slot0:refreshFlip()
	slot0:refreshRotation()
	slot0:tweenAlpha(0, 1, uv1)
end

function slot0._replaceMaterial(slot0, slot1)
	slot0._material = UnityEngine.GameObject.Instantiate(slot1)
	slot2 = slot0._meshRenderer.sharedMaterial

	slot0._material:SetTexture("_MainTex", slot2:GetTexture("_MainTex"))
	slot0._material:SetTexture("_BackLight", slot2:GetTexture("_NormalMap"))
	slot0._material:SetTexture("_DissolveTex", slot2:GetTexture("_DissolveTex"))

	if slot0._skeletonAnim.CustomMaterialOverride then
		slot3:Clear()
		slot3:Add(slot2, slot0._material)
	end

	slot0._meshRenderer.material = slot0._material
	slot0._meshRenderer.sortingLayerName = "Default"
end

function slot0._onSpineAnimEvent(slot0)
	if not gohelper.isNil(slot0._spineGO) then
		slot0._csSpineEvt = gohelper.onceAddComponent(slot0._spineGO, UnitSpine.TypeSpineAnimationEvent)
	end

	if slot0._csSpineEvt then
		slot0._csSpineEvt:SetAnimEventCallback(slot0._onAnimCallback, slot0)
	end
end

function slot0._onAnimCallback(slot0, slot1, slot2, slot3)
end

function slot0.getAnimState(slot0)
	if slot0._skeletonAnim then
		return slot0._skeletonAnim.AnimationName
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
	else
		logError(string.format("animName:%s  goName:%s  Animation Name not exist ", slot1, gohelper.isNil(slot0._spineGO) and "nil" or slot0._spineGO.name))
	end
end

function slot0.tweenAlpha(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot0._alphaTweenId then
		slot0._scene.tween:killById(slot0._alphaTweenId)

		slot0._alphaTweenId = nil
	end

	if slot3 and slot3 > 0 then
		slot0:setAlpha(slot1)

		slot0._alphaTweenId = slot0._scene.tween:tweenFloat(0, 1, slot3, slot0._tweenAlphaFrameCallback, slot0._tweenAlphaFinishCallback, slot0, {
			fromAlpha = slot1,
			toAlpha = slot2,
			callback = slot4,
			callbackObj = slot5
		})
	else
		slot0:setAlpha(slot2)
	end
end

function slot0._tweenAlphaFrameCallback(slot0, slot1, slot2)
	slot0:setAlpha(slot2.fromAlpha * (1 - slot1) + slot2.toAlpha * slot1)
end

function slot0._tweenAlphaFinishCallback(slot0, slot1)
	slot0:setAlpha(slot1.toAlpha)

	if slot1.callback then
		slot3(slot1.callbackObj)
	end
end

function slot0.setAlpha(slot0, slot1)
	slot0._alpha = slot1

	slot0:updateAlpha()
end

function slot0.getAlpha(slot0)
	return slot0._alpha
end

function slot0.updateAlpha(slot0)
	if slot0._material then
		slot3 = slot0._material:GetColor(uv0)
		slot3.a = slot0.entity.isPressing and 0 or slot0._alpha

		slot0._material:SetColor(uv0, slot3)
	end

	if slot0:isShowAnimShadow() and slot0._meshRenderer then
		if slot2 > 0.5 then
			slot0._meshRenderer.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.On
		else
			slot0._meshRenderer.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off
		end
	end
end

function slot0.playVoice(slot0, slot1)
	if slot0._spineGO then
		ZProj.AudioEmitter.Get(slot0._spineGO):Emitter(slot1)
	end
end

function slot0.playVoiceWithLang(slot0, slot1, slot2)
	if slot0._spineGO then
		if GameConfig:GetCurVoiceShortcut() == LangSettings.shortcutTab[LangSettings.zh] then
			slot6 = AudioConfig.instance:getAudioCOById(slot1).bankName

			ZProj.AudioManager.Instance:LoadBank(slot6, slot2)
			ZProj.AudioEmitter.Get(slot0._spineGO):Emitter(slot1, slot2)
			ZProj.AudioManager.Instance:UnloadBank(slot6)
		else
			slot3:Emitter(slot1, slot2)
		end
	end
end

function slot0.getSpineGO(slot0)
	return slot0._spineGO
end

function slot0.clearSpine(slot0)
	TaskDispatcher.cancelTask(slot0._onSpineAnimEvent, slot0)

	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end

	if slot0._alphaTweenId then
		slot0._scene.tween:killById(slot0._alphaTweenId)

		slot0._alphaTweenId = nil
	end

	if slot0._csSpineEvt then
		slot0._csSpineEvt:RemoveAnimEventCallback()

		slot0._csSpineEvt = nil
	end

	if slot0._spineGO then
		gohelper.destroy(slot0._spineGO)

		slot0._spineGO = nil
		slot0._spineGOTrs = nil
	end

	if slot0._material then
		gohelper.destroy(slot0._material)

		slot0._material = nil
	end

	slot0._meshRenderer = nil
	slot0._skeletonAnim = nil
	slot0._curAnimState = nil
	slot0._isLoop = nil
end

function slot0.beforeDestroy(slot0)
	slot0:clearSpine()
end

return slot0
