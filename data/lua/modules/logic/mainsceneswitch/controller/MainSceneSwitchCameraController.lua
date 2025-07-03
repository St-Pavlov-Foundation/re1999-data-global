module("modules.logic.mainsceneswitch.controller.MainSceneSwitchCameraController", package.seeall)

local var_0_0 = class("MainSceneSwitchCameraController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.onInitFinish(arg_2_0)
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, arg_2_0._onScreenResize, arg_2_0)
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	return
end

function var_0_0.clear(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._delayResize, arg_5_0)

	arg_5_0._showSceneId = nil
	arg_5_0._calllback = nil
	arg_5_0._callbackTarget = nil

	if arg_5_0._rt then
		arg_5_0._unitCamera.targetTexture = nil

		UnityEngine.RenderTexture.ReleaseTemporary(arg_5_0._rt)

		arg_5_0._rt = nil
	end

	MainSceneSwitchCameraDisplayController.instance:clear()

	if arg_5_0._cameraLoader then
		arg_5_0._cameraLoader:dispose()

		arg_5_0._cameraLoader = nil
	end

	gohelper.destroy(arg_5_0._cameraRootGO)

	arg_5_0._cameraRootGO = nil
	arg_5_0._cameraTrace = nil
	arg_5_0._cameraCO = nil
	arg_5_0._cameraTrace = nil
	arg_5_0._cameraTraceGO = nil
	arg_5_0._focusTrs = nil
	arg_5_0._mainSceneRoot = nil
	arg_5_0._unitPPVolume = nil
	arg_5_0._mainCamera = nil
	arg_5_0._mainCameraGO = nil
	arg_5_0._mainCameraTrs = nil
	arg_5_0._unitCamera = nil
	arg_5_0._unitCameraGO = nil
	arg_5_0._unitCameraTrs = nil
	arg_5_0._isShowScene = false
end

function var_0_0.hideScene(arg_6_0)
	MainSceneSwitchCameraDisplayController.instance:hideScene()

	arg_6_0._isShowScene = false

	gohelper.setActive(arg_6_0._cameraRootGO, false)
end

function var_0_0.showScene(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0._showSceneId = arg_7_1
	arg_7_0._callback = arg_7_2
	arg_7_0._callbackTarget = arg_7_3
	arg_7_0._isShowScene = true

	if not arg_7_0._callback or not arg_7_0._callbackTarget then
		logError("MainSceneSwitchCameraController showScene callback or callbackTarget is nil")

		return
	end

	arg_7_0:_showScene()
end

function var_0_0._showScene(arg_8_0)
	if not arg_8_0._showSceneId or not arg_8_0._callback or not arg_8_0._isShowScene then
		return
	end

	if arg_8_0._cameraRootGO then
		gohelper.setActive(arg_8_0._cameraRootGO, true)
		arg_8_0:_initSettings()

		if not MainSceneSwitchCameraDisplayController.instance:hasSceneRoot() then
			MainSceneSwitchCameraDisplayController.instance:setSceneRoot(arg_8_0._mainSceneRoot)
		end

		MainSceneSwitchCameraDisplayController.instance:showScene(arg_8_0._showSceneId, arg_8_0._onShowSceneFinish, arg_8_0)
	else
		arg_8_0:_loadCamera()
	end
end

function var_0_0._onShowSceneFinish(arg_9_0)
	local var_9_0 = arg_9_0._callback
	local var_9_1 = arg_9_0._callbackTarget

	if var_9_0 then
		var_9_0(var_9_1, arg_9_0._rt)
	end
end

function var_0_0._onScreenResize(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_0._cameraRootGO then
		return
	end

	arg_10_0:resetParam()
	arg_10_0:applyDirectly()
	TaskDispatcher.cancelTask(arg_10_0._delayResize, arg_10_0)
	TaskDispatcher.runDelay(arg_10_0._delayResize, arg_10_0, 0)
end

function var_0_0._delayResize(arg_11_0)
	if not arg_11_0._rt or not arg_11_0._isShowScene then
		return
	end

	local var_11_0, var_11_1 = arg_11_0:_getRTSize()

	if arg_11_0._rt.width == var_11_0 and arg_11_0._rt.height == var_11_1 then
		return
	end

	if arg_11_0._rt then
		arg_11_0._unitCamera.targetTexture = nil

		UnityEngine.RenderTexture.ReleaseTemporary(arg_11_0._rt)

		arg_11_0._rt = nil
	end

	arg_11_0:_initRT()

	local var_11_2 = arg_11_0._callback
	local var_11_3 = arg_11_0._callbackTarget

	if var_11_2 then
		var_11_2(var_11_3, arg_11_0._rt)
	end
end

function var_0_0._loadCamera(arg_12_0)
	if arg_12_0._cameraLoader then
		return
	end

	arg_12_0._cameraLoader = MultiAbLoader.New()
	arg_12_0._cameraPath = "ppassets/switchscenecameraroot.prefab"

	arg_12_0._cameraLoader:addPath(arg_12_0._cameraPath)
	arg_12_0._cameraLoader:startLoad(arg_12_0._loadCameraFinish, arg_12_0)
end

local var_0_1 = 20000

function var_0_0._loadCameraFinish(arg_13_0)
	local var_13_0 = arg_13_0._cameraLoader:getAssetItem(arg_13_0._cameraPath)

	arg_13_0._cameraRootGO = gohelper.clone(var_13_0:GetResource(), nil, "switchscenecameraroot")

	transformhelper.setLocalPos(arg_13_0._cameraRootGO.transform, var_0_1, 0, 0)
	arg_13_0:_initCameraRootGO()

	arg_13_0._cameraTrace.EnableTrace = true

	local var_13_1 = 10101

	arg_13_0:_initCurSceneCameraTrace(var_13_1)

	arg_13_0._cameraTrace.EnableTrace = false
end

local var_0_2 = "main/MainCamera"
local var_0_3 = "main/MainCamera/unitcamera"

function var_0_0._initCameraRootGO(arg_14_0)
	arg_14_0._cameraTraceGO = gohelper.findChild(arg_14_0._cameraRootGO, "main")
	arg_14_0._cameraTrace = ZProj.GameCameraTrace.Get(arg_14_0._cameraTraceGO)
	arg_14_0._cameraTrace.EnableTrace = false

	ZProj.CameraChangeActor4Lua.Instance:SetCameraTrace(arg_14_0._cameraTrace)

	arg_14_0._focusTrs = gohelper.findChild(arg_14_0._cameraRootGO, "focus").transform

	arg_14_0._cameraTrace:SetFocusTransform(arg_14_0._focusTrs)

	local var_14_0 = gohelper.findChild(arg_14_0._cameraRootGO, var_0_2)
	local var_14_1 = gohelper.findChild(arg_14_0._cameraRootGO, var_0_3)

	arg_14_0:setMainCamera(var_14_0)
	arg_14_0:setUnitCamera(var_14_1)
	TaskDispatcher.runDelay(arg_14_0._destoryActiveGos, arg_14_0, 1)

	arg_14_0._mainSceneRoot = gohelper.findChild(arg_14_0._cameraRootGO, "SceneRoot/MainScene")
	arg_14_0._unitPPVolume = gohelper.findChildComponent(var_14_1, "PPVolume", PostProcessingMgr.PPVolumeWrapType)

	MainSceneSwitchCameraDisplayController.instance:initMaps()
	MainSceneSwitchCameraDisplayController.instance:setSceneRoot(arg_14_0._mainSceneRoot)
	arg_14_0:_initSettings()
	arg_14_0:setPPMaskType(true)
	arg_14_0:_showScene()
end

function var_0_0.setPPMaskType(arg_15_0, arg_15_1)
	arg_15_0:setUnitPPValue("rolesStoryMaskActive", arg_15_1)
	arg_15_0:setUnitPPValue("RolesStoryMaskActive", arg_15_1)
	arg_15_0:setUnitPPValue("rgbSplitStrength", 0)
	arg_15_0:setUnitPPValue("RgbSplitStrength", 0)
	arg_15_0:setUnitPPValue("radialBlurLevel", 1)
	arg_15_0:setUnitPPValue("RadialBlurLevel", 1)
	arg_15_0:setUnitPPValue("dofFactor", 0)
	arg_15_0:setUnitPPValue("DofFactor", 0)
end

function var_0_0.setUnitPPValue(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_0._unitPPVolume then
		arg_16_0._unitPPVolume.refresh = true
		arg_16_0._unitPPVolume[arg_16_1] = arg_16_2
	end
end

function var_0_0.setLocalBloomColor(arg_17_0, arg_17_1)
	arg_17_0:setUnitPPValue("localBloomColor", arg_17_1)
end

function var_0_0.setMainCamera(arg_18_0, arg_18_1)
	arg_18_0._mainCamera = arg_18_1:GetComponent("Camera")
	arg_18_0._mainCameraGO = arg_18_1
	arg_18_0._mainCameraTrs = arg_18_1.transform
end

function var_0_0.setUnitCamera(arg_19_0, arg_19_1)
	arg_19_0._unitCamera = arg_19_1:GetComponent("Camera")
	arg_19_0._unitCameraGO = arg_19_1
	arg_19_0._unitCameraTrs = arg_19_1.transform
end

function var_0_0._destoryActiveGos(arg_20_0)
	local var_20_0 = gohelper.findChild(arg_20_0._mainCameraGO, "scene")

	if var_20_0 then
		gohelper.destroy(var_20_0)
	end

	local var_20_1 = gohelper.findChild(arg_20_0._unitCameraGO, "unit")

	if var_20_1 then
		gohelper.destroy(var_20_1)
	end
end

function var_0_0._initSettings(arg_21_0)
	arg_21_0:_initRT()
	arg_21_0:_initProfile()
end

function var_0_0._initProfile(arg_22_0)
	local var_22_0 = PostProcessingMgr.instance:getProfile()

	arg_22_0._unitPPVolume:SetProfile(var_22_0)
end

function var_0_0._initRT(arg_23_0)
	arg_23_0._rt = arg_23_0._rt or arg_23_0:_getRT()
	arg_23_0._unitCamera.targetTexture = arg_23_0._rt
end

function var_0_0._getRT(arg_24_0)
	local var_24_0, var_24_1 = arg_24_0:_getRTSize()

	return UnityEngine.RenderTexture.GetTemporary(var_24_0, var_24_1, 0, UnityEngine.RenderTextureFormat.ARGBHalf)
end

function var_0_0._getRTSize(arg_25_0)
	local var_25_0 = arg_25_0._mainCamera.pixelWidth
	local var_25_1 = arg_25_0._mainCamera.pixelHeight
	local var_25_2 = var_25_0 / var_25_1
	local var_25_3 = UnityEngine.SystemInfo.maxTextureSize

	if var_25_3 < var_25_0 and var_25_1 < var_25_0 then
		var_25_0 = var_25_3
		var_25_1 = var_25_0 / var_25_2
	end

	if var_25_3 < var_25_1 and var_25_0 < var_25_1 then
		var_25_1 = var_25_3
		var_25_0 = var_25_1 * var_25_2
	end

	return var_25_0, var_25_1
end

function var_0_0._initCurSceneCameraTrace(arg_26_0, arg_26_1)
	local var_26_0 = lua_scene_level.configDict[arg_26_1]

	arg_26_0._cameraCO = lua_camera.configDict[var_26_0.cameraId]

	arg_26_0:resetParam()
	arg_26_0:applyDirectly()
end

function var_0_0.resetParam(arg_27_0, arg_27_1)
	arg_27_1 = arg_27_1 or arg_27_0._cameraCO

	local var_27_0 = arg_27_1.yaw
	local var_27_1 = arg_27_1.pitch
	local var_27_2 = arg_27_1.distance
	local var_27_3 = arg_27_0:_calcFovInternal(arg_27_1)

	arg_27_0.yaw = var_27_0

	arg_27_0._cameraTrace:SetTargetParam(var_27_0, var_27_1, var_27_2, var_27_3, 0, 0, 0)

	local var_27_4 = var_0_1
	local var_27_5 = arg_27_1.yOffset
	local var_27_6 = arg_27_1.focusZ

	arg_27_0:setFocus(var_27_4, var_27_5, var_27_6)
end

function var_0_0.setFocus(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = arg_28_0._focusTrs

	transformhelper.setPos(var_28_0, arg_28_1, arg_28_2, arg_28_3)
end

function var_0_0._calcFovInternal(arg_29_0, arg_29_1)
	local var_29_0 = 1.7777777777777777 * (UnityEngine.Screen.height / UnityEngine.Screen.width)

	if BootNativeUtil.isWindows() and not SLFramework.FrameworkSettings.IsEditor then
		local var_29_1, var_29_2 = SettingsModel.instance:getCurrentScreenSize()

		var_29_0 = 16 * var_29_2 / 9 / var_29_1
	end

	local var_29_3 = arg_29_1.fov * var_29_0

	if var_29_0 > 1 then
		var_29_3 = var_29_3 * 0.85
	end

	local var_29_4, var_29_5 = arg_29_0:_getMinMaxFov()

	return (Mathf.Clamp(var_29_3, var_29_4, var_29_5))
end

function var_0_0._getMinMaxFov(arg_30_0)
	return 35, 120
end

function var_0_0.applyDirectly(arg_31_0)
	local var_31_0 = arg_31_0._focusTrs

	arg_31_0._cameraTrace:SetTargetFocusPos(transformhelper.getPos(var_31_0))
	arg_31_0._cameraTrace:ApplyDirectly()
end

var_0_0.instance = var_0_0.New()

return var_0_0
