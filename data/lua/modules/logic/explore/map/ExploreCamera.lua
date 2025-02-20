module("modules.logic.explore.map.ExploreCamera", package.seeall)

slot0 = class("ExploreCamera", LuaCompBase)
slot1 = 3
slot2 = 4

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._everyFrameCheckRotate, slot0)

	if slot0._clipObjs then
		for slot4, slot5 in pairs(slot0._clipObjs) do
			slot5:clear()
		end

		slot0._clipObjs = nil
	end

	if slot0._cameraComp then
		slot0._cameraComp.transparencySortMode = slot0._lastTransparencySortMode
		slot0._cameraComp = nil
	end

	slot0._nowCameraType = nil

	if slot0._animComp and slot0._animComp.runtimeAnimatorController == slot0._animatorInst then
		slot0._animComp:Play(0, 0, 1)
		slot0._animComp:Update(0)

		slot0._animComp.runtimeAnimatorController = nil
		slot0._animComp.enabled = false
	end

	slot0._animComp = nil
	slot0._animatorInst = nil
end

function slot0.setMap(slot0, slot1)
	slot0._map = slot1
end

function slot0.initHeroPos(slot0)
	if ExploreMapModel.instance:getNode(ExploreHelper.getKey(slot0._map:getHeroPos())) and slot1.cameraId ~= uv0 then
		slot0:setCameraCOType(slot1.cameraId, true)
		slot0._cameraComp:applyDirectly()
	end

	if ExploreModel.instance.isFirstEnterMap == ExploreEnum.EnterMode.First then
		slot0._animatorInst = slot0._map:getLoader():getAssetItem(ExploreConstValue.EntryCameraCtrlPath):GetResource(ExploreConstValue.EntryCameraCtrlPath)
		slot0._animComp = CameraMgr.instance:getCameraRootAnimator()
		slot0._animComp.enabled = true
		slot0._animComp.runtimeAnimatorController = nil
		slot0._animComp.runtimeAnimatorController = slot0._animatorInst

		slot0._animComp:Update(0)

		slot0._animComp.enabled = false
	end
end

function slot0.beginCameraAnim(slot0)
	if slot0._animComp then
		slot0._animComp.enabled = true
	end

	slot0:setCameraPos()
end

function slot0.init(slot0, slot1)
	slot0._mapGo = slot1

	slot0:initCamera()

	slot0._occlusionLayerMask = LayerMask.GetMask("SceneOpaqueOcclusionClip")
	slot0._clipObjs = {}
	slot0._cameraCODefault = lua_camera.configDict[uv0]
	slot0._cameraCOHight = lua_camera.configDict[uv1]
	slot0._scale = 0
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(ExploreController.instance, ExploreEvent.OnScaleMap, slot0.setScale, slot0)
	slot0:addEventCb(ExploreController.instance, ExploreEvent.OnDeltaScaleMap, slot0.deltaScale, slot0)
	slot0:addEventCb(ExploreController.instance, ExploreEvent.OnChangeCameraCO, slot0.setCameraCOType, slot0)
	slot0:addEventCb(ExploreController.instance, ExploreEvent.SetCameraPos, slot0.setCameraPos, slot0)
	slot0:addEventCb(ExploreController.instance, ExploreEvent.HeroFirstAnimEnd, slot0.beginCameraAnim, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0:removeEventCb(ExploreController.instance, ExploreEvent.OnScaleMap, slot0.setScale, slot0)
	slot0:removeEventCb(ExploreController.instance, ExploreEvent.OnDeltaScaleMap, slot0.deltaScale, slot0)
	slot0:removeEventCb(ExploreController.instance, ExploreEvent.OnChangeCameraCO, slot0.setCameraCOType, slot0)
	slot0:removeEventCb(ExploreController.instance, ExploreEvent.SetCameraPos, slot0.setCameraPos, slot0)
	slot0:removeEventCb(ExploreController.instance, ExploreEvent.HeroFirstAnimEnd, slot0.beginCameraAnim, slot0)
end

function slot0.getCamera(slot0)
	return slot0._camera
end

function slot0.getCameraGO(slot0)
	return slot0._cameraGo
end

function slot0.getMainCameraTrs(slot0)
	return slot0._cameraTrs
end

function slot0.getRotation(slot0)
	return transformhelper.getLocalRotation(slot0._cameraTrs.parent)
end

function slot0.initCamera(slot0)
	slot0._cameraComp = GameSceneMgr.instance:getCurScene().camera
	slot0._camera = CameraMgr.instance:getMainCamera()

	slot0._cameraComp:setCameraTraceEnable(true)

	slot0._cameraGo = CameraMgr.instance:getMainCameraGO()
	slot0._cameraTrs = CameraMgr.instance:getMainCameraTrs()
	slot0._lastTransparencySortMode = slot0._cameraComp.transparencySortMode
	slot0._cameraComp.transparencySortMode = UnityEngine.TransparencySortMode.Perspective
end

function slot0.deltaScale(slot0, slot1)
	slot0:setScale(slot0._scale + slot1)
end

function slot0.setScale(slot0, slot1)
	slot0._scale = Mathf.Clamp(slot1, 0, 1)
	slot0._cameraCODefault = lua_camera.configDict[uv0]
	slot0._cameraCOHight = lua_camera.configDict[uv1]

	slot0._cameraComp:setFov(slot0._cameraCODefault.fov + (slot0._cameraCOHight.fov - slot0._cameraCODefault.fov) * slot0._scale)
end

function slot0._everyFrameCheckRotate(slot0)
	slot2, slot3, slot4 = slot0:getRotation()

	if not lua_camera.configDict[slot0._nowCameraType] or slot3 == slot1.yaw then
		TaskDispatcher.cancelTask(slot0._everyFrameCheckRotate, slot0)
	end

	ExploreMapModel.instance.nowMapRotate = slot3

	ExploreController.instance:dispatchEvent(ExploreEvent.MapRotate)
end

function slot0.setCameraCOType(slot0, slot1, slot2)
	if not slot1 or slot1 == 0 then
		slot1 = uv0
	end

	if slot0._nowCameraType == slot1 then
		return
	end

	if not slot2 then
		if lua_camera.configDict[slot1].yaw ~= ExploreMapModel.instance.nowMapRotate then
			TaskDispatcher.runRepeat(slot0._everyFrameCheckRotate, slot0, 0.05, -1)
		end
	else
		ExploreMapModel.instance.nowMapRotate = slot3.yaw

		ExploreController.instance:dispatchEvent(ExploreEvent.MapRotate)
	end

	slot0._nowCameraType = slot1
	slot0._scale = (slot3.fov - slot0._cameraCODefault.fov) / (slot0._cameraCOHight.fov - slot0._cameraCODefault.fov)

	slot0._cameraComp:resetParam(slot3)
	slot0._cameraComp:setFocus(slot0._targetPos.x, slot0._targetPos.y, slot0._targetPos.z)
	slot0._cameraComp:setFov(slot0._scale * (slot0._cameraCOHight.fov - slot0._cameraCODefault.fov) + slot0._cameraCODefault.fov)
end

function slot0.setCameraPos(slot0, slot1)
	if not (slot1 or slot0._targetPos) then
		return
	end

	slot0._targetPos = slot1

	slot0._cameraComp:setFocus(slot1.x, slot1.y, slot1.z)
	slot0:_raycast(slot0._targetPos)
end

function slot0._raycast(slot0, slot1)
	slot2 = slot0._cameraTrs.position
	slot8 = Vector3.Distance(slot2, slot1)
	slot9 = slot0._occlusionLayerMask
	slot4 = UnityEngine.Physics.RaycastAll(slot2, slot1 - slot2, slot8, slot9)

	for slot8, slot9 in pairs(slot0._clipObjs) do
		slot9:markClip(false)
	end

	for slot8 = 0, slot4.Length - 1 do
		if not slot0._clipObjs[slot4[slot8].transform] then
			slot0._clipObjs[slot10] = ExploreMapClipObj.New()

			slot0._clipObjs[slot10]:init(slot10)
		end

		slot0._clipObjs[slot10]:markClip(true)
	end

	for slot8, slot9 in pairs(slot0._clipObjs) do
		slot9:checkNow()
	end
end

return slot0
