module("modules.logic.scene.common.camera.CameraMgr", package.seeall)

slot0 = class("CameraMgr")
slot1 = "ppassets/cameraroot.prefab"
slot2 = "ppassets/urpassets/urpasset.asset"
slot3 = "cameraroot"
slot4 = "main/MainCamera"
slot5 = "main/MainCamera/unitcamera"
slot6 = "main/orthCamera"
slot7 = "main/subcamera"
slot8 = "UICamera"
slot9 = "main/VirtualCameras"

function slot0.ctor(slot0)
	slot0._cameraRootGO = nil
	slot0._cameraTraceGO = nil
	slot0._cameraTrace = nil
	slot0._cameraShake = nil
	slot0._focusTrs = nil
	slot0._mainCamera = nil
	slot0._mainCameraGO = nil
	slot0._mainCameraTrs = nil
	slot0._uiCamera = nil
	slot0._uiCameraGO = nil
	slot0._uiCameraTrs = nil
	slot0._unitCamera = nil
	slot0._unitCameraGO = nil
	slot0._unitCameraTrs = nil
	slot0._orthCamera = nil
	slot0._orthCameraGO = nil
	slot0._orthCameraTrs = nil
	slot0._subCamera = nil
	slot0._subCameraGO = nil
	slot0._subCameraTrs = nil
	slot0._urpProfileAsset = nil
	slot0._sceneRootGO = nil
	slot0._virtualCameraList = nil
	slot0._virtualCameraGO = nil
	slot0._virtualCameraTrs = nil
	slot0._virtualCameraSets = nil
	slot0._cameraRootAnimator = nil
	slot0._cameraRootAnimatorPlayer = nil
end

function slot0.initCamera(slot0, slot1, slot2)
	slot0._onInitDone = slot1
	slot0._doneCbObj = slot2

	loadAbAsset(uv0, true, slot0._onLoadedUrpProfile, slot0)
end

function slot0._onLoadedCamera(slot0, slot1)
	if not slot1.IsLoadSuccess then
		logError("CameraMgr:_onLoadedCamera load fail: " .. slot1.ResPath)
	else
		slot1:Retain()

		slot0._cameraRootGO = gohelper.clone(slot1.EngineAsset, nil, uv0)

		slot0:_initCameraRootGO()
	end

	if slot0._onInitDone then
		slot0._onInitDone(slot0._doneCbObj)
	end
end

function slot0._initCameraRootGO(slot0)
	slot0._cameraTraceGO = gohelper.findChild(slot0._cameraRootGO, "main")
	slot0._sceneRootGO = gohelper.findChild(slot0._cameraRootGO, "SceneRoot")
	slot0._sceneTransform = slot0._sceneRootGO.transform
	slot0._cameraTrace = ZProj.GameCameraTrace.Get(slot0._cameraTraceGO)
	slot0._cameraTrace.EnableTrace = false
	slot0._cameraShake = ZProj.CameraShake.Get(slot0._sceneRootGO)

	ZProj.CameraChangeActor4Lua.Instance:SetCameraTrace(slot0._cameraTrace)

	slot0._focusTrs = gohelper.findChild(slot0._cameraRootGO, "focus").transform

	slot0._cameraTrace:SetFocusTransform(slot0._focusTrs)

	slot1 = gohelper.findChild(slot0._cameraRootGO, uv0)
	slot2 = gohelper.findChild(slot0._cameraRootGO, uv1)
	slot4 = gohelper.findChild(slot0._cameraRootGO, uv3)

	slot0:setMainCamera(slot1)
	slot0:setUICamera(slot4)
	slot0:setUnitCamera(slot2)
	slot0:setOrthCamera(gohelper.findChild(slot0._cameraRootGO, uv2))
	slot0:setOrthCameraActive(false)
	slot0:setSubCamera(gohelper.findChild(slot0._cameraRootGO, uv4))
	slot0:setVirtualCamera(gohelper.findChild(slot0._cameraRootGO, uv5))

	slot0._showUnitCameraKeyDict = {}

	PostProcessingMgr.instance:init(slot1, slot2, slot4, slot0._urpProfileAsset)
	TaskDispatcher.runDelay(slot0._destoryActiveGos, slot0, 1)
end

function slot0.setUnitCameraSeparate(slot0)
	slot0._unitCameraTrs.parent = slot0._mainCameraTrs.parent
end

function slot0.setUnitCameraCombine(slot0)
	slot0._mainCameraTrs.localRotation = Vector3.zero
	slot0._unitCameraTrs.parent = slot0._mainCameraTrs
	slot0._unitCameraTrs.localRotation = Vector3.zero
	slot0._unitCameraTrs.localPosition = Vector3.zero
end

function slot0._destoryActiveGos(slot0)
	if gohelper.findChild(slot0._mainCameraGO, "scene") then
		gohelper.destroy(slot1)
	end

	if gohelper.findChild(slot0._unitCameraGO, "unit") then
		gohelper.destroy(slot2)
	end

	if UnityEngine.GameObject.Find("ClearCamera") then
		gohelper.destroy(slot3)
	end
end

function slot0._onLoadedUrpProfile(slot0, slot1)
	if not slot1.IsLoadSuccess then
		logError("CameraMgr:_onLoadedUrpProfile load fail: " .. slot1.ResPath)
	else
		slot1:Retain()

		slot0._urpProfileAsset = slot1.EngineAsset
		UnityEngine.Rendering.GraphicsSettings.renderPipelineAsset = slot0._urpProfileAsset
	end

	loadAbAsset(uv0, true, slot0._onLoadedCamera, slot0)
end

function slot0.initCameraWithCameraRoot(slot0, slot1, slot2, slot3)
	slot0._onInitDone = slot1
	slot0._doneCbObj = slot2
	slot0._cameraRootGO = slot3

	loadAbAsset(uv0, true, slot0._onLoadedUrpProfileWithCameraRoot, slot0)
end

function slot0._onLoadedUrpProfileWithCameraRoot(slot0, slot1)
	if not slot1.IsLoadSuccess then
		logError("CameraMgr:_onLoadedUrpProfile load fail: " .. slot1.ResPath)
	else
		slot1:Retain()

		slot0._urpProfileAsset = slot1.EngineAsset
		UnityEngine.Rendering.GraphicsSettings.renderPipelineAsset = slot0._urpProfileAsset
	end

	slot0:_initCameraRootGO()

	if slot0._onInitDone then
		slot0._onInitDone(slot0._doneCbObj)
	end
end

function slot0.setMainCamera(slot0, slot1)
	slot0._mainCamera = slot1:GetComponent("Camera")
	slot0._mainCameraGO = slot1
	slot0._mainCameraTrs = slot1.transform
end

function slot0.setUICamera(slot0, slot1)
	slot0._uiCamera = slot1:GetComponent("Camera")
	slot0._uiCameraGO = slot1
	slot0._uiCameraTrs = slot1.transform
	ViewMgr.instance:getUICanvas().worldCamera = slot0._uiCamera
end

function slot0.setUnitCamera(slot0, slot1)
	slot0._unitCamera = slot1:GetComponent("Camera")
	slot0._unitCameraGO = slot1
	slot0._unitCameraTrs = slot1.transform
end

function slot0.setOrthCamera(slot0, slot1)
	slot0._orthCamera = slot1:GetComponent("Camera")
	slot0._orthCameraGO = slot1
	slot0._orthCameraTrs = slot1.transform
end

function slot0.setSubCamera(slot0, slot1)
	slot0._subCamera = slot1:GetComponent("Camera")
	slot0._subCameraGO = slot1
	slot0._subCameraTrs = slot1.transform
end

function slot0.setVirtualCamera(slot0, slot1)
	slot0._virtualCameraGO = slot1
	slot0._virtualCameraTrs = slot1.transform
	slot0._virtualCameraList = {}

	for slot6, slot7 in ipairs({
		"set1/vcam1/CM_vcam1",
		"set1/vcam2/CM_vcam2",
		"set2/vcam3/CM_vcam3",
		"set2/vcam4/CM_vcam4"
	}) do
		if gohelper.findChildComponent(slot0._virtualCameraGO, slot7, typeof(Cinemachine.CinemachineVirtualCamera)) then
			table.insert(slot0._virtualCameraList, slot8)
		end
	end

	slot0._virtualCameraSets = {
		gohelper.findChild(slot1, "set1"),
		gohelper.findChild(slot1, "set2")
	}
end

function slot0.switchVirtualCamera(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._virtualCameraSets) do
		slot6.name = slot5 == slot1 and "set" .. slot1 or "disableSet"

		gohelper.setActive(slot6, slot5 == slot1)
	end
end

function slot0.setSceneCameraActive(slot0, slot1, slot2)
	if not slot0._unitCameraGO then
		return
	end

	slot0._showUnitCameraKeyDict[slot2] = slot1 and true or false
	slot3 = true

	for slot7, slot8 in pairs(slot0._showUnitCameraKeyDict) do
		if not slot8 then
			slot3 = false

			break
		end
	end

	gohelper.setActive(slot0._unitCameraGO, slot3)
end

function slot0.setOrthCameraActive(slot0, slot1)
	gohelper.setActive(slot0._orthCameraGO, slot1)
end

function slot0.getCameraRootGO(slot0)
	return slot0._cameraRootGO
end

function slot0.getCameraRootAnimator(slot0)
	if slot0._cameraRootAnimatorPlayer then
		slot0._cameraRootAnimatorPlayer:Stop()
	elseif SLFramework.FrameworkSettings.IsEditor and slot0._cameraRootGO:GetComponent(typeof(SLFramework.AnimatorPlayer)) then
		logError("CameraMgr要通过getCameraRootAnimatorPlayer获得AnimatorPlayer")
	end

	if not slot0._cameraRootAnimator then
		slot0._cameraRootAnimator = gohelper.onceAddComponent(slot0._cameraRootGO, typeof(UnityEngine.Animator))
	end

	return slot0._cameraRootAnimator
end

function slot0.getCameraRootAnimatorPlayer(slot0)
	slot0._cameraRootAnimatorPlayer = slot0._cameraRootAnimatorPlayer or SLFramework.AnimatorPlayer.Get(slot0._cameraRootGO)

	return slot0._cameraRootAnimatorPlayer
end

function slot0.hasCameraRootAnimatorPlayer(slot0)
	return slot0._cameraRootAnimatorPlayer ~= nil
end

function slot0.getCameraTraceGO(slot0)
	return slot0._cameraTraceGO
end

function slot0.getCameraTrace(slot0)
	return slot0._cameraTrace
end

function slot0.getCameraShake(slot0)
	return slot0._cameraShake
end

function slot0.getFocusTrs(slot0)
	return slot0._focusTrs
end

function slot0.getMainCamera(slot0)
	return slot0._mainCamera
end

function slot0.getMainCameraGO(slot0)
	return slot0._mainCameraGO
end

function slot0.getMainCameraTrs(slot0)
	return slot0._mainCameraTrs
end

function slot0.getUICamera(slot0)
	return slot0._uiCamera
end

function slot0.getUICameraGO(slot0)
	return slot0._uiCameraGO
end

function slot0.getUICameraTrs(slot0)
	return slot0._uiCameraTrs
end

function slot0.getUnitCamera(slot0)
	return slot0._unitCamera
end

function slot0.getUnitCameraGO(slot0)
	return slot0._unitCameraGO
end

function slot0.getUnitCameraTrs(slot0)
	return slot0._unitCameraTrs
end

function slot0.getOrthCamera(slot0)
	return slot0._orthCamera
end

function slot0.getOrthCameraGO(slot0)
	return slot0._orthCameraGO
end

function slot0.getSubCamera(slot0)
	return slot0._subCamera
end

function slot0.getSubCameraGO(slot0)
	return slot0._subCameraGO
end

function slot0.getSubCameraTrs(slot0)
	return slot0._subCameraTrs
end

function slot0.getSceneRoot(slot0)
	return slot0._sceneRootGO
end

function slot0.getSceneTransform(slot0)
	return slot0._sceneTransform
end

function slot0.getVirtualCamera(slot0, slot1, slot2)
	return slot0._virtualCameraList[(slot1 - 1) * 2 + slot2]
end

function slot0.getVirtualCameras(slot0)
	return slot0._virtualCameraList
end

function slot0.getVirtualCameraGO(slot0)
	return slot0._virtualCameraGO
end

function slot0.setVirtualCameraChildActive(slot0, slot1, slot2)
	if not slot0._virtualCameraGO then
		return
	end

	gohelper.setActive(gohelper.findChild(slot0._virtualCameraGO, slot2), slot1)
end

function slot0.getVirtualCameraTrs(slot0)
	return slot0._virtualCameraTrs
end

function slot0.setRenderScale(slot0, slot1)
	if slot0._urpProfileAsset then
		logNormal("CameraMgr:setRenderScale scale = " .. slot1)

		slot0._urpProfileAsset.renderScale = slot1
	end
end

function slot0.setRenderMSAACount(slot0, slot1)
	if slot0._urpProfileAsset then
		logNormal("CameraMgr:setRenderMSAACount count = " .. slot1)

		slot0._urpProfileAsset.msaaSampleCount = slot1
	end
end

function slot0.getRenderScale(slot0)
	if slot0._urpProfileAsset then
		return slot0._urpProfileAsset.renderScale
	end
end

slot0.instance = slot0.New()

return slot0
