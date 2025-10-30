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

function var_0_0.GetScaleByDevice()
	local var_2_0 = GameGlobalMgr.instance:getScreenState():getLocalQuality() or ModuleEnum.Performance.High
	local var_2_1 = UnityEngine.Screen.dpi
	local var_2_2 = 1

	if var_2_0 ~= ModuleEnum.Performance.Low and var_2_1 > 1 and var_2_1 < var_0_6 then
		var_2_2 = var_0_6 / var_2_1
		var_2_2 = Mathf.Clamp(var_2_2, 1, 1.5)
	end

	local var_2_3 = math.min(GameUtil.getAdapterScale(), var_0_5)

	return var_2_2, var_2_3
end

function var_0_0.ctor(arg_3_0)
	arg_3_0._qualityScale, arg_3_0._adapterScaleOnCreate = var_0_0.GetScaleByDevice()
end

function var_0_0.addEventListeners(arg_4_0)
	arg_4_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_4_0._onScreenResize, arg_4_0)
end

function var_0_0.removeEventListeners(arg_5_0)
	arg_5_0:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_5_0._onScreenResize, arg_5_0)
end

function var_0_0._onScreenResize(arg_6_0)
	if arg_6_0._rawImageGo then
		arg_6_0:setSpineScale(arg_6_0._rawImageGo)
	end
end

function var_0_0.hideCamera(arg_7_0)
	arg_7_0:_setCameraVisible(false)
end

function var_0_0.hideModel(arg_8_0)
	arg_8_0:_setCameraVisible(false)
	gohelper.setActive(arg_8_0._spineGo, false)
end

function var_0_0.showModel(arg_9_0)
	arg_9_0:_setCameraVisible(true)
	gohelper.setActive(arg_9_0._spineGo, true)

	if gohelper.isNil(arg_9_0:getSpineGo()) == false then
		local var_9_0 = arg_9_0:getCurBody()

		arg_9_0:play(var_9_0, var_9_0 == StoryAnimName.B_IDLE)
	end

	if not arg_9_0._uiEffectGos then
		arg_9_0:_addDelayProcessEffect()
	end
end

function var_0_0._addDelayProcessEffect(arg_10_0)
	arg_10_0._repeatCount = 0
	arg_10_0._repeatNum = CharacterVoiceEnum.DelayFrame

	TaskDispatcher.cancelTask(arg_10_0._delayProcessEffect, arg_10_0)
	TaskDispatcher.runRepeat(arg_10_0._delayProcessEffect, arg_10_0, 0, arg_10_0._repeatNum)
end

function var_0_0._delayProcessEffect(arg_11_0)
	arg_11_0._repeatCount = arg_11_0._repeatCount + 1

	if arg_11_0._repeatCount < arg_11_0._repeatNum then
		return
	end

	arg_11_0:_doProcessEffect()
end

function var_0_0.cancelCamera(arg_12_0)
	arg_12_0._cancelCamera = true
end

function var_0_0.isCancelCamera(arg_13_0)
	return arg_13_0._cancelCamera
end

function var_0_0._setCameraVisible(arg_14_0, arg_14_1)
	arg_14_0._cameraVisible = arg_14_1

	if arg_14_0._cameraGo then
		gohelper.setActive(arg_14_0._cameraGo, arg_14_1)
	end

	if arg_14_0._rawImageGo then
		gohelper.setActive(arg_14_0._rawImageGo, arg_14_1)
	end
end

function var_0_0.setLocalScale(arg_15_0, arg_15_1)
	arg_15_0._scale = arg_15_1

	if arg_15_0._spineTr then
		transformhelper.setLocalScale(arg_15_0._spineTr, arg_15_0._scale, arg_15_0._scale, 1)
	end
end

function var_0_0.setCameraSize(arg_16_0, arg_16_1)
	arg_16_0._cameraSize = arg_16_1
end

function var_0_0.setCameraLayer(arg_17_0, arg_17_1)
	arg_17_0._cameraLayer = arg_17_1

	if arg_17_0._camera and arg_17_0._cameraLayer then
		arg_17_0._camera.cullingMask = bit.lshift(1, arg_17_0._cameraLayer)
	end
end

function var_0_0._onResLoaded(arg_18_0)
	var_0_0.super._onResLoaded(arg_18_0)
	transformhelper.setLocalScale(arg_18_0._spineTr, arg_18_0._scale, arg_18_0._scale, 1)
	arg_18_0:_initSkinUiEffect()

	if not arg_18_0._cancelCamera then
		arg_18_0:_initCamera()
	end
end

function var_0_0._initSkinUiEffect(arg_19_0)
	arg_19_0._tempVec2 = arg_19_0._tempVec2 or Vector2.New()
	arg_19_0._uiEffectGos = nil
	arg_19_0._uiEffectGosClone = nil
	arg_19_0._uiEffectList = nil
	arg_19_0._uiEffectConfig = nil
	arg_19_0._uiEffectInitVisible = nil
	arg_19_0._hasProcessModelEffect = nil

	for iter_19_0, iter_19_1 in ipairs(lua_skin_ui_effect.configList) do
		if not arg_19_0:_skip(iter_19_1.id) and string.find(arg_19_0._resPath, iter_19_1.id) then
			arg_19_0._uiEffectConfig = iter_19_1
			arg_19_0._uiEffectList = string.split(iter_19_1.effect, "|")
			arg_19_0._uiEffectInitVisible = {}

			break
		end
	end
end

function var_0_0._skip(arg_20_0, arg_20_1)
	return arg_20_1 == 304802
end

function var_0_0.hideModelEffect(arg_21_0)
	if not arg_21_0._uiEffectGos then
		return
	end

	for iter_21_0, iter_21_1 in ipairs(arg_21_0._uiEffectGos) do
		if arg_21_0._uiEffectInitVisible[iter_21_0] then
			gohelper.setActive(iter_21_1, false)
		end
	end
end

function var_0_0.showModelEffect(arg_22_0)
	if not arg_22_0._uiEffectGos then
		return
	end

	for iter_22_0, iter_22_1 in ipairs(arg_22_0._uiEffectGos) do
		if arg_22_0._uiEffectInitVisible[iter_22_0] then
			gohelper.setActive(iter_22_1, true)
		end
	end
end

function var_0_0.processModelEffect(arg_23_0)
	arg_23_0._hasProcessModelEffect = true

	arg_23_0:_doProcessEffect()
end

function var_0_0._processEffect(arg_24_0)
	if arg_24_0._uiEffectList then
		for iter_24_0, iter_24_1 in ipairs(arg_24_0._uiEffectList) do
			local var_24_0 = gohelper.findChild(arg_24_0._spineGo, iter_24_1)

			if var_24_0 then
				arg_24_0._uiEffectInitVisible[iter_24_0] = var_24_0.gameObject.activeSelf

				gohelper.setActive(var_24_0.gameObject, false)
			end
		end
	end

	arg_24_0:_addDelayProcessEffect()
end

function var_0_0._doProcessEffect(arg_25_0)
	if gohelper.isNil(arg_25_0._spineGo) then
		return
	end

	if not arg_25_0._spineGo.activeInHierarchy then
		return
	end

	if arg_25_0._uiEffectGos or not arg_25_0._camera then
		return
	end

	arg_25_0._hasProcessModelEffect = false
	arg_25_0._uiEffectGos = arg_25_0:getUserDataTb_()
	arg_25_0._uiEffectGosClone = arg_25_0:getUserDataTb_()

	if arg_25_0._uiEffectList then
		for iter_25_0, iter_25_1 in ipairs(arg_25_0._uiEffectList) do
			local var_25_0, var_25_1 = arg_25_0:_initSkinUiEffectGo(iter_25_1, arg_25_0._uiEffectInitVisible[iter_25_0], iter_25_0)

			if var_25_0 then
				table.insert(arg_25_0._uiEffectGos, var_25_0)

				arg_25_0._uiEffectGosClone[iter_25_0] = var_25_1
			end
		end
	end

	arg_25_0:_initEffectLayer()

	if arg_25_0:hasEverNodes() then
		arg_25_0:_startRealtimeAdjustPos()
	end
end

function var_0_0._initEffectLayer(arg_26_0)
	local var_26_0
	local var_26_1

	for iter_26_0, iter_26_1 in ipairs(lua_character_motion_effect_layer.configList) do
		if string.find(arg_26_0._resPath, iter_26_1.heroResName) then
			var_26_0 = string.split(iter_26_1.node1, "|")
			var_26_1 = iter_26_1.node1Layer

			break
		end
	end

	if not var_26_0 then
		return
	end

	local var_26_2 = UnityLayer[var_26_1]

	if not var_26_2 then
		logError(string.format("layerName:%s is not exist", var_26_1))

		return
	end

	for iter_26_2, iter_26_3 in ipairs(var_26_0) do
		local var_26_3 = gohelper.findChild(arg_26_0._spineGo, iter_26_3)

		if var_26_3 then
			gohelper.setLayer(var_26_3, var_26_2)
		else
			logError(string.format("GuiLive2d _initEffectLayer path:%s is not exist", iter_26_3))
		end
	end
end

function var_0_0._onBodyEffectShow(arg_27_0, arg_27_1)
	if arg_27_0._hasProcessModelEffect then
		arg_27_0:_doProcessEffect()
	end

	arg_27_0._isShowBodyEffect = arg_27_1

	arg_27_0:_startRealtimeAdjustPos()
end

function var_0_0._startRealtimeAdjustPos(arg_28_0)
	TaskDispatcher.cancelTask(arg_28_0._realtimeAdjustPos, arg_28_0)

	if arg_28_0._isShowBodyEffect and arg_28_0._uiEffectGosClone and next(arg_28_0._uiEffectGosClone) then
		TaskDispatcher.runRepeat(arg_28_0._realtimeAdjustPos, arg_28_0, 0.1)
	end
end

function var_0_0._realtimeAdjustPos(arg_29_0)
	local var_29_0 = false

	if arg_29_0._uiEffectGos then
		for iter_29_0, iter_29_1 in ipairs(arg_29_0._uiEffectGos) do
			local var_29_1 = arg_29_0._uiEffectGosClone[iter_29_0]

			if not gohelper.isNil(var_29_1) and not gohelper.isNil(iter_29_1) and iter_29_1.activeSelf then
				var_29_0 = true

				arg_29_0:_adjustPos(var_29_1, iter_29_1)
			end
		end
	end

	if not var_29_0 then
		TaskDispatcher.cancelTask(arg_29_0._realtimeAdjustPos, arg_29_0)
	end
end

function var_0_0._initSkinUiEffectGo(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = gohelper.findChild(arg_30_0._spineGo, arg_30_1)

	if gohelper.isNil(var_30_0) then
		if SLFramework.FrameworkSettings.IsEditor then
			if string.find(arg_30_1, "#") then
				logError(string.format("%s 分隔符使用错误，#要改为|", arg_30_1))

				return
			end

			logError(string.format("找不到特效节点：%s,请检查路径", arg_30_1))

			return
		end

		return
	end

	if arg_30_2 then
		gohelper.setActive(var_30_0.gameObject, true)
	end

	local var_30_1 = LayerMask.NameToLayer("UI")
	local var_30_2 = var_30_0.gameObject:GetComponentsInChildren(typeof(UnityEngine.UI.MaskableGraphic), true)

	for iter_30_0 = 0, var_30_2.Length - 1 do
		local var_30_3 = var_30_2[iter_30_0]

		if isDebugBuild and var_30_3.enabled then
			logError(string.format("特效:%s,节点：%s,UIParticle初始已启用,请动效老师检查!", arg_30_1, var_30_3.name))
		end

		var_30_3.enabled = true

		gohelper.setLayer(var_30_3.gameObject, var_30_1)
	end

	local var_30_4 = true

	if var_30_4 then
		local var_30_5 = var_30_0.transform
		local var_30_6 = gohelper.create3d(var_30_5.parent.gameObject, var_30_0.name .. "_Clone")

		var_30_6.transform.localPosition = var_30_5.localPosition

		gohelper.setActive(var_30_6, false)

		local var_30_7 = arg_30_0:_getEffectScale()

		transformhelper.setLocalScale(var_30_0.transform, var_30_7, var_30_7, var_30_7)
		arg_30_0:_adjustPos(var_30_6, var_30_0)

		return var_30_0, var_30_6
	end

	arg_30_0:_adjustPos(var_30_0, var_30_0)

	local var_30_8 = arg_30_0:_getEffectScale()

	transformhelper.setLocalScale(var_30_0.transform, var_30_8, var_30_8, var_30_8)

	return var_30_0
end

function var_0_0._getEffectScale(arg_31_0)
	local var_31_0 = arg_31_0._uiEffectConfig.scale

	if var_31_0 <= 0 then
		if SLFramework.FrameworkSettings.IsEditor then
			logError(string.format("id:%d特效scale值错误：%s,不能配小于0的值，正常值是1以上。", arg_31_0._uiEffectConfig.id, var_31_0))
		end

		var_31_0 = 1
	end

	return var_31_0
end

function var_0_0._adjustPos(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_0._camera:WorldToViewportPoint(arg_32_1.transform.position)

	arg_32_0._tempVec2.x = var_32_0.x
	arg_32_0._tempVec2.y = var_32_0.y

	local var_32_1 = arg_32_0._tempVec2
	local var_32_2 = arg_32_0._rawImageGo.transform
	local var_32_3 = (var_32_1 - var_32_2.pivot):Scale(var_32_2.rect.size)
	local var_32_4 = var_32_2.position + var_32_2:TransformVector(var_32_3)

	transformhelper.setPosXY(arg_32_2.transform, var_32_4.x, var_32_4.y)
end

function var_0_0.setCameraLoadedCallback(arg_33_0, arg_33_1, arg_33_2)
	arg_33_0.cameraCallback = arg_33_1
	arg_33_0.cameraCallbackObj = arg_33_2
end

function var_0_0.setCameraLoadFinishCallback(arg_34_0, arg_34_1, arg_34_2)
	arg_34_0.cameraFinishCallback = arg_34_1
	arg_34_0.cameraFinishCallbackObj = arg_34_2

	if not gohelper.isNil(arg_34_0._cameraGo) and arg_34_0.cameraFinishCallback then
		arg_34_0.cameraFinishCallback(arg_34_0.cameraFinishCallbackObj, arg_34_0)
	end
end

function var_0_0._initCamera(arg_35_0)
	if arg_35_0._guiL2dLoader then
		if arg_35_0._cameraGo then
			arg_35_0:_onCameraLoaded()
		end

		return
	end

	local var_35_0 = UnityEngine.GameObject.New("live2d_camera_root").transform

	var_35_0.parent = arg_35_0._gameTr.parent

	transformhelper.setLocalScale(var_35_0, 1, 1, 1)
	transformhelper.setLocalPos(var_35_0, 0, 0, 0)

	arg_35_0._guiL2dLoader = MultiAbLoader.New()

	arg_35_0._guiL2dLoader:addPath(var_0_1)
	arg_35_0._guiL2dLoader:addPath(var_0_2)
	arg_35_0._guiL2dLoader:startLoad(arg_35_0._loadL2dResFinish, arg_35_0)
end

function var_0_0.openBloomView(arg_36_0, arg_36_1)
	arg_36_0._openBloomView = arg_36_1
end

function var_0_0.setShareRT(arg_37_0, arg_37_1, arg_37_2)
	arg_37_0._shareRT = arg_37_1
	arg_37_0._rtViewName = arg_37_2
end

function var_0_0.getTextureSizeByCameraSize(arg_38_0)
	local var_38_0 = 1600
	local var_38_1 = arg_38_0 / var_0_0.DefaultLive2dCameraSize * var_38_0

	return math.floor(var_38_1)
end

function var_0_0._getOpenBloomView(arg_39_0)
	local var_39_0 = arg_39_0._openBloomView and arg_39_0._skinId and lua_skin_ui_bloom.configDict[arg_39_0._skinId]

	return var_39_0 and var_39_0[arg_39_0._openBloomView] == 1
end

function var_0_0._getRT(arg_40_0, arg_40_1)
	if arg_40_0:_getOpenBloomView() then
		return UnityEngine.RenderTexture.GetTemporary(arg_40_1, arg_40_1, 0, UnityEngine.RenderTextureFormat.ARGBHalf)
	end

	return UnityEngine.RenderTexture.GetTemporary(arg_40_1, arg_40_1, 0, UnityEngine.RenderTextureFormat.ARGB32)
end

function var_0_0._loadL2dResFinish(arg_41_0)
	local var_41_0 = arg_41_0._guiL2dLoader:getAssetItem(var_0_1)

	arg_41_0._cameraGo = gohelper.clone(var_41_0:GetResource(), arg_41_0._gameTr.parent.gameObject)

	local var_41_1 = arg_41_0._cameraGo:GetComponent(typeof(UnityEngine.Camera))

	arg_41_0._camera = var_41_1

	if arg_41_0._cameraLayer then
		arg_41_0:setCameraLayer(arg_41_0._cameraLayer)
	end

	if arg_41_0._cameraSize > 0 then
		var_41_1.orthographicSize = arg_41_0._cameraSize
	end

	local var_41_2 = var_0_0.getTextureSizeByCameraSize(var_41_1.orthographicSize) * arg_41_0._adapterScaleOnCreate * arg_41_0._qualityScale
	local var_41_3 = var_0_3.maxTextureSize

	if var_41_3 < var_41_2 then
		var_41_2 = var_41_3
	end

	arg_41_0._rawImageGo = UnityEngine.GameObject.New("live2d_rawImage")
	arg_41_0._rawImageTransform = arg_41_0._rawImageGo.transform
	arg_41_0._rawImageTransform.parent = arg_41_0._gameTr.parent

	arg_41_0:setSpineScale(arg_41_0._rawImageGo)
	transformhelper.setLocalPos(arg_41_0._rawImageTransform, 0, 1000, 0)

	local var_41_4 = gohelper.onceAddComponent(arg_41_0._rawImageGo, gohelper.Type_RawImage)

	var_41_4.raycastTarget = false

	if not arg_41_0._shareRT then
		arg_41_0._rt = arg_41_0._rt or arg_41_0:_getRT(var_41_2)
		var_41_1.targetTexture = arg_41_0._rt
		var_41_4.texture = arg_41_0._rt

		var_41_4:SetNativeSize()
	else
		if arg_41_0._shareRT == CharacterVoiceEnum.RTShareType.BloomAuto then
			arg_41_0._shareRT = arg_41_0:_getOpenBloomView() and CharacterVoiceEnum.RTShareType.BloomOpen or CharacterVoiceEnum.RTShareType.BloomClose
		end

		if arg_41_0._shareRT == CharacterVoiceEnum.RTShareType.FullScreen then
			Live2dRTShareController.instance:clearAllRT()

			arg_41_0._rt = arg_41_0._rt or arg_41_0:_getRT(var_41_2)
			var_41_1.targetTexture = arg_41_0._rt
			var_41_4.texture = arg_41_0._rt

			var_41_4:SetNativeSize()
		end

		Live2dRTShareController.instance:addShareInfo(var_41_1, var_41_4, arg_41_0._shareRT, arg_41_0._heroId, arg_41_0._skinId, arg_41_0._rtViewName)
	end

	local var_41_5 = arg_41_0._guiL2dLoader:getAssetItem(var_0_2)

	arg_41_0._mat = UnityEngine.Object.Instantiate(var_41_5:GetResource())

	if arg_41_0._uiMaskBuffer ~= nil then
		arg_41_0:setImageUIMask(arg_41_0._uiMaskBuffer)
	end

	var_41_4.material = arg_41_0._mat

	arg_41_0:_setMaterialToInvisible(arg_41_0._mat)
	arg_41_0:_onCameraLoaded()
end

function var_0_0._isAfterLive2d(arg_42_0)
	return arg_42_0._uiEffectConfig and arg_42_0._uiEffectConfig.id == 307502
end

function var_0_0._setMaterialToInvisible(arg_43_0, arg_43_1)
	if gohelper.isNil(arg_43_0._spineGo) then
		return
	end

	local var_43_0 = arg_43_0._spineGo:GetComponent(var_0_4)

	if not var_43_0 then
		return
	end

	var_43_0:SetRawImageMaterial(arg_43_1)

	var_43_0.isInUI = true
end

function var_0_0.setSpineScale(arg_44_0, arg_44_1)
	local var_44_0 = GameUtil.getAdapterScale() / (arg_44_0._adapterScaleOnCreate or 1) / (arg_44_0._qualityScale or 1)

	transformhelper.setLocalScale(arg_44_1.transform, var_44_0, var_44_0, var_44_0)
end

function var_0_0._onCameraLoaded(arg_45_0)
	if arg_45_0:_isAfterLive2d() then
		gohelper.setSiblingAfter(arg_45_0._rawImageGo, arg_45_0._gameObj)
	else
		gohelper.setAsFirstSibling(arg_45_0._rawImageGo)
	end

	if arg_45_0._cameraVisible == nil then
		arg_45_0._cameraVisible = true
	end

	arg_45_0:_setCameraVisible(arg_45_0._cameraVisible)
	arg_45_0:_processEffect()

	if arg_45_0.cameraCallback then
		arg_45_0.cameraCallback(arg_45_0.cameraCallbackObj, arg_45_0)
	end

	if arg_45_0.cameraFinishCallback then
		arg_45_0.cameraFinishCallback(arg_45_0.cameraFinishCallbackObj, arg_45_0)
	end
end

function var_0_0.setImageUIMask(arg_46_0, arg_46_1)
	if arg_46_0._mat then
		if arg_46_1 == true then
			arg_46_0._mat:EnableKeyword("_UIMASK_ON")
		else
			arg_46_0._mat:DisableKeyword("_UIMASK_ON")
		end
	else
		arg_46_0._uiMaskBuffer = arg_46_1
	end
end

function var_0_0.onDestroy(arg_47_0)
	var_0_0.super.onDestroy(arg_47_0)

	if arg_47_0._guiL2dLoader then
		arg_47_0._guiL2dLoader:dispose()

		arg_47_0._guiL2dLoader = nil
	end

	arg_47_0._mat = nil

	if arg_47_0._rt then
		UnityEngine.RenderTexture.ReleaseTemporary(arg_47_0._rt)

		arg_47_0._rt = nil
	end

	TaskDispatcher.cancelTask(arg_47_0._delayProcessEffect, arg_47_0)
	TaskDispatcher.cancelTask(arg_47_0._realtimeAdjustPos, arg_47_0)

	arg_47_0._uiEffectGos = nil
	arg_47_0._uiEffectGosClone = nil
	arg_47_0._rawImageGo = nil
	arg_47_0._cameraGo = nil
end

return var_0_0
