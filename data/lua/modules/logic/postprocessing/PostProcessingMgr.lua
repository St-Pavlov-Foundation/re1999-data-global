module("modules.logic.postprocessing.PostProcessingMgr", package.seeall)

slot0 = class("PostProcessingMgr")
slot0.PPEffectMaskType = typeof(UrpCustom.PPEffectMask)
slot0.PPCustomCamDataType = typeof(UrpCustom.CustomCameraData)
slot0.PPVolumeType = typeof(UnityEngine.Rendering.Volume)
slot0.PPVolumeWrapType = typeof(UrpCustom.PPVolumeWrap)
slot0.MainHighProfilePath = "ppassets/profiles/main_profile_high.asset"
slot0.MainMiddleProfilePath = "ppassets/profiles/main_profile_middle.asset"
slot0.MainLowProfilePath = "ppassets/profiles/main_profile_low.asset"
slot0.CaptureResPath = "ppassets/capture.prefab"
slot0.DesamplingRate = {
	x8 = 8,
	x4 = 4,
	x1 = 1,
	x2 = 2
}
slot0.BlurMode = {
	FastBlur = 0,
	DetailBlur = 2,
	None = 3,
	MediumBlur = 1
}

function slot0.init(slot0, slot1, slot2, slot3)
	slot0._mainCameraGo = slot1
	slot0._mainCamera = slot1:GetComponent("Camera")
	slot0._mainCamData = slot1:GetComponent(uv0.PPCustomCamDataType)
	slot0._unitCameraGo = slot2
	slot0._unitCamera = slot2:GetComponent("Camera")
	slot0._uiCameraGo = slot3
	slot0._uiCamera = slot3:GetComponent("Camera")
	slot0._isUIActive = false
	slot0._isStoryUIActive = false
	slot0.useMirrorEffect = slot0._mainCamData.useMirrorEffect
	slot0._unitCamData = slot0._unitCameraGo:GetComponent(uv0.PPCustomCamDataType)
	slot0._unitPPVolume = gohelper.findChildComponent(slot0._unitCameraGo, "PPVolume", uv0.PPVolumeWrapType)
	slot0._highProfile = ConstAbCache.instance:getRes(uv0.MainHighProfilePath)
	slot0._middleProfile = ConstAbCache.instance:getRes(uv0.MainMiddleProfilePath)
	slot0._lowProfile = ConstAbCache.instance:getRes(uv0.MainLowProfilePath)
	slot0._uiCamData = slot0._uiCameraGo:GetComponent(uv0.PPCustomCamDataType)
	slot0._uiPPVolume = gohelper.findChildComponent(slot0._uiCameraGo, "PPUIVolume", uv0.PPVolumeWrapType)

	ViewMgr.instance:registerCallback(ViewEvent.ReOpenWhileOpen, slot0._reopenWhileOpen, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenFinishView, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)

	slot4 = gohelper.clone(ConstAbCache.instance:getRes(uv0.CaptureResPath), gohelper.find("UIRoot/POPUP_TOP"), "CaptureView")
	slot0._capture = slot4:GetComponent(typeof(UrpCustom.UIGaussianEffect))
	slot0._captureView = slot4

	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, slot0._onEnterScene, slot0)

	slot0._closeRefreshViewBlurDict = {}
	slot0._viewNameBlurDict = {}
	slot0._fullViewCanBlur = {
		[ViewName.DungeonMapView] = true
	}
end

function slot0.getCaptureView(slot0)
	return slot0._captureView
end

function slot0.setViewBlur(slot0, slot1, slot2)
	slot0._viewNameBlurDict[slot1] = slot2
end

function slot0._getViewBlur(slot0, slot1)
	if slot0._viewNameBlurDict[slot1] then
		return slot0._viewNameBlurDict[slot1]
	end

	return ViewMgr.instance:getSetting(slot1).bgBlur
end

function slot0._reopenWhileOpen(slot0, slot1)
	slot0:_refreshPopUpBlur(slot1, true, true, ViewEvent.OnOpenView)
	slot0:_refreshViewBlur(ViewEvent.ReOpenWhileOpen)
	slot0:_adjustMask(slot1)
end

function slot0._onOpenView(slot0, slot1)
	if slot1 == "LoginView" or slot1 == "SimulateLoginView" then
		slot0:setUnitActive(false)
	else
		slot0:_refreshPopUpBlur(slot1, true, false, ViewEvent.OnOpenView)
		slot0:_refreshViewBlur(ViewEvent.OnOpenView)
		slot0:_adjustMask(slot1)
	end
end

function slot0._onScreenResize(slot0)
	slot0:_refreshViewBlur()
end

function slot0._adjustMask(slot0, slot1, slot2)
	slot3 = ViewMgr.instance:getOpenViewNameList()

	for slot8 = #ViewMgr.instance:getOpenViewNameList(), 1, -1 do
		if ViewMgr.instance:isModal(slot4[slot8]) then
			if not slot2 or ViewMgr.instance:isOpenFinish(slot9) then
				ViewModalMaskMgr.instance:_adjustMask(slot9)

				return
			end
		elseif ViewMgr.instance:isFull(slot9) then
			return
		end
	end
end

function slot0._onOpenFinishView(slot0, slot1)
	if slot1 == ViewName.MessageBoxView and StoryController.instance._curStoryId == 100717 then
		return
	end

	if slot1 == "LoginView" or slot1 == "SimulateLoginView" then
		slot0:setUnitActive(false)
	else
		slot0:_refreshViewBlur(ViewEvent.OnOpenViewFinish)
	end
end

function slot0._onCloseView(slot0, slot1)
	slot0:_refreshPopUpBlur(slot1, false, false, ViewEvent.OnCloseView)
	slot0:_closeRefreshViewBlur(ViewEvent.OnCloseView, slot1)
	slot0:_adjustMask(slot1, true)
end

function slot0._onCloseViewFinish(slot0, slot1)
	slot0:_refreshPopUpBlur(slot1, false, false, ViewEvent.OnCloseViewFinish)
	slot0:_closeRefreshViewBlur(ViewEvent.OnCloseViewFinish, slot1)
	slot0:_adjustMask(slot1, true)
end

function slot0.setCloseSkipRefreshBlur(slot0, slot1, slot2)
	slot0._closeRefreshViewBlurDict[slot1] = slot2
end

function slot0.forceRefreshCloseBlur(slot0)
	slot0:_refreshViewBlur(ViewEvent.OnCloseViewFinish)
end

function slot0._closeRefreshViewBlur(slot0, slot1, slot2)
	if slot0._closeRefreshViewBlurDict[slot2] then
		if slot1 == ViewEvent.OnCloseViewFinish then
			slot0._closeRefreshViewBlurDict[slot2] = nil
		end

		return
	end

	slot0:_refreshViewBlur(slot1)
end

function slot0._refreshViewBlur(slot0, slot1)
	slot2, slot3, slot4, slot5 = slot0:_judgeBlur()

	slot0:setUIBlurActive(slot2 or 0, slot4, slot5, slot1)
end

function slot0._refreshFreezeBlur(slot0)
	slot1, slot2, slot3, slot4 = slot0:_judgeBlur()

	slot0:setUIBlurActive(2, slot3, slot4)
end

function slot0._judgeBlur(slot0)
	for slot5 = #ViewMgr.instance:getOpenViewNameList(), 1, -1 do
		if ViewMgr.instance:getSetting(slot1[slot5]).layer == UILayerName.PopUp then
			return false
		end

		if slot0:_getViewBlur(slot6) and slot8 > 0 then
			return slot8, slot6, {
				blurMode = slot7.blurMode,
				blurFactor = slot7.blurFactor,
				desampleRate = slot7.desampleRate,
				reduceRate = slot7.reduceRate,
				blurIterations = slot7.blurIterations
			}, slot7.hideUI
		end

		if slot7.viewType == ViewType.Full then
			return false
		end
	end

	return false
end

function slot0._refreshPopUpBlur(slot0, slot1, slot2, slot3, slot4)
	slot5 = ViewMgr.instance:getOpenViewNameList()
	slot6, slot7 = slot0:_judgeBlur()

	if slot6 then
		slot0:_refreshPopUpBlurIsBlur(slot1, slot2, slot7)
	else
		slot0:_refreshPopUpBlurNotBlur(slot1, slot2)
	end
end

function slot0._refreshPopUpBlurIsBlur(slot0, slot1, slot2, slot3)
	slot5 = gohelper.findChild(ViewMgr.instance:getUIRoot(), "POPUPBlur")
	slot6 = gohelper.findChild(ViewMgr.instance:getTopUIRoot(), "POPUP_TOP")
	slot7 = 1
	slot8 = nil
	slot9 = false

	for slot13 = 1, #ViewMgr.instance:getOpenViewNameList() do
		if slot4[slot13] == slot3 then
			slot9 = true
		end

		if ViewMgr.instance:getSetting(slot14).layer == "POPUP_TOP" then
			slot16 = (slot14 == slot3 or slot9) and slot6 or slot5

			if (ViewMgr.instance:getContainer(slot14).viewGO and slot17.transform.parent or nil) == slot6.transform or slot18 == slot5.transform then
				if slot0:_isKeepTop(slot13, slot4, slot3) then
					slot16 = slot6
				end

				gohelper.addChild(slot16, slot17)
				slot0:_setChildCanvasLayer(slot17, slot16 == slot6 and UnityLayer.UITop or UnityLayer.UIThird, false)

				if slot16 == slot6 then
					slot8 = slot17

					gohelper.setSibling(slot17, slot7)

					slot7 = slot7 + 1
				else
					gohelper.setAsLastSibling(slot17)
				end
			end
		end
	end

	if slot8 then
		gohelper.setAsLastSibling(slot8)
	end
end

function slot0._isKeepTop(slot0, slot1, slot2, slot3)
	slot5 = slot2[slot1 + 1]

	if ViewMgr.instance:getContainer(slot2[slot1]) and (string.find(slot4, "HeroGroupFightView") or isTypeOf(slot6, HeroGroupFightViewContainer)) and slot5 == ViewName.HeroGroupCareerTipView then
		return true
	end

	if slot4 == ViewName.RoomInitBuildingView and slot5 == ViewName.RoomFormulaView and slot3 == ViewName.RoomFormulaView then
		return true
	end

	return false
end

function slot0._refreshPopUpBlurNotBlur(slot0, slot1, slot2)
	slot5 = gohelper.findChild(ViewMgr.instance:getTopUIRoot(), "POPUP_TOP")
	slot6 = 1
	slot7 = nil

	for slot11 = 1, #ViewMgr.instance:getOpenViewNameList() do
		if ViewMgr.instance:getSetting(slot3[slot11]).layer == "POPUP_TOP" and ((ViewMgr.instance:getContainer(slot12).viewGO and slot14.transform.parent or nil) == slot5.transform or slot15 == gohelper.findChild(ViewMgr.instance:getUIRoot(), "POPUPBlur").transform) then
			gohelper.addChild(slot5, slot14)
			slot0:_setChildCanvasLayer(slot14, UnityLayer.UITop, false)

			slot7 = slot14

			gohelper.setSibling(slot14, slot6)

			slot6 = slot6 + 1
		end
	end

	if slot7 and slot2 then
		gohelper.setAsLastSibling(slot7)
	end
end

function slot0._setChildCanvasLayer(slot0, slot1, slot2, slot3)
	if not slot1 then
		return
	end

	if slot1:GetComponentsInChildren(typeof(UnityEngine.Canvas), true) then
		slot5 = slot4:GetEnumerator()

		while slot5:MoveNext() do
			if not LuaUtil.strEndswith(slot5.Current.gameObject.name, "_uicanvas") then
				gohelper.setLayer(slot5.Current.gameObject, slot2, slot3)
			end
		end
	end
end

function slot0._isBlurView(slot0, slot1)
	if ViewMgr.instance:getSetting(slot1) and slot2.bgBlur and slot2.bgBlur > 0 then
		return true
	end

	return false
end

function slot0._hasBlurViewOpened(slot0)
	for slot5, slot6 in ipairs(ViewMgr.instance:getOpenViewNameList()) do
		if slot0:_isBlurView(slot6) then
			return true
		end
	end

	return false
end

function slot0.setUIActive(slot0, slot1, slot2)
	if slot2 then
		slot0._isStoryUIActive = slot1
	else
		slot0._isUIActive = slot1
	end

	slot0._uiCamData.usePostProcess = slot0._isUIActive or slot0._isStoryUIActive
end

function slot0.setUnitActive(slot0, slot1)
	slot0._unitCamData.usePostProcess = slot1
end

function slot0.setUIBlur(slot0, slot1, slot2, slot3)
	slot9 = GameSceneMgr.instance:getCurSceneType()

	if slot1 then
		slot0:setBlurMode(slot3 and slot3.blurMode or uv0.BlurMode.MediumBlur)
		slot0:setDesamplingRate(slot2 and uv0.DesamplingRate.x1 or uv0.DesamplingRate.x8)
		slot0:setDesamplingRate(slot3 and slot3.desampleRate or uv0.DesamplingRate.x8)
		slot0:setBlurIterations(slot3 and slot3.blurIterations or 3)
		slot0:setReduceRate(slot3 and slot3.reduceRate or uv0.DesamplingRate.x4)
		slot0:setBlurFactor(slot3 and slot3.blurFactor or 0.4)
		slot0._capture:SetKeepCapture(slot2)

		if not slot2 then
			slot0:setBlurWeight(1)
			slot0._capture:Capture()
		end
	end

	slot0._capture.enabled = slot1
end

function slot0.IsGaussianFreezeStatus(slot0)
	return slot0._capture.enabled and not slot0._capture.keepToScreen
end

function slot0.setBlurMode(slot0, slot1)
	slot0._capture:SetBlurMode(slot1)
end

function slot0.setBlurFactor(slot0, slot1)
	slot0._capture.blurFactor = math.max(0, math.min(1, slot1))
end

function slot0.setBlurWeight(slot0, slot1)
	if not slot0:IsGaussianFreezeStatus() then
		slot0._capture.blurWeight = math.max(0, math.min(1, slot1))
	end
end

function slot0.setDesamplingRate(slot0, slot1)
	slot0._capture.desamplingRate = slot1
end

function slot0.setReduceRate(slot0, slot1)
	slot0._capture.reduteRate = slot1
end

function slot0.setBlurIterations(slot0, slot1)
	slot0._capture.blurIterations = slot1
end

function slot0.setUIBloom(slot0, slot1)
	slot0._uiBloomActive = slot1
end

function slot0.setUIBlurActive(slot0, slot1, slot2, slot3, slot4)
	if slot0._uiCamData and slot0._unitCamData and slot0._capture then
		slot5 = CameraMgr.instance:getMainCamera()
		slot6 = CameraMgr.instance:getUICamera()
		slot7 = GameSceneMgr.instance:getCurSceneType()

		if slot1 == false or slot1 == 0 then
			if slot4 ~= ViewEvent.OnCloseView then
				slot0:setUIActive(false)
			end

			slot0._unitCamData.usePostProcess = slot7 ~= SceneType.Room

			slot0:setUIPPValue("bloomActive", false)
			slot0:setUIPPValue("localMaskActive", false)
			slot0:setUIPPValue("LocalMaskActive", false)
			slot0:setFreezeVisble(true)
			slot0:setUIBlur(false)
		else
			slot0:setUIActive(true)

			slot0._unitCamData.usePostProcess = (slot1 == 2 or slot1 == 4) and slot7 ~= SceneType.Room

			slot0:setUIPPValue("bloomActive", false)
			slot0:setUIPPValue("localMaskActive", slot1 == 2 or slot1 == 4)
			slot0:setUIPPValue("LocalMaskActive", slot1 == 2 or slot1 == 4)
			slot0:setFreezeVisble(true, slot3)
			slot0:setUIBlur(true, slot1 == 3 or slot1 == 4, slot2)

			if slot1 == 1 then
				TaskDispatcher.runDelay(slot0.setFreezeVisbleBack, slot0, 0)
			end
		end

		if slot0._uiBloomActive then
			slot0._uiCamData.usePostProcess = true

			slot0:setUIPPValue("bloomActive", true)
			slot0:setUIPPValue("localBloomActive", false)
		end
	end
end

function slot0.setFreezeVisbleBack(slot0)
	slot0:setFreezeVisble(false)
end

function slot0.setFreezeVisble(slot0, slot1, slot2)
	slot3 = CameraMgr.instance:getMainCamera()
	slot4 = CameraMgr.instance:getUICamera()

	if slot1 == false then
		if slot0._capture and not slot0._capture:isCaptureComplete() then
			slot1 = true
		end

		if not slot0:IsGaussianFreezeStatus() then
			slot1 = true
		end
	end

	slot0._unitCamera.enabled = slot1

	uv0.setCameraLayer(slot3, "UI3D", slot1)
	uv0.setCameraLayer(slot3, "Scene", slot1)
	uv0.setCameraLayer(slot3, "SceneOpaque", slot1)
	uv0.setCameraLayer(slot4, "UI", slot1 and not slot2)
end

function slot0.setCameraLayer(slot0, slot1, slot2)
	slot3 = slot0.cullingMask

	uv0.setCameraLayerInt(slot0, LayerMask.GetMask(slot1), slot2)
end

function slot0.setCameraLayerInt(slot0, slot1, slot2)
	slot3 = slot0.cullingMask
	slot0.cullingMask = (not slot2 or bit.bor(slot3, slot1)) and bit.band(slot3, bit.bnot(slot1))
end

function slot0.getUnitPPValue(slot0, slot1)
	if slot0._unitPPVolume then
		return slot0._unitPPVolume[slot1]
	end
end

function slot0.setUnitPPValue(slot0, slot1, slot2)
	if slot0._unitPPVolume then
		slot0._unitPPVolume.refresh = true
		slot0._unitPPVolume[slot1] = slot2
	end
end

function slot0.setLocalBloomColor(slot0, slot1)
	slot0:setUnitPPValue("localBloomColor", slot1)
end

function slot0.getLocalBloomColor(slot0)
	if slot0._unitPPVolume then
		return slot0._unitPPVolume.localBloomColor
	end
end

function slot0.setLocalBloomActive(slot0, slot1)
	slot0:setUnitPPValue("localBloomActive", slot1)
end

function slot0.getFlickerSceneFactor(slot0)
	if slot0._unitPPVolume then
		return slot0._unitPPVolume.flickerSceneFactor
	end
end

function slot0.setFlickerSceneFactor(slot0, slot1)
	slot0:setUnitPPValue("flickerSceneFactor", slot1)
end

function slot0.getUIPPValue(slot0, slot1)
	if slot0._uiPPVolume then
		return slot0._uiPPVolume[slot1]
	end
end

function slot0.setUIPPValue(slot0, slot1, slot2)
	if slot0._uiPPVolume then
		slot0._uiPPVolume.refresh = true
		slot0._uiPPVolume[slot1] = slot2

		slot0._uiPPVolume:UpdateImmediately()
	end
end

function slot0._onEnterScene(slot0, slot1, slot2)
	if slot0:IsGaussianFreezeStatus() then
		slot0:setUIBlurActive(1)
	end

	slot0:setPPMaskType(slot1 ~= SceneType.Fight)
end

function slot0.setRenderShadow(slot0, slot1)
	slot0._mainCamData.renderShadow = slot1
end

function slot0.setLayerCullDistance(slot0, slot1, slot2)
	slot0._mainCamData:SetCullLayerDistance(slot1, slot2)
end

function slot0.clearLayerCullDistance(slot0)
	slot0._mainCamData:ClearCullLayer()
end

function slot0.setPPMaskType(slot0, slot1)
	slot0:setUnitPPValue("rolesStoryMaskActive", slot1)
	slot0:setUnitPPValue("RolesStoryMaskActive", slot1)
	slot0:setUnitPPValue("rgbSplitStrength", 0)
	slot0:setUnitPPValue("RgbSplitStrength", 0)
	slot0:setUnitPPValue("radialBlurLevel", 1)
	slot0:setUnitPPValue("RadialBlurLevel", 1)
	slot0:setUnitPPValue("dofFactor", 0)
	slot0:setUnitPPValue("DofFactor", 0)
end

function slot0.setMainPPLevel(slot0, slot1)
	slot2 = slot0._highProfile

	if slot1 == ModuleEnum.Performance.High then
		slot2 = slot0._highProfile
	elseif slot1 == ModuleEnum.Performance.Middle then
		slot2 = slot0._middleProfile
	elseif slot1 == ModuleEnum.Performance.Low then
		slot2 = slot0._lowProfile
	end

	slot0._unitPPVolume:SetProfile(slot2)
end

function slot0.ClearPPRenderRts(slot0)
end

slot0.instance = slot0.New()

return slot0
