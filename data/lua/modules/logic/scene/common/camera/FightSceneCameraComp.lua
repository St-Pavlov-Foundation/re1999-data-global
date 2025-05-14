module("modules.logic.scene.common.camera.FightSceneCameraComp", package.seeall)

local var_0_0 = class("FightSceneCameraComp", BaseSceneComp)

function var_0_0.onInit(arg_1_0)
	arg_1_0._scene = arg_1_0:getCurScene()
	arg_1_0._cameraTrace = CameraMgr.instance:getCameraTrace()
	arg_1_0._curVirtualCameraSetId = nil
end

function var_0_0.onSceneStart(arg_2_0, arg_2_1, arg_2_2)
	FightController.instance:registerCallback(FightEvent.FightRoundStart, arg_2_0._onFightRoundStart, arg_2_0)
	FightController.instance:registerCallback(FightEvent.OnRestartStageBefore, arg_2_0._onRestartStageBefore, arg_2_0)
	FightController.instance:registerCallback(FightEvent.OnMySideRoundEnd, arg_2_0._onMySideRoundEnd, arg_2_0)

	if CameraMgr.instance:hasCameraRootAnimatorPlayer() then
		CameraMgr.instance:getCameraRootAnimatorPlayer():Stop()
	end

	local var_2_0 = CameraMgr.instance:getCameraRootGO()

	transformhelper.setPos(var_2_0.transform, 0, 0, 0)

	local var_2_1 = CameraMgr.instance:getCameraTraceGO()

	transformhelper.setPos(var_2_1.transform, 0, 0, 0)

	CameraMgr.instance:getMainCamera().orthographic = false
	arg_2_0._cameraTrace.EnableTrace = false

	local var_2_2 = CameraMgr.instance:getCameraTraceGO().transform

	transformhelper.setLocalPos(var_2_2, 0, 0, 0)
	transformhelper.setLocalRotation(var_2_2, 0, 0, 0)
	CameraMgr.instance:getCameraTrace():DisableTraceWithFixedParam()

	local var_2_3 = CameraMgr.instance:getVirtualCameraGO()

	gohelper.setActive(var_2_3, true)

	local var_2_4 = gohelper.findChild(var_2_3, "light")

	gohelper.setActive(var_2_4, true)
	TaskDispatcher.runDelay(arg_2_0._delaySetUnitCameraFov, arg_2_0, 0.01)
	arg_2_0:setSceneCameraOffset()

	arg_2_0._curVirtualCameraSetId = nil

	arg_2_0:switchNextVirtualCamera()

	if not arg_2_0._hasRecord then
		arg_2_0._hasRecord = true

		arg_2_0:recordParam()
	end

	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, arg_2_0._onScreenResize, arg_2_0)
	arg_2_0:_onScreenResize(UnityEngine.Screen.width, UnityEngine.Screen.height)
end

function var_0_0.onSceneClose(arg_3_0)
	arg_3_0._myTurnOffset = nil

	FightController.instance:unregisterCallback(FightEvent.OnRestartStageBefore, arg_3_0._onRestartStageBefore, arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.FightRoundStart, arg_3_0._onFightRoundStart, arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnMySideRoundEnd, arg_3_0._onMySideRoundEnd, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._delaySetUnitCameraFov, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._resetParam, arg_3_0)
	arg_3_0:resetCameraOffset()
	arg_3_0:resetParam()
	arg_3_0:enablePostProcessSmooth(false)

	CameraMgr.instance:getCameraRootAnimator().speed = 1

	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, arg_3_0._onScreenResize, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0.disableClearSlot, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._delayDisableSmooth, arg_3_0)
	arg_3_0:disableClearSlot()
	arg_3_0:_delayDisableSmooth()
end

function var_0_0.getCurActiveVirtualCame(arg_4_0)
	local var_4_0 = arg_4_0:getCurVirtualCamera(1)

	if not var_4_0.gameObject.activeInHierarchy then
		var_4_0 = arg_4_0:getCurVirtualCamera(2)
	end

	return var_4_0
end

function var_0_0.enableClearSlot(arg_5_0, arg_5_1)
	arg_5_0:disableClearSlot()

	local var_5_0 = CameraMgr.instance:getVirtualCameraGO()
	local var_5_1 = gohelper.findChild(var_5_0, "clearslot")

	arg_5_0._clearSlotVC = arg_5_0:getCurActiveVirtualCame()

	if not arg_5_0._clearSlotVC then
		return
	end

	arg_5_0._clearSlotParentGO = arg_5_0._clearSlotVC.transform.parent.gameObject
	arg_5_0._tempClearSlotGO = gohelper.clone(var_5_1, arg_5_0._clearSlotParentGO, "ClearSlot")
	arg_5_0._resumeDelay = arg_5_1

	gohelper.addChild(arg_5_0._tempClearSlotGO, arg_5_0._clearSlotVC.gameObject)
	gohelper.setActive(arg_5_0._tempClearSlotGO, false)
	TaskDispatcher.runDelay(arg_5_0._delayActiveClearSlot, arg_5_0, 0.01)
end

function var_0_0._delayActiveClearSlot(arg_6_0)
	gohelper.setActive(arg_6_0._tempClearSlotGO, true)

	if arg_6_0._resumeDelay then
		TaskDispatcher.runDelay(arg_6_0.disableClearSlot, arg_6_0, arg_6_0._resumeDelay)

		arg_6_0._resumeDelay = nil
	end
end

function var_0_0.disableClearSlot(arg_7_0)
	if arg_7_0._tempClearSlotGO then
		gohelper.addChild(arg_7_0._clearSlotParentGO, arg_7_0._clearSlotVC.gameObject)
		gohelper.destroy(arg_7_0._tempClearSlotGO)

		arg_7_0._clearSlotVC = nil
		arg_7_0._tempClearSlotGO = nil
		arg_7_0._clearSlotParentGO = nil
	end
end

function var_0_0.getCurVirtualCamera(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._curVirtualCameraSetId or 1

	return CameraMgr.instance:getVirtualCamera(var_8_0, arg_8_1)
end

function var_0_0.switchNextVirtualCamera(arg_9_0)
	if not arg_9_0._curVirtualCameraSetId then
		arg_9_0._curVirtualCameraSetId = 1
	elseif arg_9_0._curVirtualCameraSetId == 1 then
		arg_9_0._curVirtualCameraSetId = 2
	elseif arg_9_0._curVirtualCameraSetId == 2 then
		arg_9_0._curVirtualCameraSetId = 1
	end

	CameraMgr.instance:switchVirtualCamera(arg_9_0._curVirtualCameraSetId)
end

function var_0_0.enablePostProcessSmooth(arg_10_0, arg_10_1)
	local var_10_0 = CameraMgr.instance:getCameraRootGO()

	if not arg_10_0._dofSmoothComp then
		local var_10_1 = gohelper.findChild(var_10_0, "main/MainCamera/unitcamera/PPVolume")

		if var_10_1 then
			arg_10_0._dofSmoothComp = gohelper.onceAddComponent(var_10_1, typeof(ZProj.DepthOfFieldSmooth))
			arg_10_0._dofSmoothComp.maxOffset = 0.1
			arg_10_0._dofSmoothComp.frameRatio = 0.02
		else
			logError("add smooth comp fail, PPVolume not exist")
		end
	end

	if arg_10_0._dofSmoothComp then
		arg_10_0._dofSmoothComp.enabled = arg_10_1
	end

	if not arg_10_0._lightColorSmoothComp then
		local var_10_2 = gohelper.findChild(var_10_0, "main/VirtualCameras/light/direct")

		if var_10_2 then
			arg_10_0._lightColorSmoothComp = gohelper.onceAddComponent(var_10_2, typeof(ZProj.LightColorSmooth))
			arg_10_0._lightColorSmoothComp.maxOffset = 0.1
			arg_10_0._lightColorSmoothComp.frameRatio = 0.02
		else
			logError("add smooth comp fail, DirectLight not exist")
		end
	end

	if arg_10_0._lightColorSmoothComp then
		arg_10_0._lightColorSmoothComp.enabled = arg_10_1

		if arg_10_1 then
			TaskDispatcher.runDelay(arg_10_0._delayDisableSmooth, arg_10_0, 0.2)
		end
	end
end

function var_0_0._delayDisableSmooth(arg_11_0)
	arg_11_0._lightColorSmoothComp.enabled = false
end

function var_0_0.recordParam(arg_12_0)
	local var_12_0 = CameraMgr.instance:getCameraRootGO()

	arg_12_0._lightColor = gohelper.findChildComponent(var_12_0, "main/VirtualCameras/light/direct", typeof(UnityEngine.Light)).color
	arg_12_0._distortionRange = PostProcessingMgr.instance:getUnitPPValue("distortionRange")
	arg_12_0._dofDistance = PostProcessingMgr.instance:getUnitPPValue("dofDistance")
	arg_12_0._dofFactor = PostProcessingMgr.instance:getUnitPPValue("dofFactor")
	arg_12_0._dofFarBlur = PostProcessingMgr.instance:getUnitPPValue("dofFarBlur")
	arg_12_0._dofLength = PostProcessingMgr.instance:getUnitPPValue("dofLength")
	arg_12_0._dofNearBlur = PostProcessingMgr.instance:getUnitPPValue("dofNearBlur")
	arg_12_0._isDistortion = PostProcessingMgr.instance:getUnitPPValue("isDistortion")
	arg_12_0._rgbSplitCenter = PostProcessingMgr.instance:getUnitPPValue("rgbSplitCenter")

	local var_12_1 = CameraMgr.instance:getVirtualCamera(1, 1)
	local var_12_2 = ZProj.VirtualCameraWrap.Get(var_12_1.gameObject).body
	local var_12_3 = "Follower" .. string.sub(var_12_1.name, string.len(var_12_1.name))
	local var_12_4 = gohelper.findChild(var_12_1.transform.parent.gameObject, var_12_3)
	local var_12_5 = var_12_1.transform.parent.gameObject

	arg_12_0._pathOffset = var_12_2.m_PathOffset
	arg_12_0._pathPosition = var_12_2.m_PathPosition
	arg_12_0._xDamping = var_12_2.m_XDamping
	arg_12_0._yDamping = var_12_2.m_YDamping
	arg_12_0._zDamping = var_12_2.m_ZDamping
	arg_12_0._followerPos = var_12_4.transform.localPosition
	arg_12_0._vcamPos = var_12_5.transform.localPosition
end

function var_0_0.resetParam(arg_13_0)
	local var_13_0 = CameraMgr.instance:getCameraRootGO()

	gohelper.findChildComponent(var_13_0, "main/VirtualCameras/light/direct", typeof(UnityEngine.Light)).color = arg_13_0._lightColor

	PostProcessingMgr.instance:setUnitPPValue("distortionRange", arg_13_0._distortionRange)
	PostProcessingMgr.instance:setUnitPPValue("DistortionRange", arg_13_0._distortionRange)
	PostProcessingMgr.instance:setUnitPPValue("dofDistance", arg_13_0._dofDistance)
	PostProcessingMgr.instance:setUnitPPValue("DofDistance", arg_13_0._dofDistance)
	PostProcessingMgr.instance:setUnitPPValue("dofFactor", arg_13_0._dofFactor)
	PostProcessingMgr.instance:setUnitPPValue("DofFactor", arg_13_0._dofFactor)
	PostProcessingMgr.instance:setUnitPPValue("dofFarBlur", arg_13_0._dofFarBlur)
	PostProcessingMgr.instance:setUnitPPValue("DofFarBlur", arg_13_0._dofFarBlur)
	PostProcessingMgr.instance:setUnitPPValue("dofLength", arg_13_0._dofLength)
	PostProcessingMgr.instance:setUnitPPValue("DofLength", arg_13_0._dofLength)
	PostProcessingMgr.instance:setUnitPPValue("dofNearBlur", arg_13_0._dofNearBlur)
	PostProcessingMgr.instance:setUnitPPValue("DofNearBlur", arg_13_0._dofNearBlur)
	PostProcessingMgr.instance:setUnitPPValue("isDistortion", arg_13_0._isDistortion)
	PostProcessingMgr.instance:setUnitPPValue("IsDistortion", arg_13_0._isDistortion)
	PostProcessingMgr.instance:setUnitPPValue("rgbSplitCenter", arg_13_0._rgbSplitCenter)
	PostProcessingMgr.instance:setUnitPPValue("RgbSplitCenter", arg_13_0._rgbSplitCenter)

	arg_13_0._mulColor = arg_13_0._mulColor or Color.New(1, 1, 1, 1)
	arg_13_0._keepColor = arg_13_0._keepColor or Color.New(0, 0, 0, 1)

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
	PostProcessingMgr.instance:setUnitPPValue("mulColor", arg_13_0._mulColor)
	PostProcessingMgr.instance:setUnitPPValue("MulColor", arg_13_0._mulColor)
	PostProcessingMgr.instance:setUnitPPValue("keepColor", arg_13_0._keepColor)
	PostProcessingMgr.instance:setUnitPPValue("KeepColor", arg_13_0._keepColor)
	PostProcessingMgr.instance:setUnitPPValue("inverse", false)
	PostProcessingMgr.instance:setUnitPPValue("Inverse", false)
	PostProcessingMgr.instance:setUnitPPValue("colorSceOldMoviesActive", false)
	PostProcessingMgr.instance:setUnitPPValue("ColorSceOldMoviesActive", false)

	local var_13_1 = CameraMgr.instance:getVirtualCameras()

	for iter_13_0, iter_13_1 in ipairs(var_13_1) do
		local var_13_2 = ZProj.VirtualCameraWrap.Get(iter_13_1.gameObject).body
		local var_13_3 = "Follower" .. string.sub(iter_13_1.name, string.len(iter_13_1.name))
		local var_13_4 = gohelper.findChild(iter_13_1.transform.parent.gameObject, var_13_3)
		local var_13_5 = iter_13_1.transform.parent.gameObject

		var_13_2.m_PathOffset = arg_13_0._pathOffset
		var_13_2.m_PathPosition = arg_13_0._pathPosition
		var_13_2.m_XDamping = arg_13_0._xDamping
		var_13_2.m_YDamping = arg_13_0._yDamping
		var_13_2.m_ZDamping = arg_13_0._zDamping
		var_13_4.transform.localPosition = arg_13_0._followerPos
		var_13_5.transform.localPosition = arg_13_0._vcamPos
	end
end

function var_0_0._delaySetUnitCameraFov(arg_14_0)
	local var_14_0 = CameraMgr.instance:getMainCamera()

	CameraMgr.instance:getUnitCamera().fieldOfView = var_14_0.fieldOfView

	FightController.instance:dispatchEvent(FightEvent.OnCameraFovChange)
end

function var_0_0.setSceneCameraOffset(arg_15_0)
	arg_15_0:setCameraOffset(arg_15_0:getDefaultCameraOffset())
end

function var_0_0.getDefaultCameraOffset(arg_16_0)
	if arg_16_0._myTurnOffset then
		return Vector3.New(arg_16_0._myTurnOffset[1], arg_16_0._myTurnOffset[2], arg_16_0._myTurnOffset[3])
	end

	local var_16_0 = GameSceneMgr.instance:getCurLevelId()
	local var_16_1 = lua_scene_level.configDict[var_16_0]
	local var_16_2 = var_16_1 and var_16_1.cameraOffset

	if not string.nilorempty(var_16_2) then
		return (Vector3(unpack(cjson.decode(var_16_2))))
	else
		return Vector3.New(0, 0, 0)
	end
end

function var_0_0.setCameraOffset(arg_17_0, arg_17_1)
	CameraMgr.instance:getVirtualCameraGO().transform.localPosition = arg_17_1
end

function var_0_0.resetCameraOffset(arg_18_0)
	CameraMgr.instance:getVirtualCameraGO().transform.localPosition = Vector3.zero
end

local var_0_1 = 60
local var_0_2 = 1.7777777777777777

function var_0_0._onScreenResize(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = CameraMgr.instance:getVirtualCameras()
	local var_19_1 = arg_19_1 / arg_19_2 / var_0_2
	local var_19_2 = 2 * Mathf.Atan(Mathf.Tan(var_0_1 * Mathf.Deg2Rad / 2) / var_19_1) * Mathf.Rad2Deg
	local var_19_3 = Mathf.Clamp(var_19_2, 60, 120)

	for iter_19_0, iter_19_1 in ipairs(var_19_0) do
		local var_19_4 = iter_19_1.m_Lens

		iter_19_1.m_Lens = Cinemachine.LensSettings.New(var_19_3, var_19_4.OrthographicSize, var_19_4.NearClipPlane, var_19_4.FarClipPlane, var_19_4.Dutch)
	end

	TaskDispatcher.runDelay(arg_19_0._delaySetUnitCameraFov, arg_19_0, 0.01)
end

function var_0_0._onFightRoundStart(arg_20_0)
	local var_20_0 = GameSceneMgr.instance:getCurLevelId()
	local var_20_1 = lua_fight_camera_player_turn_offset.configDict[var_20_0]

	if var_20_1 then
		arg_20_0._myTurnOffset = var_20_1.offset

		arg_20_0:setSceneCameraOffset()
	else
		arg_20_0._myTurnOffset = nil
	end
end

function var_0_0._onMySideRoundEnd(arg_21_0)
	arg_21_0._myTurnOffset = nil

	arg_21_0:setSceneCameraOffset()
end

function var_0_0._onRestartStageBefore(arg_22_0)
	arg_22_0._myTurnOffset = nil
end

return var_0_0
