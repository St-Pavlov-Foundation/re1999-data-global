module("modules.logic.explore.map.ExploreCamera", package.seeall)

local var_0_0 = class("ExploreCamera", LuaCompBase)
local var_0_1 = 3
local var_0_2 = 4

function var_0_0.onDestroy(arg_1_0)
	TaskDispatcher.cancelTask(arg_1_0._everyFrameCheckRotate, arg_1_0)

	if arg_1_0._clipObjs then
		for iter_1_0, iter_1_1 in pairs(arg_1_0._clipObjs) do
			iter_1_1:clear()
		end

		arg_1_0._clipObjs = nil
	end

	if arg_1_0._cameraComp then
		arg_1_0._cameraComp.transparencySortMode = arg_1_0._lastTransparencySortMode
		arg_1_0._cameraComp = nil
	end

	arg_1_0._nowCameraType = nil

	if arg_1_0._animComp and arg_1_0._animComp.runtimeAnimatorController == arg_1_0._animatorInst then
		arg_1_0._animComp:Play(0, 0, 1)
		arg_1_0._animComp:Update(0)

		arg_1_0._animComp.runtimeAnimatorController = nil
		arg_1_0._animComp.enabled = false
	end

	arg_1_0._animComp = nil
	arg_1_0._animatorInst = nil
end

function var_0_0.setMap(arg_2_0, arg_2_1)
	arg_2_0._map = arg_2_1
end

function var_0_0.initHeroPos(arg_3_0)
	local var_3_0 = ExploreMapModel.instance:getNode(ExploreHelper.getKey(arg_3_0._map:getHeroPos()))

	if var_3_0 and var_3_0.cameraId ~= var_0_1 then
		arg_3_0:setCameraCOType(var_3_0.cameraId, true)
		arg_3_0._cameraComp:applyDirectly()
	end

	if ExploreModel.instance.isFirstEnterMap == ExploreEnum.EnterMode.First then
		arg_3_0._animatorInst = arg_3_0._map:getLoader():getAssetItem(ExploreConstValue.EntryCameraCtrlPath):GetResource(ExploreConstValue.EntryCameraCtrlPath)
		arg_3_0._animComp = CameraMgr.instance:getCameraRootAnimator()
		arg_3_0._animComp.enabled = true
		arg_3_0._animComp.runtimeAnimatorController = nil
		arg_3_0._animComp.runtimeAnimatorController = arg_3_0._animatorInst

		arg_3_0._animComp:Update(0)

		arg_3_0._animComp.enabled = false
	end
end

function var_0_0.beginCameraAnim(arg_4_0)
	if arg_4_0._animComp then
		arg_4_0._animComp.enabled = true
	end

	arg_4_0:setCameraPos()
end

function var_0_0.init(arg_5_0, arg_5_1)
	arg_5_0._mapGo = arg_5_1

	arg_5_0:initCamera()

	arg_5_0._occlusionLayerMask = LayerMask.GetMask("SceneOpaqueOcclusionClip")
	arg_5_0._clipObjs = {}
	arg_5_0._cameraCODefault = lua_camera.configDict[var_0_1]
	arg_5_0._cameraCOHight = lua_camera.configDict[var_0_2]
	arg_5_0._scale = 0
end

function var_0_0.addEventListeners(arg_6_0)
	arg_6_0:addEventCb(ExploreController.instance, ExploreEvent.OnScaleMap, arg_6_0.setScale, arg_6_0)
	arg_6_0:addEventCb(ExploreController.instance, ExploreEvent.OnDeltaScaleMap, arg_6_0.deltaScale, arg_6_0)
	arg_6_0:addEventCb(ExploreController.instance, ExploreEvent.OnChangeCameraCO, arg_6_0.setCameraCOType, arg_6_0)
	arg_6_0:addEventCb(ExploreController.instance, ExploreEvent.SetCameraPos, arg_6_0.setCameraPos, arg_6_0)
	arg_6_0:addEventCb(ExploreController.instance, ExploreEvent.HeroFirstAnimEnd, arg_6_0.beginCameraAnim, arg_6_0)
end

function var_0_0.removeEventListeners(arg_7_0)
	arg_7_0:removeEventCb(ExploreController.instance, ExploreEvent.OnScaleMap, arg_7_0.setScale, arg_7_0)
	arg_7_0:removeEventCb(ExploreController.instance, ExploreEvent.OnDeltaScaleMap, arg_7_0.deltaScale, arg_7_0)
	arg_7_0:removeEventCb(ExploreController.instance, ExploreEvent.OnChangeCameraCO, arg_7_0.setCameraCOType, arg_7_0)
	arg_7_0:removeEventCb(ExploreController.instance, ExploreEvent.SetCameraPos, arg_7_0.setCameraPos, arg_7_0)
	arg_7_0:removeEventCb(ExploreController.instance, ExploreEvent.HeroFirstAnimEnd, arg_7_0.beginCameraAnim, arg_7_0)
end

function var_0_0.getCamera(arg_8_0)
	return arg_8_0._camera
end

function var_0_0.getCameraGO(arg_9_0)
	return arg_9_0._cameraGo
end

function var_0_0.getMainCameraTrs(arg_10_0)
	return arg_10_0._cameraTrs
end

function var_0_0.getRotation(arg_11_0)
	return transformhelper.getLocalRotation(arg_11_0._cameraTrs.parent)
end

function var_0_0.initCamera(arg_12_0)
	arg_12_0._cameraComp = GameSceneMgr.instance:getCurScene().camera
	arg_12_0._camera = CameraMgr.instance:getMainCamera()

	arg_12_0._cameraComp:setCameraTraceEnable(true)

	arg_12_0._cameraGo = CameraMgr.instance:getMainCameraGO()
	arg_12_0._cameraTrs = CameraMgr.instance:getMainCameraTrs()
	arg_12_0._lastTransparencySortMode = arg_12_0._cameraComp.transparencySortMode
	arg_12_0._cameraComp.transparencySortMode = UnityEngine.TransparencySortMode.Perspective
end

function var_0_0.deltaScale(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0._scale + arg_13_1

	arg_13_0:setScale(var_13_0)
end

function var_0_0.setScale(arg_14_0, arg_14_1)
	arg_14_0._scale = Mathf.Clamp(arg_14_1, 0, 1)
	arg_14_0._cameraCODefault = lua_camera.configDict[var_0_1]
	arg_14_0._cameraCOHight = lua_camera.configDict[var_0_2]

	local var_14_0 = arg_14_0._cameraCODefault.fov + (arg_14_0._cameraCOHight.fov - arg_14_0._cameraCODefault.fov) * arg_14_0._scale

	arg_14_0._cameraComp:setFov(var_14_0)
end

function var_0_0._everyFrameCheckRotate(arg_15_0)
	local var_15_0 = lua_camera.configDict[arg_15_0._nowCameraType]
	local var_15_1, var_15_2, var_15_3 = arg_15_0:getRotation()

	if not var_15_0 or var_15_2 == var_15_0.yaw then
		TaskDispatcher.cancelTask(arg_15_0._everyFrameCheckRotate, arg_15_0)
	end

	ExploreMapModel.instance.nowMapRotate = var_15_2

	ExploreController.instance:dispatchEvent(ExploreEvent.MapRotate)
end

function var_0_0.setCameraCOType(arg_16_0, arg_16_1, arg_16_2)
	if not arg_16_1 or arg_16_1 == 0 then
		arg_16_1 = var_0_1
	end

	if arg_16_0._nowCameraType == arg_16_1 then
		return
	end

	local var_16_0 = lua_camera.configDict[arg_16_1]

	if not arg_16_2 then
		if var_16_0.yaw ~= ExploreMapModel.instance.nowMapRotate then
			TaskDispatcher.runRepeat(arg_16_0._everyFrameCheckRotate, arg_16_0, 0.05, -1)
		end
	else
		ExploreMapModel.instance.nowMapRotate = var_16_0.yaw

		ExploreController.instance:dispatchEvent(ExploreEvent.MapRotate)
	end

	arg_16_0._nowCameraType = arg_16_1
	arg_16_0._scale = (var_16_0.fov - arg_16_0._cameraCODefault.fov) / (arg_16_0._cameraCOHight.fov - arg_16_0._cameraCODefault.fov)

	local var_16_1 = arg_16_0._scale * (arg_16_0._cameraCOHight.fov - arg_16_0._cameraCODefault.fov) + arg_16_0._cameraCODefault.fov

	arg_16_0._cameraComp:resetParam(var_16_0)
	arg_16_0._cameraComp:setFocus(arg_16_0._targetPos.x, arg_16_0._targetPos.y, arg_16_0._targetPos.z)
	arg_16_0._cameraComp:setFov(var_16_1)
end

function var_0_0.setCameraPos(arg_17_0, arg_17_1)
	arg_17_1 = arg_17_1 or arg_17_0._targetPos

	if not arg_17_1 then
		return
	end

	arg_17_0._targetPos = arg_17_1

	arg_17_0._cameraComp:setFocus(arg_17_1.x, arg_17_1.y, arg_17_1.z)
	arg_17_0:_raycast(arg_17_0._targetPos)
end

function var_0_0._raycast(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0._cameraTrs.position
	local var_18_1 = Vector3.Distance(var_18_0, arg_18_1)
	local var_18_2 = UnityEngine.Physics.RaycastAll(var_18_0, arg_18_1 - var_18_0, var_18_1, arg_18_0._occlusionLayerMask)

	for iter_18_0, iter_18_1 in pairs(arg_18_0._clipObjs) do
		iter_18_1:markClip(false)
	end

	for iter_18_2 = 0, var_18_2.Length - 1 do
		local var_18_3 = var_18_2[iter_18_2].transform

		if not arg_18_0._clipObjs[var_18_3] then
			arg_18_0._clipObjs[var_18_3] = ExploreMapClipObj.New()

			arg_18_0._clipObjs[var_18_3]:init(var_18_3)
		end

		arg_18_0._clipObjs[var_18_3]:markClip(true)
	end

	for iter_18_3, iter_18_4 in pairs(arg_18_0._clipObjs) do
		iter_18_4:checkNow()
	end
end

return var_0_0
