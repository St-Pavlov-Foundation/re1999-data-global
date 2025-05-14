module("modules.logic.scene.common.camera.CameraMgr", package.seeall)

local var_0_0 = class("CameraMgr")
local var_0_1 = "ppassets/cameraroot.prefab"
local var_0_2 = "ppassets/urpassets/urpasset.asset"
local var_0_3 = "cameraroot"
local var_0_4 = "main/MainCamera"
local var_0_5 = "main/MainCamera/unitcamera"
local var_0_6 = "main/orthCamera"
local var_0_7 = "main/subcamera"
local var_0_8 = "UICamera"
local var_0_9 = "main/VirtualCameras"

function var_0_0.ctor(arg_1_0)
	arg_1_0._cameraRootGO = nil
	arg_1_0._cameraTraceGO = nil
	arg_1_0._cameraTrace = nil
	arg_1_0._cameraShake = nil
	arg_1_0._focusTrs = nil
	arg_1_0._mainCamera = nil
	arg_1_0._mainCameraGO = nil
	arg_1_0._mainCameraTrs = nil
	arg_1_0._uiCamera = nil
	arg_1_0._uiCameraGO = nil
	arg_1_0._uiCameraTrs = nil
	arg_1_0._unitCamera = nil
	arg_1_0._unitCameraGO = nil
	arg_1_0._unitCameraTrs = nil
	arg_1_0._orthCamera = nil
	arg_1_0._orthCameraGO = nil
	arg_1_0._orthCameraTrs = nil
	arg_1_0._subCamera = nil
	arg_1_0._subCameraGO = nil
	arg_1_0._subCameraTrs = nil
	arg_1_0._urpProfileAsset = nil
	arg_1_0._sceneRootGO = nil
	arg_1_0._virtualCameraList = nil
	arg_1_0._virtualCameraGO = nil
	arg_1_0._virtualCameraTrs = nil
	arg_1_0._virtualCameraSets = nil
	arg_1_0._cameraRootAnimator = nil
	arg_1_0._cameraRootAnimatorPlayer = nil
end

function var_0_0.initCamera(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._onInitDone = arg_2_1
	arg_2_0._doneCbObj = arg_2_2

	loadAbAsset(var_0_2, true, arg_2_0._onLoadedUrpProfile, arg_2_0)
end

function var_0_0._onLoadedCamera(arg_3_0, arg_3_1)
	if not arg_3_1.IsLoadSuccess then
		logError("CameraMgr:_onLoadedCamera load fail: " .. arg_3_1.ResPath)
	else
		arg_3_1:Retain()

		arg_3_0._cameraRootGO = gohelper.clone(arg_3_1.EngineAsset, nil, var_0_3)

		arg_3_0:_initCameraRootGO()
	end

	if arg_3_0._onInitDone then
		arg_3_0._onInitDone(arg_3_0._doneCbObj)
	end
end

function var_0_0._initCameraRootGO(arg_4_0)
	arg_4_0._cameraTraceGO = gohelper.findChild(arg_4_0._cameraRootGO, "main")
	arg_4_0._sceneRootGO = gohelper.findChild(arg_4_0._cameraRootGO, "SceneRoot")
	arg_4_0._sceneTransform = arg_4_0._sceneRootGO.transform
	arg_4_0._cameraTrace = ZProj.GameCameraTrace.Get(arg_4_0._cameraTraceGO)
	arg_4_0._cameraTrace.EnableTrace = false
	arg_4_0._cameraShake = ZProj.CameraShake.Get(arg_4_0._sceneRootGO)

	ZProj.CameraChangeActor4Lua.Instance:SetCameraTrace(arg_4_0._cameraTrace)

	arg_4_0._focusTrs = gohelper.findChild(arg_4_0._cameraRootGO, "focus").transform

	arg_4_0._cameraTrace:SetFocusTransform(arg_4_0._focusTrs)

	local var_4_0 = gohelper.findChild(arg_4_0._cameraRootGO, var_0_4)
	local var_4_1 = gohelper.findChild(arg_4_0._cameraRootGO, var_0_5)
	local var_4_2 = gohelper.findChild(arg_4_0._cameraRootGO, var_0_6)
	local var_4_3 = gohelper.findChild(arg_4_0._cameraRootGO, var_0_8)
	local var_4_4 = gohelper.findChild(arg_4_0._cameraRootGO, var_0_7)
	local var_4_5 = gohelper.findChild(arg_4_0._cameraRootGO, var_0_9)

	arg_4_0:setMainCamera(var_4_0)
	arg_4_0:setUICamera(var_4_3)
	arg_4_0:setUnitCamera(var_4_1)
	arg_4_0:setOrthCamera(var_4_2)
	arg_4_0:setOrthCameraActive(false)
	arg_4_0:setSubCamera(var_4_4)
	arg_4_0:setVirtualCamera(var_4_5)

	arg_4_0._showUnitCameraKeyDict = {}

	PostProcessingMgr.instance:init(var_4_0, var_4_1, var_4_3, arg_4_0._urpProfileAsset)
	TaskDispatcher.runDelay(arg_4_0._destoryActiveGos, arg_4_0, 1)
end

function var_0_0.setUnitCameraSeparate(arg_5_0)
	arg_5_0._unitCameraTrs.parent = arg_5_0._mainCameraTrs.parent
end

function var_0_0.setUnitCameraCombine(arg_6_0)
	arg_6_0._mainCameraTrs.localRotation = Vector3.zero
	arg_6_0._unitCameraTrs.parent = arg_6_0._mainCameraTrs
	arg_6_0._unitCameraTrs.localRotation = Vector3.zero
	arg_6_0._unitCameraTrs.localPosition = Vector3.zero
end

function var_0_0._destoryActiveGos(arg_7_0)
	local var_7_0 = gohelper.findChild(arg_7_0._mainCameraGO, "scene")

	if var_7_0 then
		gohelper.destroy(var_7_0)
	end

	local var_7_1 = gohelper.findChild(arg_7_0._unitCameraGO, "unit")

	if var_7_1 then
		gohelper.destroy(var_7_1)
	end

	local var_7_2 = UnityEngine.GameObject.Find("ClearCamera")

	if var_7_2 then
		gohelper.destroy(var_7_2)
	end
end

function var_0_0._onLoadedUrpProfile(arg_8_0, arg_8_1)
	if not arg_8_1.IsLoadSuccess then
		logError("CameraMgr:_onLoadedUrpProfile load fail: " .. arg_8_1.ResPath)
	else
		arg_8_1:Retain()

		arg_8_0._urpProfileAsset = arg_8_1.EngineAsset
		UnityEngine.Rendering.GraphicsSettings.renderPipelineAsset = arg_8_0._urpProfileAsset
	end

	loadAbAsset(var_0_1, true, arg_8_0._onLoadedCamera, arg_8_0)
end

function var_0_0.initCameraWithCameraRoot(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0._onInitDone = arg_9_1
	arg_9_0._doneCbObj = arg_9_2
	arg_9_0._cameraRootGO = arg_9_3

	loadAbAsset(var_0_2, true, arg_9_0._onLoadedUrpProfileWithCameraRoot, arg_9_0)
end

function var_0_0._onLoadedUrpProfileWithCameraRoot(arg_10_0, arg_10_1)
	if not arg_10_1.IsLoadSuccess then
		logError("CameraMgr:_onLoadedUrpProfile load fail: " .. arg_10_1.ResPath)
	else
		arg_10_1:Retain()

		arg_10_0._urpProfileAsset = arg_10_1.EngineAsset
		UnityEngine.Rendering.GraphicsSettings.renderPipelineAsset = arg_10_0._urpProfileAsset
	end

	arg_10_0:_initCameraRootGO()

	if arg_10_0._onInitDone then
		arg_10_0._onInitDone(arg_10_0._doneCbObj)
	end
end

function var_0_0.setMainCamera(arg_11_0, arg_11_1)
	arg_11_0._mainCamera = arg_11_1:GetComponent("Camera")
	arg_11_0._mainCameraGO = arg_11_1
	arg_11_0._mainCameraTrs = arg_11_1.transform
end

function var_0_0.setUICamera(arg_12_0, arg_12_1)
	arg_12_0._uiCamera = arg_12_1:GetComponent("Camera")
	arg_12_0._uiCameraGO = arg_12_1
	arg_12_0._uiCameraTrs = arg_12_1.transform
	ViewMgr.instance:getUICanvas().worldCamera = arg_12_0._uiCamera
end

function var_0_0.setUnitCamera(arg_13_0, arg_13_1)
	arg_13_0._unitCamera = arg_13_1:GetComponent("Camera")
	arg_13_0._unitCameraGO = arg_13_1
	arg_13_0._unitCameraTrs = arg_13_1.transform
end

function var_0_0.setOrthCamera(arg_14_0, arg_14_1)
	arg_14_0._orthCamera = arg_14_1:GetComponent("Camera")
	arg_14_0._orthCameraGO = arg_14_1
	arg_14_0._orthCameraTrs = arg_14_1.transform
end

function var_0_0.setSubCamera(arg_15_0, arg_15_1)
	arg_15_0._subCamera = arg_15_1:GetComponent("Camera")
	arg_15_0._subCameraGO = arg_15_1
	arg_15_0._subCameraTrs = arg_15_1.transform
end

function var_0_0.setVirtualCamera(arg_16_0, arg_16_1)
	arg_16_0._virtualCameraGO = arg_16_1
	arg_16_0._virtualCameraTrs = arg_16_1.transform
	arg_16_0._virtualCameraList = {}

	local var_16_0 = {
		"set1/vcam1/CM_vcam1",
		"set1/vcam2/CM_vcam2",
		"set2/vcam3/CM_vcam3",
		"set2/vcam4/CM_vcam4"
	}

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		local var_16_1 = gohelper.findChildComponent(arg_16_0._virtualCameraGO, iter_16_1, typeof(Cinemachine.CinemachineVirtualCamera))

		if var_16_1 then
			table.insert(arg_16_0._virtualCameraList, var_16_1)
		end
	end

	arg_16_0._virtualCameraSets = {}
	arg_16_0._virtualCameraSets[1] = gohelper.findChild(arg_16_1, "set1")
	arg_16_0._virtualCameraSets[2] = gohelper.findChild(arg_16_1, "set2")
end

function var_0_0.switchVirtualCamera(arg_17_0, arg_17_1)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0._virtualCameraSets) do
		iter_17_1.name = iter_17_0 == arg_17_1 and "set" .. arg_17_1 or "disableSet"

		gohelper.setActive(iter_17_1, iter_17_0 == arg_17_1)
	end
end

function var_0_0.setSceneCameraActive(arg_18_0, arg_18_1, arg_18_2)
	if not arg_18_0._unitCameraGO then
		return
	end

	arg_18_0._showUnitCameraKeyDict[arg_18_2] = arg_18_1 and true or false

	local var_18_0 = true

	for iter_18_0, iter_18_1 in pairs(arg_18_0._showUnitCameraKeyDict) do
		if not iter_18_1 then
			var_18_0 = false

			break
		end
	end

	gohelper.setActive(arg_18_0._unitCameraGO, var_18_0)
end

function var_0_0.setOrthCameraActive(arg_19_0, arg_19_1)
	gohelper.setActive(arg_19_0._orthCameraGO, arg_19_1)
end

function var_0_0.getCameraRootGO(arg_20_0)
	return arg_20_0._cameraRootGO
end

function var_0_0.getCameraRootAnimator(arg_21_0)
	if arg_21_0._cameraRootAnimatorPlayer then
		arg_21_0._cameraRootAnimatorPlayer:Stop()
	elseif SLFramework.FrameworkSettings.IsEditor and arg_21_0._cameraRootGO:GetComponent(typeof(SLFramework.AnimatorPlayer)) then
		logError("CameraMgr要通过getCameraRootAnimatorPlayer获得AnimatorPlayer")
	end

	if not arg_21_0._cameraRootAnimator then
		arg_21_0._cameraRootAnimator = gohelper.onceAddComponent(arg_21_0._cameraRootGO, typeof(UnityEngine.Animator))
	end

	return arg_21_0._cameraRootAnimator
end

function var_0_0.getCameraRootAnimatorPlayer(arg_22_0)
	arg_22_0._cameraRootAnimatorPlayer = arg_22_0._cameraRootAnimatorPlayer or SLFramework.AnimatorPlayer.Get(arg_22_0._cameraRootGO)

	return arg_22_0._cameraRootAnimatorPlayer
end

function var_0_0.hasCameraRootAnimatorPlayer(arg_23_0)
	return arg_23_0._cameraRootAnimatorPlayer ~= nil
end

function var_0_0.getCameraTraceGO(arg_24_0)
	return arg_24_0._cameraTraceGO
end

function var_0_0.getCameraTrace(arg_25_0)
	return arg_25_0._cameraTrace
end

function var_0_0.getCameraShake(arg_26_0)
	return arg_26_0._cameraShake
end

function var_0_0.getFocusTrs(arg_27_0)
	return arg_27_0._focusTrs
end

function var_0_0.getMainCamera(arg_28_0)
	return arg_28_0._mainCamera
end

function var_0_0.getMainCameraGO(arg_29_0)
	return arg_29_0._mainCameraGO
end

function var_0_0.getMainCameraTrs(arg_30_0)
	return arg_30_0._mainCameraTrs
end

function var_0_0.getUICamera(arg_31_0)
	return arg_31_0._uiCamera
end

function var_0_0.getUICameraGO(arg_32_0)
	return arg_32_0._uiCameraGO
end

function var_0_0.getUICameraTrs(arg_33_0)
	return arg_33_0._uiCameraTrs
end

function var_0_0.getUnitCamera(arg_34_0)
	return arg_34_0._unitCamera
end

function var_0_0.getUnitCameraGO(arg_35_0)
	return arg_35_0._unitCameraGO
end

function var_0_0.getUnitCameraTrs(arg_36_0)
	return arg_36_0._unitCameraTrs
end

function var_0_0.getOrthCamera(arg_37_0)
	return arg_37_0._orthCamera
end

function var_0_0.getOrthCameraGO(arg_38_0)
	return arg_38_0._orthCameraGO
end

function var_0_0.getSubCamera(arg_39_0)
	return arg_39_0._subCamera
end

function var_0_0.getSubCameraGO(arg_40_0)
	return arg_40_0._subCameraGO
end

function var_0_0.getSubCameraTrs(arg_41_0)
	return arg_41_0._subCameraTrs
end

function var_0_0.getSceneRoot(arg_42_0)
	return arg_42_0._sceneRootGO
end

function var_0_0.getSceneTransform(arg_43_0)
	return arg_43_0._sceneTransform
end

function var_0_0.getVirtualCamera(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0 = (arg_44_1 - 1) * 2 + arg_44_2

	return arg_44_0._virtualCameraList[var_44_0]
end

function var_0_0.getVirtualCameras(arg_45_0)
	return arg_45_0._virtualCameraList
end

function var_0_0.getVirtualCameraGO(arg_46_0)
	return arg_46_0._virtualCameraGO
end

function var_0_0.setVirtualCameraChildActive(arg_47_0, arg_47_1, arg_47_2)
	if not arg_47_0._virtualCameraGO then
		return
	end

	local var_47_0 = gohelper.findChild(arg_47_0._virtualCameraGO, arg_47_2)

	gohelper.setActive(var_47_0, arg_47_1)
end

function var_0_0.getVirtualCameraTrs(arg_48_0)
	return arg_48_0._virtualCameraTrs
end

function var_0_0.setRenderScale(arg_49_0, arg_49_1)
	if arg_49_0._urpProfileAsset then
		logNormal("CameraMgr:setRenderScale scale = " .. arg_49_1)

		arg_49_0._urpProfileAsset.renderScale = arg_49_1
	end
end

function var_0_0.setRenderMSAACount(arg_50_0, arg_50_1)
	if arg_50_0._urpProfileAsset then
		logNormal("CameraMgr:setRenderMSAACount count = " .. arg_50_1)

		arg_50_0._urpProfileAsset.msaaSampleCount = arg_50_1
	end
end

function var_0_0.getRenderScale(arg_51_0)
	if arg_51_0._urpProfileAsset then
		return arg_51_0._urpProfileAsset.renderScale
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
