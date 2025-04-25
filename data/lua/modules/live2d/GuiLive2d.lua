module("modules.live2d.GuiLive2d", package.seeall)

slot0 = class("GuiLive2d", BaseLive2d)
slot1 = "live2d/custom/live2d_camera.prefab"
slot2 = "live2d/custom/uiimage.mat"
slot3 = UnityEngine.SystemInfo
slot4 = typeof(ZProj.Live2dUseInvisible)
slot0.DefaultLive2dCameraSize = 6.5

function slot0.Create(slot0, slot1)
	slot2 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0, uv0)
	slot2._isStory = slot1
	slot2._scale = 88

	return slot2
end

slot5 = 1.34
slot6 = 400

function slot0.ctor(slot0)
	slot2 = UnityEngine.Screen.dpi
	slot0._qualityScale = 1

	if (GameGlobalMgr.instance:getScreenState():getLocalQuality() or ModuleEnum.Performance.High) ~= ModuleEnum.Performance.Low and slot2 > 1 and slot2 < uv0 then
		slot0._qualityScale = uv0 / slot2
		slot0._qualityScale = Mathf.Clamp(slot0._qualityScale, 1, 1.5)
	end

	slot0._adapterScaleOnCreate = math.min(GameUtil.getAdapterScale(), uv1)
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
end

function slot0._onScreenResize(slot0)
	if slot0._rawImageGo then
		slot0:setSpineScale(slot0._rawImageGo)
	end
end

function slot0.hideModel(slot0)
	slot0:_setCameraVisible(false)
	gohelper.setActive(slot0._spineGo, false)
end

function slot0.showModel(slot0)
	slot0:_setCameraVisible(true)
	gohelper.setActive(slot0._spineGo, true)

	if gohelper.isNil(slot0:getSpineGo()) == false then
		slot0:play(slot0:getCurBody(), true)
	end

	if not slot0._uiEffectGos then
		slot0:_addDelayProcessEffect()
	end
end

function slot0._addDelayProcessEffect(slot0)
	slot0._repeatCount = 0
	slot0._repeatNum = 5

	TaskDispatcher.cancelTask(slot0._delayProcessEffect, slot0)
	TaskDispatcher.runRepeat(slot0._delayProcessEffect, slot0, 0, slot0._repeatNum)
end

function slot0._delayProcessEffect(slot0)
	slot0._repeatCount = slot0._repeatCount + 1

	if slot0._repeatCount < slot0._repeatNum then
		return
	end

	slot0:_doProcessEffect()
end

function slot0.cancelCamera(slot0)
	slot0._cancelCamera = true
end

function slot0.isCancelCamera(slot0)
	return slot0._cancelCamera
end

function slot0._setCameraVisible(slot0, slot1)
	slot0._cameraVisible = slot1

	if slot0._cameraGo then
		gohelper.setActive(slot0._cameraGo, slot1)
	end

	if slot0._rawImageGo then
		gohelper.setActive(slot0._rawImageGo, slot1)
	end
end

function slot0.setLocalScale(slot0, slot1)
	slot0._scale = slot1

	if slot0._spineTr then
		transformhelper.setLocalScale(slot0._spineTr, slot0._scale, slot0._scale, 1)
	end
end

function slot0.setCameraSize(slot0, slot1)
	slot0._cameraSize = slot1
end

function slot0.setCameraLayer(slot0, slot1)
	slot0._cameraLayer = slot1

	if slot0._camera and slot0._cameraLayer then
		slot0._camera.cullingMask = bit.lshift(1, slot0._cameraLayer)
	end
end

function slot0._onResLoaded(slot0)
	uv0.super._onResLoaded(slot0)
	transformhelper.setLocalScale(slot0._spineTr, slot0._scale, slot0._scale, 1)
	slot0:_initSkinUiEffect()

	if not slot0._cancelCamera then
		slot0:_initCamera()
	end
end

function slot0._initSkinUiEffect(slot0)
	slot0._tempVec2 = slot0._tempVec2 or Vector2.New()
	slot0._uiEffectGos = nil
	slot0._uiEffectGosClone = nil
	slot0._uiEffectList = nil
	slot0._uiEffectConfig = nil
	slot0._uiEffectInitVisible = nil
	slot0._uiEffectRealtime = nil
	slot0._hasProcessModelEffect = nil

	for slot4, slot5 in ipairs(lua_skin_ui_effect.configList) do
		if not slot0:_skip(slot5.id) and string.find(slot0._resPath, slot5.id) then
			slot0._uiEffectConfig = slot5
			slot0._uiEffectList = string.split(slot5.effect, "|")
			slot0._uiEffectRealtime = string.splitToNumber(slot5.realtime, "|")
			slot0._uiEffectInitVisible = {}

			break
		end
	end
end

function slot0._skip(slot0, slot1)
	return slot1 == 304802
end

function slot0.hideModelEffect(slot0)
	if not slot0._uiEffectGos then
		return
	end

	for slot4, slot5 in ipairs(slot0._uiEffectGos) do
		if slot0._uiEffectInitVisible[slot4] then
			gohelper.setActive(slot5, false)
		end
	end
end

function slot0.showModelEffect(slot0)
	if not slot0._uiEffectGos then
		return
	end

	for slot4, slot5 in ipairs(slot0._uiEffectGos) do
		if slot0._uiEffectInitVisible[slot4] then
			gohelper.setActive(slot5, true)
		end
	end
end

function slot0.processModelEffect(slot0)
	slot0._hasProcessModelEffect = true

	slot0:_doProcessEffect()
end

function slot0._processEffect(slot0)
	if slot0._uiEffectList then
		for slot4, slot5 in ipairs(slot0._uiEffectList) do
			if gohelper.findChild(slot0._spineGo, slot5) then
				slot0._uiEffectInitVisible[slot4] = slot6.gameObject.activeSelf

				gohelper.setActive(slot6.gameObject, false)
			end
		end
	end

	slot0:_addDelayProcessEffect()
end

function slot0._doProcessEffect(slot0)
	if gohelper.isNil(slot0._spineGo) then
		return
	end

	if not slot0._spineGo.activeInHierarchy then
		return
	end

	if slot0._uiEffectGos or not slot0._camera then
		return
	end

	slot0._hasProcessModelEffect = false
	slot0._uiEffectGos = slot0:getUserDataTb_()
	slot0._uiEffectGosClone = slot0:getUserDataTb_()

	if slot0._uiEffectList then
		for slot4, slot5 in ipairs(slot0._uiEffectList) do
			slot6, slot0._uiEffectGosClone[slot4] = slot0:_initSkinUiEffectGo(slot5, slot0._uiEffectInitVisible[slot4], slot4)

			if slot6 then
				table.insert(slot0._uiEffectGos, slot6)
			end
		end
	end
end

function slot0._onBodyEffectShow(slot0, slot1)
	if slot0._hasProcessModelEffect then
		slot0:_doProcessEffect()
	end

	TaskDispatcher.cancelTask(slot0._realtimeAdjustPos, slot0)

	if slot1 and slot0._uiEffectGosClone and next(slot0._uiEffectGosClone) then
		TaskDispatcher.runRepeat(slot0._realtimeAdjustPos, slot0, 0.1)
	end
end

function slot0._realtimeAdjustPos(slot0)
	slot1 = false

	if slot0._uiEffectGos then
		for slot5, slot6 in ipairs(slot0._uiEffectGos) do
			if slot0._uiEffectGosClone[slot5] and slot6.activeSelf then
				slot1 = true

				slot0:_adjustPos(slot7, slot6)
			end
		end
	end

	if not slot1 then
		TaskDispatcher.cancelTask(slot0._realtimeAdjustPos, slot0)
	end
end

function slot0._initSkinUiEffectGo(slot0, slot1, slot2, slot3)
	if gohelper.isNil(gohelper.findChild(slot0._spineGo, slot1)) then
		if SLFramework.FrameworkSettings.IsEditor then
			if string.find(slot1, "#") then
				logError(string.format("%s 分隔符使用错误，#要改为|", slot1))

				return
			end

			logError(string.format("找不到特效节点：%s,请检查路径", slot1))

			return
		end

		return
	end

	if slot2 then
		gohelper.setActive(slot4.gameObject, true)
	end

	for slot10 = 0, slot4.gameObject:GetComponentsInChildren(typeof(UnityEngine.UI.MaskableGraphic), true).Length - 1 do
		slot11 = slot6[slot10]
		slot11.enabled = true

		gohelper.setLayer(slot11.gameObject, LayerMask.NameToLayer("UI"))
	end

	if slot0._uiEffectRealtime and slot0._uiEffectRealtime[slot3] == 1 then
		slot8 = slot4.transform
		slot9 = gohelper.create3d(slot8.parent.gameObject, slot4.name .. "_Clone")
		slot9.transform.localPosition = slot8.localPosition

		gohelper.setActive(slot9, false)

		slot10 = slot0:_getEffectScale()

		transformhelper.setLocalScale(slot4.transform, slot10, slot10, slot10)

		return slot4, slot9
	end

	slot0:_adjustPos(slot4, slot4)

	slot8 = slot0:_getEffectScale()

	transformhelper.setLocalScale(slot4.transform, slot8, slot8, slot8)

	return slot4
end

function slot0._getEffectScale(slot0)
	if slot0._uiEffectConfig.scale <= 0 then
		if SLFramework.FrameworkSettings.IsEditor then
			logError(string.format("id:%d特效scale值错误：%s,不能配小于0的值，正常值是1以上。", slot0._uiEffectConfig.id, slot1))
		end

		slot1 = 1
	end

	return slot1
end

function slot0._adjustPos(slot0, slot1, slot2)
	slot3 = slot0._camera:WorldToViewportPoint(slot1.transform.position)
	slot0._tempVec2.x = slot3.x
	slot0._tempVec2.y = slot3.y
	slot5 = slot0._rawImageGo.transform
	slot7 = slot5.position + slot5:TransformVector((slot0._tempVec2 - slot5.pivot):Scale(slot5.rect.size))

	transformhelper.setPosXY(slot2.transform, slot7.x, slot7.y)
end

function slot0.setCameraLoadedCallback(slot0, slot1, slot2)
	slot0.cameraCallback = slot1
	slot0.cameraCallbackObj = slot2
end

function slot0._initCamera(slot0)
	if slot0._guiL2dLoader then
		if slot0._cameraGo then
			slot0:_onCameraLoaded()
		end

		return
	end

	slot2 = UnityEngine.GameObject.New("live2d_camera_root").transform
	slot2.parent = slot0._gameTr.parent

	transformhelper.setLocalScale(slot2, 1, 1, 1)
	transformhelper.setLocalPos(slot2, 0, 0, 0)

	slot0._guiL2dLoader = MultiAbLoader.New()

	slot0._guiL2dLoader:addPath(uv0)
	slot0._guiL2dLoader:addPath(uv1)
	slot0._guiL2dLoader:startLoad(slot0._loadL2dResFinish, slot0)
end

function slot0.openBloomView(slot0, slot1)
	slot0._openBloomView = slot1
end

function slot0.getTextureSizeByCameraSize(slot0)
	return math.floor(slot0 / uv0.DefaultLive2dCameraSize * 1600)
end

function slot0._getRT(slot0, slot1)
	if slot0._openBloomView and slot0._skinId and lua_skin_ui_bloom.configDict[slot0._skinId] and slot2[slot0._openBloomView] == 1 then
		return UnityEngine.RenderTexture.GetTemporary(slot1, slot1, 0, UnityEngine.RenderTextureFormat.ARGBHalf)
	end

	return UnityEngine.RenderTexture.GetTemporary(slot1, slot1, 0, UnityEngine.RenderTextureFormat.ARGB32)
end

function slot0._loadL2dResFinish(slot0)
	slot0._cameraGo = gohelper.clone(slot0._guiL2dLoader:getAssetItem(uv0):GetResource(), slot0._gameTr.parent.gameObject)
	slot0._camera = slot0._cameraGo:GetComponent(typeof(UnityEngine.Camera))

	if slot0._cameraLayer then
		slot0:setCameraLayer(slot0._cameraLayer)
	end

	if slot0._cameraSize > 0 then
		slot2.orthographicSize = slot0._cameraSize
	end

	if uv2.maxTextureSize < uv1.getTextureSizeByCameraSize(slot2.orthographicSize) * slot0._adapterScaleOnCreate * slot0._qualityScale then
		slot4 = slot5
	end

	slot0._rt = slot0._rt or slot0:_getRT(slot4)
	slot2.targetTexture = slot0._rt
	slot0._rawImageGo = UnityEngine.GameObject.New("live2d_rawImage")
	slot0._rawImageTransform = slot0._rawImageGo.transform
	slot0._rawImageTransform.parent = slot0._gameTr.parent

	slot0:setSpineScale(slot0._rawImageGo)
	transformhelper.setLocalPos(slot0._rawImageTransform, 0, 1000, 0)

	slot6 = gohelper.onceAddComponent(slot0._rawImageGo, gohelper.Type_RawImage)
	slot6.texture = slot0._rt
	slot6.raycastTarget = false

	slot6:SetNativeSize()

	slot0._mat = UnityEngine.Object.Instantiate(slot0._guiL2dLoader:getAssetItem(uv3):GetResource())

	if slot0._uiMaskBuffer ~= nil then
		slot0:setImageUIMask(slot0._uiMaskBuffer)
	end

	slot6.material = slot0._mat

	slot0:_setMaterialToInvisible(slot0._mat)
	slot0:_onCameraLoaded()
end

function slot0._isAfterLive2d(slot0)
	return slot0._uiEffectConfig and slot0._uiEffectConfig.id == 307502
end

function slot0._setMaterialToInvisible(slot0, slot1)
	if gohelper.isNil(slot0._spineGo) then
		return
	end

	if not slot0._spineGo:GetComponent(uv0) then
		return
	end

	slot2:SetRawImageMaterial(slot1)

	slot2.isInUI = true
end

function slot0.setSpineScale(slot0, slot1)
	slot2 = GameUtil.getAdapterScale() / (slot0._adapterScaleOnCreate or 1) / (slot0._qualityScale or 1)

	transformhelper.setLocalScale(slot1.transform, slot2, slot2, slot2)
end

function slot0._onCameraLoaded(slot0)
	if slot0:_isAfterLive2d() then
		gohelper.setSiblingAfter(slot0._rawImageGo, slot0._gameObj)
	else
		gohelper.setAsFirstSibling(slot0._rawImageGo)
	end

	if slot0._cameraVisible == nil then
		slot0._cameraVisible = true
	end

	slot0:_setCameraVisible(slot0._cameraVisible)
	slot0:_processEffect()

	if slot0.cameraCallback then
		slot0.cameraCallback(slot0.cameraCallbackObj, slot0)
	end
end

function slot0.setImageUIMask(slot0, slot1)
	if slot0._mat then
		if slot1 == true then
			slot0._mat:EnableKeyword("_UIMASK_ON")
		else
			slot0._mat:DisableKeyword("_UIMASK_ON")
		end
	else
		slot0._uiMaskBuffer = slot1
	end
end

function slot0.onDestroy(slot0)
	uv0.super.onDestroy(slot0)

	if slot0._guiL2dLoader then
		slot0._guiL2dLoader:dispose()

		slot0._guiL2dLoader = nil
	end

	slot0._mat = nil

	if slot0._rt then
		UnityEngine.RenderTexture.ReleaseTemporary(slot0._rt)

		slot0._rt = nil
	end

	TaskDispatcher.cancelTask(slot0._delayProcessEffect, slot0)
	TaskDispatcher.cancelTask(slot0._realtimeAdjustPos, slot0)

	slot0._uiEffectGos = nil
	slot0._uiEffectGosClone = nil
	slot0._rawImageGo = nil
	slot0._cameraGo = nil
end

return slot0
