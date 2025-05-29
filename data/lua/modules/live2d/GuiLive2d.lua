module("modules.live2d.GuiLive2d", package.seeall)

local var_0_0 = class("GuiLive2d", BaseLive2d)
local var_0_1 = "live2d/custom/live2d_camera.prefab"
local var_0_2 = "live2d/custom/uiimage.mat"
local var_0_3 = UnityEngine.SystemInfo
local var_0_4 = typeof(ZProj.Live2dUseInvisible)

var_0_0.DefaultLive2dCameraSize = 6.5

function var_0_0.Create(arg_1_0, arg_1_1)
	local var_1_0 = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0, var_0_0)

	var_1_0._isStory = arg_1_1
	var_1_0._scale = 88

	return var_1_0
end

local var_0_5 = 1.34
local var_0_6 = 400

function var_0_0.ctor(arg_2_0)
	local var_2_0 = GameGlobalMgr.instance:getScreenState():getLocalQuality() or ModuleEnum.Performance.High
	local var_2_1 = UnityEngine.Screen.dpi

	arg_2_0._qualityScale = 1

	if var_2_0 ~= ModuleEnum.Performance.Low and var_2_1 > 1 and var_2_1 < var_0_6 then
		arg_2_0._qualityScale = var_0_6 / var_2_1
		arg_2_0._qualityScale = Mathf.Clamp(arg_2_0._qualityScale, 1, 1.5)
	end

	arg_2_0._adapterScaleOnCreate = math.min(GameUtil.getAdapterScale(), var_0_5)
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_3_0._onScreenResize, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_4_0._onScreenResize, arg_4_0)
end

function var_0_0._onScreenResize(arg_5_0)
	if arg_5_0._rawImageGo then
		arg_5_0:setSpineScale(arg_5_0._rawImageGo)
	end
end

function var_0_0.hideModel(arg_6_0)
	arg_6_0:_setCameraVisible(false)
	gohelper.setActive(arg_6_0._spineGo, false)
end

function var_0_0.showModel(arg_7_0)
	arg_7_0:_setCameraVisible(true)
	gohelper.setActive(arg_7_0._spineGo, true)

	if gohelper.isNil(arg_7_0:getSpineGo()) == false then
		arg_7_0:play(arg_7_0:getCurBody(), true)
	end

	if not arg_7_0._uiEffectGos then
		arg_7_0:_addDelayProcessEffect()
	end
end

function var_0_0._addDelayProcessEffect(arg_8_0)
	arg_8_0._repeatCount = 0
	arg_8_0._repeatNum = 5

	TaskDispatcher.cancelTask(arg_8_0._delayProcessEffect, arg_8_0)
	TaskDispatcher.runRepeat(arg_8_0._delayProcessEffect, arg_8_0, 0, arg_8_0._repeatNum)
end

function var_0_0._delayProcessEffect(arg_9_0)
	arg_9_0._repeatCount = arg_9_0._repeatCount + 1

	if arg_9_0._repeatCount < arg_9_0._repeatNum then
		return
	end

	arg_9_0:_doProcessEffect()
end

function var_0_0.cancelCamera(arg_10_0)
	arg_10_0._cancelCamera = true
end

function var_0_0.isCancelCamera(arg_11_0)
	return arg_11_0._cancelCamera
end

function var_0_0._setCameraVisible(arg_12_0, arg_12_1)
	arg_12_0._cameraVisible = arg_12_1

	if arg_12_0._cameraGo then
		gohelper.setActive(arg_12_0._cameraGo, arg_12_1)
	end

	if arg_12_0._rawImageGo then
		gohelper.setActive(arg_12_0._rawImageGo, arg_12_1)
	end
end

function var_0_0.setLocalScale(arg_13_0, arg_13_1)
	arg_13_0._scale = arg_13_1

	if arg_13_0._spineTr then
		transformhelper.setLocalScale(arg_13_0._spineTr, arg_13_0._scale, arg_13_0._scale, 1)
	end
end

function var_0_0.setCameraSize(arg_14_0, arg_14_1)
	arg_14_0._cameraSize = arg_14_1
end

function var_0_0.setCameraLayer(arg_15_0, arg_15_1)
	arg_15_0._cameraLayer = arg_15_1

	if arg_15_0._camera and arg_15_0._cameraLayer then
		arg_15_0._camera.cullingMask = bit.lshift(1, arg_15_0._cameraLayer)
	end
end

function var_0_0._onResLoaded(arg_16_0)
	var_0_0.super._onResLoaded(arg_16_0)
	transformhelper.setLocalScale(arg_16_0._spineTr, arg_16_0._scale, arg_16_0._scale, 1)
	arg_16_0:_initSkinUiEffect()

	if not arg_16_0._cancelCamera then
		arg_16_0:_initCamera()
	end
end

function var_0_0._initSkinUiEffect(arg_17_0)
	arg_17_0._tempVec2 = arg_17_0._tempVec2 or Vector2.New()
	arg_17_0._uiEffectGos = nil
	arg_17_0._uiEffectGosClone = nil
	arg_17_0._uiEffectList = nil
	arg_17_0._uiEffectConfig = nil
	arg_17_0._uiEffectInitVisible = nil
	arg_17_0._uiEffectRealtime = nil
	arg_17_0._hasProcessModelEffect = nil

	for iter_17_0, iter_17_1 in ipairs(lua_skin_ui_effect.configList) do
		if not arg_17_0:_skip(iter_17_1.id) and string.find(arg_17_0._resPath, iter_17_1.id) then
			arg_17_0._uiEffectConfig = iter_17_1
			arg_17_0._uiEffectList = string.split(iter_17_1.effect, "|")
			arg_17_0._uiEffectRealtime = string.splitToNumber(iter_17_1.realtime, "|")
			arg_17_0._uiEffectInitVisible = {}

			break
		end
	end
end

function var_0_0._skip(arg_18_0, arg_18_1)
	return arg_18_1 == 304802
end

function var_0_0.hideModelEffect(arg_19_0)
	if not arg_19_0._uiEffectGos then
		return
	end

	for iter_19_0, iter_19_1 in ipairs(arg_19_0._uiEffectGos) do
		if arg_19_0._uiEffectInitVisible[iter_19_0] then
			gohelper.setActive(iter_19_1, false)
		end
	end
end

function var_0_0.showModelEffect(arg_20_0)
	if not arg_20_0._uiEffectGos then
		return
	end

	for iter_20_0, iter_20_1 in ipairs(arg_20_0._uiEffectGos) do
		if arg_20_0._uiEffectInitVisible[iter_20_0] then
			gohelper.setActive(iter_20_1, true)
		end
	end
end

function var_0_0.processModelEffect(arg_21_0)
	arg_21_0._hasProcessModelEffect = true

	arg_21_0:_doProcessEffect()
end

function var_0_0._processEffect(arg_22_0)
	if arg_22_0._uiEffectList then
		for iter_22_0, iter_22_1 in ipairs(arg_22_0._uiEffectList) do
			local var_22_0 = gohelper.findChild(arg_22_0._spineGo, iter_22_1)

			if var_22_0 then
				arg_22_0._uiEffectInitVisible[iter_22_0] = var_22_0.gameObject.activeSelf

				gohelper.setActive(var_22_0.gameObject, false)
			end
		end
	end

	arg_22_0:_addDelayProcessEffect()
end

function var_0_0._doProcessEffect(arg_23_0)
	if gohelper.isNil(arg_23_0._spineGo) then
		return
	end

	if not arg_23_0._spineGo.activeInHierarchy then
		return
	end

	if arg_23_0._uiEffectGos or not arg_23_0._camera then
		return
	end

	arg_23_0._hasProcessModelEffect = false
	arg_23_0._uiEffectGos = arg_23_0:getUserDataTb_()
	arg_23_0._uiEffectGosClone = arg_23_0:getUserDataTb_()

	if arg_23_0._uiEffectList then
		for iter_23_0, iter_23_1 in ipairs(arg_23_0._uiEffectList) do
			local var_23_0, var_23_1 = arg_23_0:_initSkinUiEffectGo(iter_23_1, arg_23_0._uiEffectInitVisible[iter_23_0], iter_23_0)

			if var_23_0 then
				table.insert(arg_23_0._uiEffectGos, var_23_0)

				arg_23_0._uiEffectGosClone[iter_23_0] = var_23_1
			end
		end
	end

	if arg_23_0:hasEverNodes() then
		arg_23_0:_startRealtimeAdjustPos()
	end
end

function var_0_0._onBodyEffectShow(arg_24_0, arg_24_1)
	if arg_24_0._hasProcessModelEffect then
		arg_24_0:_doProcessEffect()
	end

	arg_24_0._isShowBodyEffect = arg_24_1

	arg_24_0:_startRealtimeAdjustPos()
end

function var_0_0._startRealtimeAdjustPos(arg_25_0)
	TaskDispatcher.cancelTask(arg_25_0._realtimeAdjustPos, arg_25_0)

	if arg_25_0._isShowBodyEffect and arg_25_0._uiEffectGosClone and next(arg_25_0._uiEffectGosClone) then
		TaskDispatcher.runRepeat(arg_25_0._realtimeAdjustPos, arg_25_0, 0.1)
	end
end

function var_0_0._realtimeAdjustPos(arg_26_0)
	local var_26_0 = false

	if arg_26_0._uiEffectGos then
		for iter_26_0, iter_26_1 in ipairs(arg_26_0._uiEffectGos) do
			local var_26_1 = arg_26_0._uiEffectGosClone[iter_26_0]

			if not gohelper.isNil(var_26_1) and not gohelper.isNil(iter_26_1) and iter_26_1.activeSelf then
				var_26_0 = true

				arg_26_0:_adjustPos(var_26_1, iter_26_1)
			end
		end
	end

	if not var_26_0 then
		TaskDispatcher.cancelTask(arg_26_0._realtimeAdjustPos, arg_26_0)
	end
end

function var_0_0._initSkinUiEffectGo(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = gohelper.findChild(arg_27_0._spineGo, arg_27_1)

	if gohelper.isNil(var_27_0) then
		if SLFramework.FrameworkSettings.IsEditor then
			if string.find(arg_27_1, "#") then
				logError(string.format("%s 分隔符使用错误，#要改为|", arg_27_1))

				return
			end

			logError(string.format("找不到特效节点：%s,请检查路径", arg_27_1))

			return
		end

		return
	end

	if arg_27_2 then
		gohelper.setActive(var_27_0.gameObject, true)
	end

	local var_27_1 = LayerMask.NameToLayer("UI")
	local var_27_2 = var_27_0.gameObject:GetComponentsInChildren(typeof(UnityEngine.UI.MaskableGraphic), true)

	for iter_27_0 = 0, var_27_2.Length - 1 do
		local var_27_3 = var_27_2[iter_27_0]

		var_27_3.enabled = true

		gohelper.setLayer(var_27_3.gameObject, var_27_1)
	end

	if arg_27_0._uiEffectRealtime and arg_27_0._uiEffectRealtime[arg_27_3] == 1 then
		local var_27_4 = var_27_0.transform
		local var_27_5 = gohelper.create3d(var_27_4.parent.gameObject, var_27_0.name .. "_Clone")

		var_27_5.transform.localPosition = var_27_4.localPosition

		gohelper.setActive(var_27_5, false)

		local var_27_6 = arg_27_0:_getEffectScale()

		transformhelper.setLocalScale(var_27_0.transform, var_27_6, var_27_6, var_27_6)

		return var_27_0, var_27_5
	end

	arg_27_0:_adjustPos(var_27_0, var_27_0)

	local var_27_7 = arg_27_0:_getEffectScale()

	transformhelper.setLocalScale(var_27_0.transform, var_27_7, var_27_7, var_27_7)

	return var_27_0
end

function var_0_0._getEffectScale(arg_28_0)
	local var_28_0 = arg_28_0._uiEffectConfig.scale

	if var_28_0 <= 0 then
		if SLFramework.FrameworkSettings.IsEditor then
			logError(string.format("id:%d特效scale值错误：%s,不能配小于0的值，正常值是1以上。", arg_28_0._uiEffectConfig.id, var_28_0))
		end

		var_28_0 = 1
	end

	return var_28_0
end

function var_0_0._adjustPos(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_0._camera:WorldToViewportPoint(arg_29_1.transform.position)

	arg_29_0._tempVec2.x = var_29_0.x
	arg_29_0._tempVec2.y = var_29_0.y

	local var_29_1 = arg_29_0._tempVec2
	local var_29_2 = arg_29_0._rawImageGo.transform
	local var_29_3 = (var_29_1 - var_29_2.pivot):Scale(var_29_2.rect.size)
	local var_29_4 = var_29_2.position + var_29_2:TransformVector(var_29_3)

	transformhelper.setPosXY(arg_29_2.transform, var_29_4.x, var_29_4.y)
end

function var_0_0.setCameraLoadedCallback(arg_30_0, arg_30_1, arg_30_2)
	arg_30_0.cameraCallback = arg_30_1
	arg_30_0.cameraCallbackObj = arg_30_2
end

function var_0_0._initCamera(arg_31_0)
	if arg_31_0._guiL2dLoader then
		if arg_31_0._cameraGo then
			arg_31_0:_onCameraLoaded()
		end

		return
	end

	local var_31_0 = UnityEngine.GameObject.New("live2d_camera_root").transform

	var_31_0.parent = arg_31_0._gameTr.parent

	transformhelper.setLocalScale(var_31_0, 1, 1, 1)
	transformhelper.setLocalPos(var_31_0, 0, 0, 0)

	arg_31_0._guiL2dLoader = MultiAbLoader.New()

	arg_31_0._guiL2dLoader:addPath(var_0_1)
	arg_31_0._guiL2dLoader:addPath(var_0_2)
	arg_31_0._guiL2dLoader:startLoad(arg_31_0._loadL2dResFinish, arg_31_0)
end

function var_0_0.openBloomView(arg_32_0, arg_32_1)
	arg_32_0._openBloomView = arg_32_1
end

function var_0_0.getTextureSizeByCameraSize(arg_33_0)
	local var_33_0 = 1600
	local var_33_1 = arg_33_0 / var_0_0.DefaultLive2dCameraSize * var_33_0

	return math.floor(var_33_1)
end

function var_0_0._getRT(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0._openBloomView and arg_34_0._skinId and lua_skin_ui_bloom.configDict[arg_34_0._skinId]

	if var_34_0 and var_34_0[arg_34_0._openBloomView] == 1 then
		return UnityEngine.RenderTexture.GetTemporary(arg_34_1, arg_34_1, 0, UnityEngine.RenderTextureFormat.ARGBHalf)
	end

	return UnityEngine.RenderTexture.GetTemporary(arg_34_1, arg_34_1, 0, UnityEngine.RenderTextureFormat.ARGB32)
end

function var_0_0._loadL2dResFinish(arg_35_0)
	local var_35_0 = arg_35_0._guiL2dLoader:getAssetItem(var_0_1)

	arg_35_0._cameraGo = gohelper.clone(var_35_0:GetResource(), arg_35_0._gameTr.parent.gameObject)

	local var_35_1 = arg_35_0._cameraGo:GetComponent(typeof(UnityEngine.Camera))

	arg_35_0._camera = var_35_1

	if arg_35_0._cameraLayer then
		arg_35_0:setCameraLayer(arg_35_0._cameraLayer)
	end

	if arg_35_0._cameraSize > 0 then
		var_35_1.orthographicSize = arg_35_0._cameraSize
	end

	local var_35_2 = var_0_0.getTextureSizeByCameraSize(var_35_1.orthographicSize) * arg_35_0._adapterScaleOnCreate * arg_35_0._qualityScale
	local var_35_3 = var_0_3.maxTextureSize

	if var_35_3 < var_35_2 then
		var_35_2 = var_35_3
	end

	arg_35_0._rt = arg_35_0._rt or arg_35_0:_getRT(var_35_2)
	var_35_1.targetTexture = arg_35_0._rt
	arg_35_0._rawImageGo = UnityEngine.GameObject.New("live2d_rawImage")
	arg_35_0._rawImageTransform = arg_35_0._rawImageGo.transform
	arg_35_0._rawImageTransform.parent = arg_35_0._gameTr.parent

	arg_35_0:setSpineScale(arg_35_0._rawImageGo)
	transformhelper.setLocalPos(arg_35_0._rawImageTransform, 0, 1000, 0)

	local var_35_4 = gohelper.onceAddComponent(arg_35_0._rawImageGo, gohelper.Type_RawImage)

	var_35_4.texture = arg_35_0._rt
	var_35_4.raycastTarget = false

	var_35_4:SetNativeSize()

	local var_35_5 = arg_35_0._guiL2dLoader:getAssetItem(var_0_2)

	arg_35_0._mat = UnityEngine.Object.Instantiate(var_35_5:GetResource())

	if arg_35_0._uiMaskBuffer ~= nil then
		arg_35_0:setImageUIMask(arg_35_0._uiMaskBuffer)
	end

	var_35_4.material = arg_35_0._mat

	arg_35_0:_setMaterialToInvisible(arg_35_0._mat)
	arg_35_0:_onCameraLoaded()
end

function var_0_0._isAfterLive2d(arg_36_0)
	return arg_36_0._uiEffectConfig and arg_36_0._uiEffectConfig.id == 307502
end

function var_0_0._setMaterialToInvisible(arg_37_0, arg_37_1)
	if gohelper.isNil(arg_37_0._spineGo) then
		return
	end

	local var_37_0 = arg_37_0._spineGo:GetComponent(var_0_4)

	if not var_37_0 then
		return
	end

	var_37_0:SetRawImageMaterial(arg_37_1)

	var_37_0.isInUI = true
end

function var_0_0.setSpineScale(arg_38_0, arg_38_1)
	local var_38_0 = GameUtil.getAdapterScale() / (arg_38_0._adapterScaleOnCreate or 1) / (arg_38_0._qualityScale or 1)

	transformhelper.setLocalScale(arg_38_1.transform, var_38_0, var_38_0, var_38_0)
end

function var_0_0._onCameraLoaded(arg_39_0)
	if arg_39_0:_isAfterLive2d() then
		gohelper.setSiblingAfter(arg_39_0._rawImageGo, arg_39_0._gameObj)
	else
		gohelper.setAsFirstSibling(arg_39_0._rawImageGo)
	end

	if arg_39_0._cameraVisible == nil then
		arg_39_0._cameraVisible = true
	end

	arg_39_0:_setCameraVisible(arg_39_0._cameraVisible)
	arg_39_0:_processEffect()

	if arg_39_0.cameraCallback then
		arg_39_0.cameraCallback(arg_39_0.cameraCallbackObj, arg_39_0)
	end
end

function var_0_0.setImageUIMask(arg_40_0, arg_40_1)
	if arg_40_0._mat then
		if arg_40_1 == true then
			arg_40_0._mat:EnableKeyword("_UIMASK_ON")
		else
			arg_40_0._mat:DisableKeyword("_UIMASK_ON")
		end
	else
		arg_40_0._uiMaskBuffer = arg_40_1
	end
end

function var_0_0.onDestroy(arg_41_0)
	var_0_0.super.onDestroy(arg_41_0)

	if arg_41_0._guiL2dLoader then
		arg_41_0._guiL2dLoader:dispose()

		arg_41_0._guiL2dLoader = nil
	end

	arg_41_0._mat = nil

	if arg_41_0._rt then
		UnityEngine.RenderTexture.ReleaseTemporary(arg_41_0._rt)

		arg_41_0._rt = nil
	end

	TaskDispatcher.cancelTask(arg_41_0._delayProcessEffect, arg_41_0)
	TaskDispatcher.cancelTask(arg_41_0._realtimeAdjustPos, arg_41_0)

	arg_41_0._uiEffectGos = nil
	arg_41_0._uiEffectGosClone = nil
	arg_41_0._rawImageGo = nil
	arg_41_0._cameraGo = nil
end

return var_0_0
