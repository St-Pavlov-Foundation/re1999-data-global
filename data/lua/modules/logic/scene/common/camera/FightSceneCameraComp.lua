module("modules.logic.scene.common.camera.FightSceneCameraComp", package.seeall)

slot0 = class("FightSceneCameraComp", BaseSceneComp)

function slot0.onInit(slot0)
	slot0._scene = slot0:getCurScene()
	slot0._cameraTrace = CameraMgr.instance:getCameraTrace()
	slot0._curVirtualCameraSetId = nil
end

function slot0.onSceneStart(slot0, slot1, slot2)
	FightController.instance:registerCallback(FightEvent.FightRoundStart, slot0._onFightRoundStart, slot0)
	FightController.instance:registerCallback(FightEvent.OnRestartStageBefore, slot0._onRestartStageBefore, slot0)
	FightController.instance:registerCallback(FightEvent.OnMySideRoundEnd, slot0._onMySideRoundEnd, slot0)

	if CameraMgr.instance:hasCameraRootAnimatorPlayer() then
		CameraMgr.instance:getCameraRootAnimatorPlayer():Stop()
	end

	transformhelper.setPos(CameraMgr.instance:getCameraRootGO().transform, 0, 0, 0)
	transformhelper.setPos(CameraMgr.instance:getCameraTraceGO().transform, 0, 0, 0)

	CameraMgr.instance:getMainCamera().orthographic = false
	slot0._cameraTrace.EnableTrace = false
	slot6 = CameraMgr.instance:getCameraTraceGO().transform

	transformhelper.setLocalPos(slot6, 0, 0, 0)
	transformhelper.setLocalRotation(slot6, 0, 0, 0)
	CameraMgr.instance:getCameraTrace():DisableTraceWithFixedParam()

	slot7 = CameraMgr.instance:getVirtualCameraGO()

	gohelper.setActive(slot7, true)
	gohelper.setActive(gohelper.findChild(slot7, "light"), true)
	TaskDispatcher.runDelay(slot0._delaySetUnitCameraFov, slot0, 0.01)
	slot0:setSceneCameraOffset()

	slot0._curVirtualCameraSetId = nil

	slot0:switchNextVirtualCamera()

	if not slot0._hasRecord then
		slot0._hasRecord = true

		slot0:recordParam()
	end

	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
	slot0:_onScreenResize(UnityEngine.Screen.width, UnityEngine.Screen.height)
end

function slot0.onSceneClose(slot0)
	slot0._myTurnOffset = nil

	FightController.instance:unregisterCallback(FightEvent.OnRestartStageBefore, slot0._onRestartStageBefore, slot0)
	FightController.instance:unregisterCallback(FightEvent.FightRoundStart, slot0._onFightRoundStart, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnMySideRoundEnd, slot0._onMySideRoundEnd, slot0)
	TaskDispatcher.cancelTask(slot0._delaySetUnitCameraFov, slot0)
	TaskDispatcher.cancelTask(slot0._resetParam, slot0)
	slot0:resetCameraOffset()
	slot0:resetParam()
	slot0:enablePostProcessSmooth(false)

	CameraMgr.instance:getCameraRootAnimator().speed = 1

	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
	TaskDispatcher.cancelTask(slot0.disableClearSlot, slot0)
	TaskDispatcher.cancelTask(slot0._delayDisableSmooth, slot0)
	slot0:disableClearSlot()
	slot0:_delayDisableSmooth()
end

function slot0.getCurActiveVirtualCame(slot0)
	if not slot0:getCurVirtualCamera(1).gameObject.activeInHierarchy then
		slot1 = slot0:getCurVirtualCamera(2)
	end

	return slot1
end

function slot0.enableClearSlot(slot0, slot1)
	slot0:disableClearSlot()

	slot3 = gohelper.findChild(CameraMgr.instance:getVirtualCameraGO(), "clearslot")
	slot0._clearSlotVC = slot0:getCurActiveVirtualCame()

	if not slot0._clearSlotVC then
		return
	end

	slot0._clearSlotParentGO = slot0._clearSlotVC.transform.parent.gameObject
	slot0._tempClearSlotGO = gohelper.clone(slot3, slot0._clearSlotParentGO, "ClearSlot")
	slot0._resumeDelay = slot1

	gohelper.addChild(slot0._tempClearSlotGO, slot0._clearSlotVC.gameObject)
	gohelper.setActive(slot0._tempClearSlotGO, false)
	TaskDispatcher.runDelay(slot0._delayActiveClearSlot, slot0, 0.01)
end

function slot0._delayActiveClearSlot(slot0)
	gohelper.setActive(slot0._tempClearSlotGO, true)

	if slot0._resumeDelay then
		TaskDispatcher.runDelay(slot0.disableClearSlot, slot0, slot0._resumeDelay)

		slot0._resumeDelay = nil
	end
end

function slot0.disableClearSlot(slot0)
	if slot0._tempClearSlotGO then
		gohelper.addChild(slot0._clearSlotParentGO, slot0._clearSlotVC.gameObject)
		gohelper.destroy(slot0._tempClearSlotGO)

		slot0._clearSlotVC = nil
		slot0._tempClearSlotGO = nil
		slot0._clearSlotParentGO = nil
	end
end

function slot0.getCurVirtualCamera(slot0, slot1)
	return CameraMgr.instance:getVirtualCamera(slot0._curVirtualCameraSetId or 1, slot1)
end

function slot0.switchNextVirtualCamera(slot0)
	if not slot0._curVirtualCameraSetId then
		slot0._curVirtualCameraSetId = 1
	elseif slot0._curVirtualCameraSetId == 1 then
		slot0._curVirtualCameraSetId = 2
	elseif slot0._curVirtualCameraSetId == 2 then
		slot0._curVirtualCameraSetId = 1
	end

	CameraMgr.instance:switchVirtualCamera(slot0._curVirtualCameraSetId)
end

function slot0.enablePostProcessSmooth(slot0, slot1)
	if not slot0._dofSmoothComp then
		if gohelper.findChild(CameraMgr.instance:getCameraRootGO(), "main/MainCamera/unitcamera/PPVolume") then
			slot0._dofSmoothComp = gohelper.onceAddComponent(slot3, typeof(ZProj.DepthOfFieldSmooth))
			slot0._dofSmoothComp.maxOffset = 0.1
			slot0._dofSmoothComp.frameRatio = 0.02
		else
			logError("add smooth comp fail, PPVolume not exist")
		end
	end

	if slot0._dofSmoothComp then
		slot0._dofSmoothComp.enabled = slot1
	end

	if not slot0._lightColorSmoothComp then
		if gohelper.findChild(slot2, "main/VirtualCameras/light/direct") then
			slot0._lightColorSmoothComp = gohelper.onceAddComponent(slot3, typeof(ZProj.LightColorSmooth))
			slot0._lightColorSmoothComp.maxOffset = 0.1
			slot0._lightColorSmoothComp.frameRatio = 0.02
		else
			logError("add smooth comp fail, DirectLight not exist")
		end
	end

	if slot0._lightColorSmoothComp then
		slot0._lightColorSmoothComp.enabled = slot1

		if slot1 then
			TaskDispatcher.runDelay(slot0._delayDisableSmooth, slot0, 0.2)
		end
	end
end

function slot0._delayDisableSmooth(slot0)
	slot0._lightColorSmoothComp.enabled = false
end

function slot0.recordParam(slot0)
	slot0._lightColor = gohelper.findChildComponent(CameraMgr.instance:getCameraRootGO(), "main/VirtualCameras/light/direct", typeof(UnityEngine.Light)).color
	slot0._distortionRange = PostProcessingMgr.instance:getUnitPPValue("distortionRange")
	slot0._dofDistance = PostProcessingMgr.instance:getUnitPPValue("dofDistance")
	slot0._dofFactor = PostProcessingMgr.instance:getUnitPPValue("dofFactor")
	slot0._dofFarBlur = PostProcessingMgr.instance:getUnitPPValue("dofFarBlur")
	slot0._dofLength = PostProcessingMgr.instance:getUnitPPValue("dofLength")
	slot0._dofNearBlur = PostProcessingMgr.instance:getUnitPPValue("dofNearBlur")
	slot0._isDistortion = PostProcessingMgr.instance:getUnitPPValue("isDistortion")
	slot0._rgbSplitCenter = PostProcessingMgr.instance:getUnitPPValue("rgbSplitCenter")
	slot3 = CameraMgr.instance:getVirtualCamera(1, 1)
	slot4 = ZProj.VirtualCameraWrap.Get(slot3.gameObject).body
	slot0._pathOffset = slot4.m_PathOffset
	slot0._pathPosition = slot4.m_PathPosition
	slot0._xDamping = slot4.m_XDamping
	slot0._yDamping = slot4.m_YDamping
	slot0._zDamping = slot4.m_ZDamping
	slot0._followerPos = gohelper.findChild(slot3.transform.parent.gameObject, "Follower" .. string.sub(slot3.name, string.len(slot3.name))).transform.localPosition
	slot0._vcamPos = slot3.transform.parent.gameObject.transform.localPosition
end

function slot0.resetParam(slot0)
	gohelper.findChildComponent(CameraMgr.instance:getCameraRootGO(), "main/VirtualCameras/light/direct", typeof(UnityEngine.Light)).color = slot0._lightColor

	PostProcessingMgr.instance:setUnitPPValue("distortionRange", slot0._distortionRange)
	PostProcessingMgr.instance:setUnitPPValue("DistortionRange", slot0._distortionRange)
	PostProcessingMgr.instance:setUnitPPValue("dofDistance", slot0._dofDistance)
	PostProcessingMgr.instance:setUnitPPValue("DofDistance", slot0._dofDistance)
	PostProcessingMgr.instance:setUnitPPValue("dofFactor", slot0._dofFactor)
	PostProcessingMgr.instance:setUnitPPValue("DofFactor", slot0._dofFactor)
	PostProcessingMgr.instance:setUnitPPValue("dofFarBlur", slot0._dofFarBlur)
	PostProcessingMgr.instance:setUnitPPValue("DofFarBlur", slot0._dofFarBlur)
	PostProcessingMgr.instance:setUnitPPValue("dofLength", slot0._dofLength)
	PostProcessingMgr.instance:setUnitPPValue("DofLength", slot0._dofLength)
	PostProcessingMgr.instance:setUnitPPValue("dofNearBlur", slot0._dofNearBlur)
	PostProcessingMgr.instance:setUnitPPValue("DofNearBlur", slot0._dofNearBlur)
	PostProcessingMgr.instance:setUnitPPValue("isDistortion", slot0._isDistortion)
	PostProcessingMgr.instance:setUnitPPValue("IsDistortion", slot0._isDistortion)
	PostProcessingMgr.instance:setUnitPPValue("rgbSplitCenter", slot0._rgbSplitCenter)
	PostProcessingMgr.instance:setUnitPPValue("RgbSplitCenter", slot0._rgbSplitCenter)

	slot0._mulColor = slot0._mulColor or Color.New(1, 1, 1, 1)
	slot0._keepColor = slot0._keepColor or Color.New(0, 0, 0, 1)

	PostProcessingMgr.instance:setUnitPPValue("flickerType", -1)
	PostProcessingMgr.instance:setUnitPPValue("FlickerType", -1)
	PostProcessingMgr.instance:setUnitPPValue("radialBlurLevel", 1)
	PostProcessingMgr.instance:setUnitPPValue("RadialBlurLevel", 1)
	PostProcessingMgr.instance:setUnitPPValue("rgbSplitStrength", 0)
	PostProcessingMgr.instance:setUnitPPValue("RgbSplitStrength", 0)
	PostProcessingMgr.instance:setUnitPPValue("saturation", 0.5)
	PostProcessingMgr.instance:setUnitPPValue("Saturation", 0.5)
	PostProcessingMgr.instance:setUnitPPValue("contrast", 0.5)
	PostProcessingMgr.instance:setUnitPPValue("Contrast", 0.5)
	PostProcessingMgr.instance:setUnitPPValue("mulColor", slot0._mulColor)
	PostProcessingMgr.instance:setUnitPPValue("MulColor", slot0._mulColor)
	PostProcessingMgr.instance:setUnitPPValue("keepColor", slot0._keepColor)
	PostProcessingMgr.instance:setUnitPPValue("KeepColor", slot0._keepColor)
	PostProcessingMgr.instance:setUnitPPValue("inverse", false)
	PostProcessingMgr.instance:setUnitPPValue("Inverse", false)
	PostProcessingMgr.instance:setUnitPPValue("colorSceOldMoviesActive", false)
	PostProcessingMgr.instance:setUnitPPValue("ColorSceOldMoviesActive", false)

	for slot7, slot8 in ipairs(CameraMgr.instance:getVirtualCameras()) do
		slot9 = ZProj.VirtualCameraWrap.Get(slot8.gameObject).body
		slot9.m_PathOffset = slot0._pathOffset
		slot9.m_PathPosition = slot0._pathPosition
		slot9.m_XDamping = slot0._xDamping
		slot9.m_YDamping = slot0._yDamping
		slot9.m_ZDamping = slot0._zDamping
		gohelper.findChild(slot8.transform.parent.gameObject, "Follower" .. string.sub(slot8.name, string.len(slot8.name))).transform.localPosition = slot0._followerPos
		slot8.transform.parent.gameObject.transform.localPosition = slot0._vcamPos
	end
end

function slot0._delaySetUnitCameraFov(slot0)
	CameraMgr.instance:getUnitCamera().fieldOfView = CameraMgr.instance:getMainCamera().fieldOfView

	FightController.instance:dispatchEvent(FightEvent.OnCameraFovChange)
end

function slot0.setSceneCameraOffset(slot0)
	slot0:setCameraOffset(slot0:getDefaultCameraOffset())
end

function slot0.getDefaultCameraOffset(slot0)
	if slot0._myTurnOffset then
		return Vector3.New(slot0._myTurnOffset[1], slot0._myTurnOffset[2], slot0._myTurnOffset[3])
	end

	if not string.nilorempty(lua_scene_level.configDict[GameSceneMgr.instance:getCurLevelId()] and slot2.cameraOffset) then
		return Vector3(unpack(cjson.decode(slot3)))
	else
		return Vector3.New(0, 0, 0)
	end
end

function slot0.setCameraOffset(slot0, slot1)
	CameraMgr.instance:getVirtualCameraGO().transform.localPosition = slot1
end

function slot0.resetCameraOffset(slot0)
	CameraMgr.instance:getVirtualCameraGO().transform.localPosition = Vector3.zero
end

slot1 = 60
slot2 = 1.7777777777777777

function slot0._onScreenResize(slot0, slot1, slot2)
	slot10 = 60
	slot11 = 120

	for slot10, slot11 in ipairs(CameraMgr.instance:getVirtualCameras()) do
		slot12 = slot11.m_Lens
		slot11.m_Lens = Cinemachine.LensSettings.New(Mathf.Clamp(2 * Mathf.Atan(Mathf.Tan(uv1 * Mathf.Deg2Rad / 2) / (slot1 / slot2 / uv0)) * Mathf.Rad2Deg, slot10, slot11), slot12.OrthographicSize, slot12.NearClipPlane, slot12.FarClipPlane, slot12.Dutch)
	end

	TaskDispatcher.runDelay(slot0._delaySetUnitCameraFov, slot0, 0.01)
end

function slot0._onFightRoundStart(slot0)
	if lua_fight_camera_player_turn_offset.configDict[GameSceneMgr.instance:getCurLevelId()] then
		slot0._myTurnOffset = slot2.offset

		slot0:setSceneCameraOffset()
	else
		slot0._myTurnOffset = nil
	end
end

function slot0._onMySideRoundEnd(slot0)
	slot0._myTurnOffset = nil

	slot0:setSceneCameraOffset()
end

function slot0._onRestartStageBefore(slot0)
	slot0._myTurnOffset = nil
end

return slot0
