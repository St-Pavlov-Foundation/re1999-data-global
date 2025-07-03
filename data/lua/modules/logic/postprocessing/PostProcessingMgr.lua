module("modules.logic.postprocessing.PostProcessingMgr", package.seeall)

local var_0_0 = class("PostProcessingMgr")

var_0_0.PPEffectMaskType = typeof(UrpCustom.PPEffectMask)
var_0_0.PPCustomCamDataType = typeof(UrpCustom.CustomCameraData)
var_0_0.PPVolumeType = typeof(UnityEngine.Rendering.Volume)
var_0_0.PPVolumeWrapType = typeof(UrpCustom.PPVolumeWrap)
var_0_0.MainHighProfilePath = "ppassets/profiles/main_profile_high.asset"
var_0_0.MainMiddleProfilePath = "ppassets/profiles/main_profile_middle.asset"
var_0_0.MainLowProfilePath = "ppassets/profiles/main_profile_low.asset"
var_0_0.CaptureResPath = "ppassets/capture.prefab"
var_0_0.DesamplingRate = {
	x8 = 8,
	x4 = 4,
	x1 = 1,
	x2 = 2
}
var_0_0.BlurMode = {
	FastBlur = 0,
	DetailBlur = 2,
	None = 3,
	MediumBlur = 1
}

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._mainCameraGo = arg_1_1
	arg_1_0._mainCamera = arg_1_1:GetComponent("Camera")
	arg_1_0._mainCamData = arg_1_1:GetComponent(var_0_0.PPCustomCamDataType)
	arg_1_0._unitCameraGo = arg_1_2
	arg_1_0._unitCamera = arg_1_2:GetComponent("Camera")
	arg_1_0._uiCameraGo = arg_1_3
	arg_1_0._uiCamera = arg_1_3:GetComponent("Camera")
	arg_1_0._isUIActive = false
	arg_1_0._isStoryUIActive = false
	arg_1_0.useMirrorEffect = arg_1_0._mainCamData.useMirrorEffect
	arg_1_0._unitCamData = arg_1_0._unitCameraGo:GetComponent(var_0_0.PPCustomCamDataType)
	arg_1_0._unitPPVolume = gohelper.findChildComponent(arg_1_0._unitCameraGo, "PPVolume", var_0_0.PPVolumeWrapType)
	arg_1_0._highProfile = ConstAbCache.instance:getRes(var_0_0.MainHighProfilePath)
	arg_1_0._middleProfile = ConstAbCache.instance:getRes(var_0_0.MainMiddleProfilePath)
	arg_1_0._lowProfile = ConstAbCache.instance:getRes(var_0_0.MainLowProfilePath)
	arg_1_0._uiCamData = arg_1_0._uiCameraGo:GetComponent(var_0_0.PPCustomCamDataType)
	arg_1_0._uiPPVolume = gohelper.findChildComponent(arg_1_0._uiCameraGo, "PPUIVolume", var_0_0.PPVolumeWrapType)

	ViewMgr.instance:registerCallback(ViewEvent.ReOpenWhileOpen, arg_1_0._reopenWhileOpen, arg_1_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_1_0._onOpenView, arg_1_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_1_0._onOpenFinishView, arg_1_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_1_0._onCloseView, arg_1_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_1_0._onCloseViewFinish, arg_1_0)
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, arg_1_0._onScreenResize, arg_1_0)

	local var_1_0 = gohelper.clone(ConstAbCache.instance:getRes(var_0_0.CaptureResPath), gohelper.find("UIRoot/POPUP_TOP"), "CaptureView")

	arg_1_0._capture = var_1_0:GetComponent(typeof(UrpCustom.UIGaussianEffect))
	arg_1_0._captureView = var_1_0

	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, arg_1_0._onEnterScene, arg_1_0)

	arg_1_0._closeRefreshViewBlurDict = {}
	arg_1_0._viewNameBlurDict = {}
	arg_1_0._fullViewCanBlur = {
		[ViewName.DungeonMapView] = true
	}
end

function var_0_0.getCaptureView(arg_2_0)
	return arg_2_0._captureView
end

function var_0_0.setViewBlur(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._viewNameBlurDict[arg_3_1] = arg_3_2
end

function var_0_0._getViewBlur(arg_4_0, arg_4_1)
	if arg_4_0._viewNameBlurDict[arg_4_1] then
		return arg_4_0._viewNameBlurDict[arg_4_1]
	end

	return ViewMgr.instance:getSetting(arg_4_1).bgBlur
end

function var_0_0._reopenWhileOpen(arg_5_0, arg_5_1)
	arg_5_0:_refreshPopUpBlur(arg_5_1, true, true, ViewEvent.OnOpenView)
	arg_5_0:_refreshViewBlur(ViewEvent.ReOpenWhileOpen)
	arg_5_0:_adjustMask(arg_5_1)
end

function var_0_0._onOpenView(arg_6_0, arg_6_1)
	if arg_6_1 == "LoginView" or arg_6_1 == "SimulateLoginView" then
		arg_6_0:setUnitActive(false)
	else
		arg_6_0:_refreshPopUpBlur(arg_6_1, true, false, ViewEvent.OnOpenView)
		arg_6_0:_refreshViewBlur(ViewEvent.OnOpenView)
		arg_6_0:_adjustMask(arg_6_1)
	end
end

function var_0_0._onScreenResize(arg_7_0)
	arg_7_0:_refreshViewBlur()
end

function var_0_0._adjustMask(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = ViewMgr.instance:getOpenViewNameList()
	local var_8_1 = ViewMgr.instance:getOpenViewNameList()

	for iter_8_0 = #var_8_1, 1, -1 do
		local var_8_2 = var_8_1[iter_8_0]

		if ViewMgr.instance:isModal(var_8_2) then
			if not arg_8_2 or ViewMgr.instance:isOpenFinish(var_8_2) then
				ViewModalMaskMgr.instance:_adjustMask(var_8_2)

				return
			end
		elseif ViewMgr.instance:isFull(var_8_2) then
			return
		end
	end
end

function var_0_0._onOpenFinishView(arg_9_0, arg_9_1)
	if arg_9_1 == ViewName.MessageBoxView and StoryController.instance._curStoryId == 100717 then
		return
	end

	if arg_9_1 == "LoginView" or arg_9_1 == "SimulateLoginView" then
		arg_9_0:setUnitActive(false)
	else
		arg_9_0:_refreshViewBlur(ViewEvent.OnOpenViewFinish)
	end
end

function var_0_0._onCloseView(arg_10_0, arg_10_1)
	arg_10_0:_refreshPopUpBlur(arg_10_1, false, false, ViewEvent.OnCloseView)
	arg_10_0:_closeRefreshViewBlur(ViewEvent.OnCloseView, arg_10_1)
	arg_10_0:_adjustMask(arg_10_1, true)
end

function var_0_0._onCloseViewFinish(arg_11_0, arg_11_1)
	arg_11_0:_refreshPopUpBlur(arg_11_1, false, false, ViewEvent.OnCloseViewFinish)
	arg_11_0:_closeRefreshViewBlur(ViewEvent.OnCloseViewFinish, arg_11_1)
	arg_11_0:_adjustMask(arg_11_1, true)
end

function var_0_0.setCloseSkipRefreshBlur(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0._closeRefreshViewBlurDict[arg_12_1] = arg_12_2
end

function var_0_0.forceRefreshCloseBlur(arg_13_0)
	arg_13_0:_refreshViewBlur(ViewEvent.OnCloseViewFinish)
end

function var_0_0._closeRefreshViewBlur(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0._closeRefreshViewBlurDict[arg_14_2] then
		if arg_14_1 == ViewEvent.OnCloseViewFinish then
			arg_14_0._closeRefreshViewBlurDict[arg_14_2] = nil
		end

		return
	end

	arg_14_0:_refreshViewBlur(arg_14_1)
end

function var_0_0._refreshViewBlur(arg_15_0, arg_15_1)
	local var_15_0, var_15_1, var_15_2, var_15_3 = arg_15_0:_judgeBlur()

	arg_15_0:setUIBlurActive(var_15_0 or 0, var_15_2, var_15_3, arg_15_1)
end

function var_0_0._refreshFreezeBlur(arg_16_0)
	local var_16_0, var_16_1, var_16_2, var_16_3 = arg_16_0:_judgeBlur()

	arg_16_0:setUIBlurActive(2, var_16_2, var_16_3)
end

function var_0_0._judgeBlur(arg_17_0)
	local var_17_0 = ViewMgr.instance:getOpenViewNameList()

	for iter_17_0 = #var_17_0, 1, -1 do
		local var_17_1 = var_17_0[iter_17_0]
		local var_17_2 = ViewMgr.instance:getSetting(var_17_1)

		if var_17_2.layer == UILayerName.PopUp then
			return false
		end

		local var_17_3 = arg_17_0:_getViewBlur(var_17_1)

		if var_17_3 and var_17_3 > 0 then
			local var_17_4 = {
				blurMode = var_17_2.blurMode,
				blurFactor = var_17_2.blurFactor,
				desampleRate = var_17_2.desampleRate,
				reduceRate = var_17_2.reduceRate,
				blurIterations = var_17_2.blurIterations
			}

			return var_17_3, var_17_1, var_17_4, var_17_2.hideUI
		end

		if var_17_2.viewType == ViewType.Full then
			return false
		end
	end

	return false
end

function var_0_0._refreshPopUpBlur(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	local var_18_0 = ViewMgr.instance:getOpenViewNameList()
	local var_18_1, var_18_2 = arg_18_0:_judgeBlur()

	if var_18_1 then
		arg_18_0:_refreshPopUpBlurIsBlur(arg_18_1, arg_18_2, var_18_2)
	else
		arg_18_0:_refreshPopUpBlurNotBlur(arg_18_1, arg_18_2)
	end
end

function var_0_0._refreshPopUpBlurIsBlur(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = ViewMgr.instance:getOpenViewNameList()
	local var_19_1 = gohelper.findChild(ViewMgr.instance:getUIRoot(), "POPUPBlur")
	local var_19_2 = gohelper.findChild(ViewMgr.instance:getTopUIRoot(), "POPUP_TOP")
	local var_19_3 = 1
	local var_19_4
	local var_19_5 = false

	for iter_19_0 = 1, #var_19_0 do
		local var_19_6 = var_19_0[iter_19_0]

		if var_19_6 == arg_19_3 then
			var_19_5 = true
		end

		if ViewMgr.instance:getSetting(var_19_6).layer == "POPUP_TOP" then
			local var_19_7 = (var_19_6 == arg_19_3 or var_19_5) and var_19_2 or var_19_1
			local var_19_8 = ViewMgr.instance:getContainer(var_19_6).viewGO
			local var_19_9 = var_19_8 and var_19_8.transform.parent or nil

			if var_19_9 == var_19_2.transform or var_19_9 == var_19_1.transform then
				if arg_19_0:_isKeepTop(iter_19_0, var_19_0, arg_19_3) then
					var_19_7 = var_19_2
				end

				gohelper.addChild(var_19_7, var_19_8)
				arg_19_0:_setChildCanvasLayer(var_19_8, var_19_7 == var_19_2 and UnityLayer.UITop or UnityLayer.UIThird, false)

				if var_19_7 == var_19_2 then
					var_19_4 = var_19_8

					gohelper.setSibling(var_19_8, var_19_3)

					var_19_3 = var_19_3 + 1
				else
					gohelper.setAsLastSibling(var_19_8)
				end
			end
		end
	end

	if var_19_4 then
		gohelper.setAsLastSibling(var_19_4)
	end
end

function var_0_0._isKeepTop(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = arg_20_2[arg_20_1]
	local var_20_1 = arg_20_2[arg_20_1 + 1]
	local var_20_2 = ViewMgr.instance:getContainer(var_20_0)

	if var_20_2 and (string.find(var_20_0, "HeroGroupFightView") or isTypeOf(var_20_2, HeroGroupFightViewContainer)) and var_20_1 == ViewName.HeroGroupCareerTipView then
		return true
	end

	if var_20_0 == ViewName.RoomInitBuildingView and var_20_1 == ViewName.RoomFormulaView and arg_20_3 == ViewName.RoomFormulaView then
		return true
	end

	return false
end

function var_0_0._refreshPopUpBlurNotBlur(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = ViewMgr.instance:getOpenViewNameList()
	local var_21_1 = gohelper.findChild(ViewMgr.instance:getUIRoot(), "POPUPBlur")
	local var_21_2 = gohelper.findChild(ViewMgr.instance:getTopUIRoot(), "POPUP_TOP")
	local var_21_3 = 1
	local var_21_4

	for iter_21_0 = 1, #var_21_0 do
		local var_21_5 = var_21_0[iter_21_0]

		if ViewMgr.instance:getSetting(var_21_5).layer == "POPUP_TOP" then
			local var_21_6 = ViewMgr.instance:getContainer(var_21_5).viewGO
			local var_21_7 = var_21_6 and var_21_6.transform.parent or nil

			if var_21_7 == var_21_2.transform or var_21_7 == var_21_1.transform then
				gohelper.addChild(var_21_2, var_21_6)
				arg_21_0:_setChildCanvasLayer(var_21_6, UnityLayer.UITop, false)

				var_21_4 = var_21_6

				gohelper.setSibling(var_21_6, var_21_3)

				var_21_3 = var_21_3 + 1
			end
		end
	end

	if var_21_4 and arg_21_2 then
		gohelper.setAsLastSibling(var_21_4)
	end
end

function var_0_0._setChildCanvasLayer(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	if not arg_22_1 then
		return
	end

	local var_22_0 = arg_22_1:GetComponentsInChildren(typeof(UnityEngine.Canvas), true)

	if var_22_0 then
		local var_22_1 = var_22_0:GetEnumerator()

		while var_22_1:MoveNext() do
			if not LuaUtil.strEndswith(var_22_1.Current.gameObject.name, "_uicanvas") then
				gohelper.setLayer(var_22_1.Current.gameObject, arg_22_2, arg_22_3)
			end
		end
	end
end

function var_0_0._isBlurView(arg_23_0, arg_23_1)
	local var_23_0 = ViewMgr.instance:getSetting(arg_23_1)

	if var_23_0 and var_23_0.bgBlur and var_23_0.bgBlur > 0 then
		return true
	end

	return false
end

function var_0_0._hasBlurViewOpened(arg_24_0)
	local var_24_0 = ViewMgr.instance:getOpenViewNameList()

	for iter_24_0, iter_24_1 in ipairs(var_24_0) do
		if arg_24_0:_isBlurView(iter_24_1) then
			return true
		end
	end

	return false
end

function var_0_0.setUIActive(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_2 then
		arg_25_0._isStoryUIActive = arg_25_1
	else
		arg_25_0._isUIActive = arg_25_1
	end

	arg_25_0._uiCamData.usePostProcess = arg_25_0._isUIActive or arg_25_0._isStoryUIActive
end

function var_0_0.setUnitActive(arg_26_0, arg_26_1)
	arg_26_0._unitCamData.usePostProcess = arg_26_1
end

function var_0_0.setUIBlur(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = arg_27_3 and arg_27_3.blurMode or var_0_0.BlurMode.MediumBlur
	local var_27_1 = arg_27_3 and arg_27_3.blurFactor or 0.4
	local var_27_2 = arg_27_3 and arg_27_3.desampleRate or var_0_0.DesamplingRate.x8
	local var_27_3 = arg_27_3 and arg_27_3.reduceRate or var_0_0.DesamplingRate.x4
	local var_27_4 = arg_27_3 and arg_27_3.blurIterations or 3
	local var_27_5 = GameSceneMgr.instance:getCurSceneType()

	if arg_27_1 then
		arg_27_0:setBlurMode(var_27_0)
		arg_27_0:setDesamplingRate(arg_27_2 and var_0_0.DesamplingRate.x1 or var_0_0.DesamplingRate.x8)
		arg_27_0:setDesamplingRate(var_27_2)
		arg_27_0:setBlurIterations(var_27_4)
		arg_27_0:setReduceRate(var_27_3)
		arg_27_0:setBlurFactor(var_27_1)
		arg_27_0._capture:SetKeepCapture(arg_27_2)

		if not arg_27_2 then
			arg_27_0:setBlurWeight(1)
			arg_27_0._capture:Capture()
		end
	end

	arg_27_0._capture.enabled = arg_27_1
end

function var_0_0.IsGaussianFreezeStatus(arg_28_0)
	return arg_28_0._capture.enabled and not arg_28_0._capture.keepToScreen
end

function var_0_0.setBlurMode(arg_29_0, arg_29_1)
	arg_29_0._capture:SetBlurMode(arg_29_1)
end

function var_0_0.setBlurFactor(arg_30_0, arg_30_1)
	arg_30_0._capture.blurFactor = math.max(0, math.min(1, arg_30_1))
end

function var_0_0.setBlurWeight(arg_31_0, arg_31_1)
	if not arg_31_0:IsGaussianFreezeStatus() then
		arg_31_0._capture.blurWeight = math.max(0, math.min(1, arg_31_1))
	end
end

function var_0_0.setDesamplingRate(arg_32_0, arg_32_1)
	arg_32_0._capture.desamplingRate = arg_32_1
end

function var_0_0.setReduceRate(arg_33_0, arg_33_1)
	arg_33_0._capture.reduteRate = arg_33_1
end

function var_0_0.setBlurIterations(arg_34_0, arg_34_1)
	arg_34_0._capture.blurIterations = arg_34_1
end

function var_0_0.setUIBloom(arg_35_0, arg_35_1)
	arg_35_0._uiBloomActive = arg_35_1
end

function var_0_0.setIgnoreUIBlur(arg_36_0, arg_36_1)
	arg_36_0._isIgnoreUIBlur = arg_36_1
end

function var_0_0.getIgnoreUIBlur(arg_37_0)
	return arg_37_0._isIgnoreUIBlur
end

function var_0_0.setUIBlurActive(arg_38_0, arg_38_1, arg_38_2, arg_38_3, arg_38_4)
	if arg_38_0._isIgnoreUIBlur then
		return
	end

	if arg_38_0._uiCamData and arg_38_0._unitCamData and arg_38_0._capture then
		local var_38_0 = CameraMgr.instance:getMainCamera()
		local var_38_1 = CameraMgr.instance:getUICamera()
		local var_38_2 = GameSceneMgr.instance:getCurSceneType()

		if arg_38_1 == false or arg_38_1 == 0 then
			if arg_38_4 ~= ViewEvent.OnCloseView then
				arg_38_0:setUIActive(false)
			end

			arg_38_0._unitCamData.usePostProcess = var_38_2 ~= SceneType.Room

			arg_38_0:setUIPPValue("bloomActive", false)
			arg_38_0:setUIPPValue("localMaskActive", false)
			arg_38_0:setUIPPValue("LocalMaskActive", false)
			arg_38_0:setFreezeVisble(true)
			arg_38_0:setUIBlur(false)
		else
			arg_38_0:setUIActive(true)

			arg_38_0._unitCamData.usePostProcess = (arg_38_1 == 2 or arg_38_1 == 4) and var_38_2 ~= SceneType.Room

			arg_38_0:setUIPPValue("bloomActive", false)
			arg_38_0:setUIPPValue("localMaskActive", arg_38_1 == 2 or arg_38_1 == 4)
			arg_38_0:setUIPPValue("LocalMaskActive", arg_38_1 == 2 or arg_38_1 == 4)
			arg_38_0:setFreezeVisble(true, arg_38_3)
			arg_38_0:setUIBlur(true, arg_38_1 == 3 or arg_38_1 == 4, arg_38_2)

			if arg_38_1 == 1 then
				TaskDispatcher.runDelay(arg_38_0.setFreezeVisbleBack, arg_38_0, 0)
			end
		end

		if arg_38_0._uiBloomActive then
			arg_38_0._uiCamData.usePostProcess = true

			arg_38_0:setUIPPValue("bloomActive", true)
			arg_38_0:setUIPPValue("localBloomActive", false)
		end
	end
end

function var_0_0.setFreezeVisbleBack(arg_39_0)
	arg_39_0:setFreezeVisble(false)
end

function var_0_0.setFreezeVisble(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = CameraMgr.instance:getMainCamera()
	local var_40_1 = CameraMgr.instance:getUICamera()

	if arg_40_1 == false then
		if arg_40_0._capture and not arg_40_0._capture:isCaptureComplete() then
			arg_40_1 = true
		end

		if not arg_40_0:IsGaussianFreezeStatus() then
			arg_40_1 = true
		end
	end

	arg_40_0._unitCamera.enabled = arg_40_1

	var_0_0.setCameraLayer(var_40_0, "UI3D", arg_40_1)
	var_0_0.setCameraLayer(var_40_0, "Scene", arg_40_1)
	var_0_0.setCameraLayer(var_40_0, "SceneOpaque", arg_40_1)
	var_0_0.setCameraLayer(var_40_1, "UI", arg_40_1 and not arg_40_2)
end

function var_0_0.setCameraLayer(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = arg_41_0.cullingMask
	local var_41_1 = LayerMask.GetMask(arg_41_1)

	var_0_0.setCameraLayerInt(arg_41_0, var_41_1, arg_41_2)
end

function var_0_0.setCameraLayerInt(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = arg_42_0.cullingMask

	if arg_42_2 then
		var_42_0 = bit.bor(var_42_0, arg_42_1)
	else
		var_42_0 = bit.band(var_42_0, bit.bnot(arg_42_1))
	end

	arg_42_0.cullingMask = var_42_0
end

function var_0_0.getUnitPPValue(arg_43_0, arg_43_1)
	if arg_43_0._unitPPVolume then
		return arg_43_0._unitPPVolume[arg_43_1]
	end
end

function var_0_0.setUnitPPValue(arg_44_0, arg_44_1, arg_44_2)
	if arg_44_0._unitPPVolume then
		arg_44_0._unitPPVolume.refresh = true
		arg_44_0._unitPPVolume[arg_44_1] = arg_44_2
	end
end

function var_0_0.setLocalBloomColor(arg_45_0, arg_45_1)
	arg_45_0:setUnitPPValue("localBloomColor", arg_45_1)
end

function var_0_0.getLocalBloomColor(arg_46_0)
	if arg_46_0._unitPPVolume then
		return arg_46_0._unitPPVolume.localBloomColor
	end
end

function var_0_0.setLocalBloomActive(arg_47_0, arg_47_1)
	arg_47_0:setUnitPPValue("localBloomActive", arg_47_1)
end

function var_0_0.getFlickerSceneFactor(arg_48_0)
	if arg_48_0._unitPPVolume then
		return arg_48_0._unitPPVolume.flickerSceneFactor
	end
end

function var_0_0.setFlickerSceneFactor(arg_49_0, arg_49_1)
	arg_49_0:setUnitPPValue("flickerSceneFactor", arg_49_1)
end

function var_0_0.getUIPPValue(arg_50_0, arg_50_1)
	if arg_50_0._uiPPVolume then
		return arg_50_0._uiPPVolume[arg_50_1]
	end
end

function var_0_0.setUIPPValue(arg_51_0, arg_51_1, arg_51_2)
	if arg_51_0._uiPPVolume then
		arg_51_0._uiPPVolume.refresh = true
		arg_51_0._uiPPVolume[arg_51_1] = arg_51_2

		arg_51_0._uiPPVolume:UpdateImmediately()
	end
end

function var_0_0._onEnterScene(arg_52_0, arg_52_1, arg_52_2)
	if arg_52_0:IsGaussianFreezeStatus() then
		arg_52_0:setUIBlurActive(1)
	end

	arg_52_0:setPPMaskType(arg_52_1 ~= SceneType.Fight)
end

function var_0_0.setRenderShadow(arg_53_0, arg_53_1)
	arg_53_0._mainCamData.renderShadow = arg_53_1
end

function var_0_0.setLayerCullDistance(arg_54_0, arg_54_1, arg_54_2)
	arg_54_0._mainCamData:SetCullLayerDistance(arg_54_1, arg_54_2)
end

function var_0_0.clearLayerCullDistance(arg_55_0)
	arg_55_0._mainCamData:ClearCullLayer()
end

function var_0_0.setPPMaskType(arg_56_0, arg_56_1)
	arg_56_0:setUnitPPValue("rolesStoryMaskActive", arg_56_1)
	arg_56_0:setUnitPPValue("RolesStoryMaskActive", arg_56_1)
	arg_56_0:setUnitPPValue("rgbSplitStrength", 0)
	arg_56_0:setUnitPPValue("RgbSplitStrength", 0)
	arg_56_0:setUnitPPValue("radialBlurLevel", 1)
	arg_56_0:setUnitPPValue("RadialBlurLevel", 1)
	arg_56_0:setUnitPPValue("dofFactor", 0)
	arg_56_0:setUnitPPValue("DofFactor", 0)
end

function var_0_0.setMainPPLevel(arg_57_0, arg_57_1)
	arg_57_0._ppGrade = arg_57_1

	local var_57_0 = arg_57_0:getProfile()

	arg_57_0._unitPPVolume:SetProfile(var_57_0)
end

function var_0_0.getProfile(arg_58_0)
	local var_58_0 = arg_58_0._ppGrade
	local var_58_1 = arg_58_0._highProfile

	if var_58_0 == ModuleEnum.Performance.High then
		var_58_1 = arg_58_0._highProfile
	elseif var_58_0 == ModuleEnum.Performance.Middle then
		var_58_1 = arg_58_0._middleProfile
	elseif var_58_0 == ModuleEnum.Performance.Low then
		var_58_1 = arg_58_0._lowProfile
	end

	return var_58_1
end

function var_0_0.ClearPPRenderRts(arg_59_0)
	return
end

var_0_0.instance = var_0_0.New()

return var_0_0
