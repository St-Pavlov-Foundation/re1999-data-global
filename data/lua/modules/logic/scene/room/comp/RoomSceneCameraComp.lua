module("modules.logic.scene.room.comp.RoomSceneCameraComp", package.seeall)

slot0 = class("RoomSceneCameraComp", BaseSceneComp)

function slot0.onInit(slot0)
	slot0.cameraGO = nil
	slot0.camera = nil
	slot0._moveDistance = 2
end

function slot0._setCPMinMaxStr(slot0, slot1, slot2, slot3, slot4)
	slot0:_setCPMinMax(slot1, slot2, slot3, string.splitToNumber(slot4, "#"))
end

function slot0._setCPMinMax(slot0, slot1, slot2, slot3, slot4)
	slot2[slot1] = slot4[1]
	slot3[slot1] = slot4[2]
end

function slot0._setFogMinMax(slot0, slot1, slot2, slot3, slot4)
	slot5 = GameUtil.splitString2(slot4.fogRangeXYZW, true)
	slot6 = GameUtil.splitString2(slot4.fogNearColorRGBA, true)
	slot7 = GameUtil.splitString2(slot4.fogFarColorRGBA, true)

	for slot13 = 1, 2 do
		(slot13 == 1 and slot2 or slot3)[slot1] = {
			maxParticles = string.splitToNumber(slot4.fogParticles, "#")[slot13],
			centerY = slot5[slot13][1],
			height = slot5[slot13][2],
			fogRangeZ = slot5[slot13][3],
			fogRangeW = slot5[slot13][4],
			nearColorR = slot6[slot13][1],
			nearColorG = slot6[slot13][2],
			nearColorB = slot6[slot13][3],
			nearColorA = slot6[slot13][4],
			farColorR = slot7[slot13][1],
			farColorG = slot7[slot13][2],
			farColorB = slot7[slot13][3],
			farColorA = slot7[slot13][4],
			fogViewType = string.splitToNumber(slot4.fogViewType, "#")[slot13]
		}
	end
end

function slot0._initCameraParam(slot0)
	slot0._angleMin = {}
	slot0._angleMax = {}
	slot0._distanceMin = {}
	slot0._distanceMax = {}
	slot0._bendingAmountMin = {}
	slot0._bendingAmountMax = {}
	slot0._blurMin = {}
	slot0._blurMax = {}
	slot0._fogParamMin = {}
	slot0._fogParamMax = {}
	slot0._offsetHorizonMin = {}
	slot0._offsetHorizonMax = {}
	slot0._oceanFogMin = {}
	slot0._oceanFogMax = {}
	slot0._lightRangeMin = {}
	slot0._lightRangeMax = {}
	slot0._lightOffsetMin = {}
	slot0._lightOffsetMax = {}
	slot0._shadowOffsetMin = {}
	slot0._shadowOffsetMax = {}
	slot0._touchMoveSpeedMin = {}
	slot0._touchMoveSpeedMax = {}
	slot0._zoomInitValue = {}
	slot0._lightMinMin = {}
	slot0._lightMinMax = {}
	slot0._offsetHeightMap = {}
	slot0._camerClipPlaneMin = {}
	slot0._camerClipPlaneMax = {}
	slot0._isShadowHideMap = {}

	for slot5, slot6 in pairs(RoomEnum.CameraState) do
		slot0._offsetHeightMap[slot6] = 0

		if RoomConfig.instance:getCameraParamByStateId(slot6, RoomModel.instance:getGameMode()) then
			slot0:_setCPMinMaxStr(slot6, slot0._angleMin, slot0._angleMax, slot7.angle)
			slot0:_setCPMinMaxStr(slot6, slot0._distanceMin, slot0._distanceMax, slot7.distance)
			slot0:_setCPMinMaxStr(slot6, slot0._bendingAmountMin, slot0._bendingAmountMax, slot7.bendingAmount)
			slot0:_setCPMinMaxStr(slot6, slot0._touchMoveSpeedMin, slot0._touchMoveSpeedMax, slot7.touchMoveSpeed)
			slot0:_setCPMinMaxStr(slot6, slot0._blurMin, slot0._blurMax, slot7.blur)
			slot0:_setCPMinMaxStr(slot6, slot0._offsetHorizonMin, slot0._offsetHorizonMax, slot7.offsetHorizon)
			slot0:_setCPMinMaxStr(slot6, slot0._oceanFogMin, slot0._oceanFogMax, slot7.oceanFog)
			slot0:_setCPMinMaxStr(slot6, slot0._lightMinMin, slot0._lightMinMax, slot7.lightMin)
			slot0:_setFogMinMax(slot6, slot0._fogParamMin, slot0._fogParamMax, slot7)
			slot0:_setCPMinMax(slot6, slot0._shadowOffsetMin, slot0._shadowOffsetMax, GameUtil.splitString2(slot7.shadowOffsetXYZW, true))
			slot0:_setCPMinMax(slot6, slot0._lightRangeMin, slot0._lightRangeMax, {
				0.5,
				0.5
			})
			slot0:_setCPMinMax(slot6, slot0._lightOffsetMin, slot0._lightOffsetMax, {
				0.5,
				0.5
			})
			slot0:_setCPMinMax(slot6, slot0._camerClipPlaneMin, slot0._camerClipPlaneMax, {
				0.01,
				100
			})

			slot0._zoomInitValue[slot6] = slot7.zoom * 0.001
			slot0._isShadowHideMap[slot6] = true
		else
			logError(string.format("小屋相机镜头配置缺失[RoomEnum.CameraState.%s]:【export_镜头参数】state:%s", slot5, slot6))
		end
	end

	for slot5, slot6 in ipairs(RoomEnum.CameraOverlooks) do
		slot0._camerClipPlaneMin[slot6] = 0.3
		slot0._isShadowHideMap[slot6] = false
	end

	slot0._cameraSwitchAudioDict = {
		[RoomEnum.CameraState.Overlook] = {
			[RoomEnum.CameraState.Normal] = AudioEnum.Room.play_ui_home_lens_push,
			[RoomEnum.CameraState.Character] = AudioEnum.Room.play_ui_home_lens_push,
			[RoomEnum.CameraState.Manufacture] = AudioEnum.Room.play_ui_home_lens_push,
			[RoomEnum.CameraState.OverlookAll] = AudioEnum.Room.play_ui_home_lens_pull
		},
		[RoomEnum.CameraState.OverlookAll] = {
			[RoomEnum.CameraState.Normal] = AudioEnum.Room.play_ui_home_lens_push,
			[RoomEnum.CameraState.Character] = AudioEnum.Room.play_ui_home_lens_push,
			[RoomEnum.CameraState.Overlook] = AudioEnum.Room.play_ui_home_lens_push,
			[RoomEnum.CameraState.Manufacture] = AudioEnum.Room.play_ui_home_lens_push
		},
		[RoomEnum.CameraState.Normal] = {
			[RoomEnum.CameraState.Overlook] = AudioEnum.Room.play_ui_home_lens_pull,
			[RoomEnum.CameraState.OverlookAll] = AudioEnum.Room.play_ui_home_lens_pull
		},
		[RoomEnum.CameraState.Character] = {
			[RoomEnum.CameraState.Overlook] = AudioEnum.Room.play_ui_home_lens_pull
		},
		[RoomEnum.CameraState.Manufacture] = {
			[RoomEnum.CameraState.Overlook] = AudioEnum.Room.play_ui_home_lens_pull
		}
	}
	slot0._cameraStateInEditYDict = {
		[RoomEnum.CameraState.Normal] = 0.3,
		[RoomEnum.CameraState.Manufacture] = 0.3
	}
	slot2 = {}

	for slot7 = 1, 6 do
		table.insert(slot2, HexMath.hexToPosition(HexPoint.directions[slot7] * CommonConfig.instance:getConstNum(ConstEnum.RoomMapMaxRadius), RoomBlockEnum.BlockSize))
	end

	slot0._editModeConvexHull = RoomCameraHelper.getConvexHull(slot2)
end

function slot0.setChangeCameraParamsById(slot0, slot1, slot2)
	if RoomEnum.ChangeCameraParamDict[slot1] and (RoomConfig.instance:getCharacterBuildingInteractCameraConfig(slot2) or RoomConfig.instance:getCameraParamByStateId(slot1, RoomModel.instance:getGameMode())) then
		slot0:_setCPMinMaxStr(slot1, slot0._angleMin, slot0._angleMax, slot3.angle)
		slot0:_setCPMinMaxStr(slot1, slot0._distanceMin, slot0._distanceMax, slot3.distance)

		slot4 = slot3.focusXYZ and string.splitToNumber(slot3.focusXYZ, "#")
		slot0._offsetHeightMap[slot1] = slot4 and slot4[2] or 0
	end
end

function slot0.setCharacterbuildingInteractionById(slot0, slot1)
	slot0:setChangeCameraParamsById(RoomEnum.CameraState.InteractionCharacterBuilding, slot1)
end

function slot0.init(slot0, slot1, slot2)
	TaskDispatcher.runRepeat(slot0._onUpdate, slot0, 0)
	slot0:_initCameraParam()
	slot0:_initCamera()

	slot0._scene = slot0:getCurScene()
	slot0._cameraParam = nil
	slot0._realCameraParam = nil
	slot0._tempRealCameraParam = nil
	slot0._offsetY = 0
	slot0.cameraGO = CameraMgr.instance:getMainCameraGO()
	slot0.cameraTrs = CameraMgr.instance:getMainCameraTrs()
	slot0.camera = CameraMgr.instance:getMainCamera()
	slot0.orthCameraGO = CameraMgr.instance:getOrthCameraGO()
	slot0.orthCamera = CameraMgr.instance:getOrthCamera()

	RenderPipelineSetting.SetCameraRenderingLayerMask(slot0.orthCamera, 128)
	PostProcessingMgr.setCameraLayer(slot0.orthCamera, "Scene", true)
	PostProcessingMgr.setCameraLayer(slot0.orthCamera, "SceneOpaque", true)
	PostProcessingMgr.setCameraLayer(slot0.orthCamera, "CullOnLowQuality", true)
	PostProcessingMgr.setCameraLayer(slot0.orthCamera, "CullByDistance", true)
	PostProcessingMgr.setCameraLayer(slot0.orthCamera, "SceneOrthogonal", false)
	PostProcessingMgr.setCameraLayer(slot0.orthCamera, "SceneOrthogonalOpaque", false)

	slot0.orthCameraTrs = slot0.orthCameraGO.transform
	slot0.orthCameraTrs.position = Vector3(0, 3.5, 0)
	slot0.orthCameraTrs.rotation = Quaternion.Euler(90, 0, 0)

	slot0:_setCanvasCamera()
	slot0:resetTransform()
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
end

function slot0._initCamera(slot0)
	gohelper.setActive(CameraMgr.instance:getVirtualCameraGO(), false)
	transformhelper.setLocalPos(CameraMgr.instance:getMainCameraTrs(), 0, 0, 0)
	transformhelper.setLocalRotation(CameraMgr.instance:getMainCameraTrs(), 0, 0, 0)
end

function slot0.onSceneStart(slot0, slot1, slot2)
	slot0:_onScreenResize(UnityEngine.Screen.width, UnityEngine.Screen.height)
end

function slot0.onSceneClose(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)

	if slot0._tweenOffsetYId then
		slot0._scene.tween:killById(slot0._tweenOffsetYId)

		slot0._tweenOffsetYId = nil
	end

	TaskDispatcher.cancelTask(slot0._onUpdate, slot0)
	TaskDispatcher.cancelTask(slot0._forceUpdataTransform, slot0)
	UIBlockMgr.instance:endBlock(UIBlockKey.RoomCameraTweening)

	if slot0._tweenId then
		slot0._scene.tween:killById(slot0._tweenId)

		slot0._tweenId = nil
	end

	transformhelper.setPos(slot0.cameraTrs, 0, 0, 0)
	transformhelper.setLocalRotation(slot0.cameraTrs, 0, 0, 0)
	RenderPipelineSetting.SetCameraRenderingLayerMask(slot0.orthCamera, 1)
	PostProcessingMgr.setCameraLayer(slot0.orthCamera, "Scene", false)
	PostProcessingMgr.setCameraLayer(slot0.orthCamera, "SceneOpaque", false)
	PostProcessingMgr.setCameraLayer(slot0.orthCamera, "CullOnLowQuality", false)
	PostProcessingMgr.setCameraLayer(slot0.orthCamera, "CullByDistance", false)
	PostProcessingMgr.setCameraLayer(slot0.orthCamera, "SceneOrthogonal", true)
	PostProcessingMgr.setCameraLayer(slot0.orthCamera, "SceneOrthogonalOpaque", true)

	slot0.orthCamera = nil
	slot0._cameraParam = nil
	slot0._realCameraParam = nil
	slot0._tempRealCameraParam = nil
	slot0.cameraGO = nil
	slot0.cameraTrs = nil
	slot0.camera = nil

	slot0:_hideOrthCamera()

	slot0.orthCameraGO = nil
	slot0.orthCameraTrs = nil

	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
end

function slot0.move(slot0, slot1, slot2)
	slot0:moveTo(slot0._cameraParam.focusX + slot1, slot0._cameraParam.focusY + slot2)
end

function slot0.moveTo(slot0, slot1, slot2)
	slot3 = Vector2(slot1, slot2)
	slot4 = nil
	slot5 = RoomCameraHelper.getOffsetPosition(Vector2(slot0._cameraParam.focusX, slot0._cameraParam.focusY), Vector2(slot1, slot2), (not RoomController.instance:isEditMode() or slot0._editModeConvexHull) and RoomMapBlockModel.instance:getConvexHull())
	slot0._cameraParam.focusX = slot5.x
	slot0._cameraParam.focusY = slot5.y
	slot0._realCameraParam = slot0:cameraParamToRealCameraParam(slot0._cameraParam)

	slot0:updateTransform()
end

function slot0.zoom(slot0, slot1)
	slot0:zoomTo(slot0._cameraParam.zoom + slot1)
end

function slot0.zoomTo(slot0, slot1)
	slot0._cameraParam.zoom = Mathf.Clamp(slot1, 0, 1)
	slot0._realCameraParam = slot0:cameraParamToRealCameraParam(slot0._cameraParam)

	slot0:updateTransform()
end

function slot0.rotate(slot0, slot1)
	slot0:rotateTo(slot0._cameraParam.rotate + slot1)
end

function slot0.rotateTo(slot0, slot1)
	slot0._cameraParam.rotate = RoomRotateHelper.getMod(slot1, 2 * Mathf.PI)
	slot0._realCameraParam = slot0:cameraParamToRealCameraParam(slot0._cameraParam)

	slot0:updateTransform()
end

function slot0.getZoomInitValue(slot0, slot1)
	return slot0._zoomInitValue and slot0._zoomInitValue[slot1] or 0.5
end

function slot0.resetTransform(slot0)
	slot0._cameraState = RoomEnum.CameraState.Overlook
	slot0._cameraParam = {
		focusY = 0,
		focusX = 0,
		rotate = 0,
		zoom = slot0:getZoomInitValue(slot0._cameraState)
	}
	slot0._realCameraParam = slot0:cameraParamToRealCameraParam(slot0._cameraParam)
	slot0._savedCameraParam = LuaUtil.deepCopy(slot0._cameraParam)
	slot0._savedCameraState = slot0._cameraState
	slot0._isTweening = false

	UIBlockMgr.instance:endBlock(UIBlockKey.RoomCameraTweening)
	slot0:updateTransform()
	TaskDispatcher.runDelay(slot0._forceUpdataTransform, slot0, 0.0001)
	slot0:_updateCameraClipPlane()
end

function slot0._forceUpdataTransform(slot0)
	slot0:updateTransform(true)
end

function slot0.cameraParamToRealCameraParam(slot0, slot1, slot2)
	slot2 = slot2 or slot0._cameraState
	slot3 = slot0:focusToPos(slot1.zoom, Vector2(slot1.focusX, slot1.focusY), slot1.rotate, slot2, slot1.isPart)

	return {
		zoom = slot1.zoom,
		bendingAmount = slot0:zoomToBendingAmount(slot1.zoom, slot2),
		angle = slot0:zoomToAngle(slot1.zoom, slot2),
		distance = slot0:zoomToDistance(slot1.zoom, slot2),
		blur = slot0:zoomToBlur(slot1.zoom, slot2),
		fogParam = slot0:zoomToFogParam(slot1.zoom, slot2),
		offsetHorizon = slot0:zoomToOffsetHorizon(slot1.zoom, slot2),
		oceanFog = slot0:zoomToOceanFog(slot1.zoom, slot2),
		lightRange = slot0:zoomToLightRange(slot1.zoom, slot2),
		lightOffset = slot0:zoomToLightOffset(slot1.zoom, slot2),
		lightMin = slot0:zoomToLightMin(slot1.zoom, slot2),
		shadowOffset = slot0:zoomToShadowOffset(slot1.zoom, slot2),
		touchMoveSpeed = slot0:zoomToTouchMoveSpeed(slot1.zoom, slot2),
		posX = slot3.x,
		posY = slot3.y,
		rotate = slot1.rotate,
		height = slot0:zoomToOffsetY(slot1.zoom, slot2) + slot0:zoomToHeight(slot1.zoom, Vector2(slot1.focusX, slot1.focusY), slot2, slot1.isPart)
	}
end

function slot0.updateTransform(slot0, slot1)
	slot2 = slot1

	if not slot0._tempRealCameraParam then
		slot2 = true
	else
		for slot6, slot7 in pairs(slot0._realCameraParam) do
			if type(slot7) == "table" then
				for slot11, slot12 in pairs(slot7) do
					if slot12 ~= slot0._tempRealCameraParam[slot6][slot11] then
						slot2 = true

						break
					end
				end
			elseif slot7 ~= slot0._tempRealCameraParam[slot6] then
				slot2 = true
			end

			if slot2 then
				break
			end
		end
	end

	if not slot2 then
		return
	end

	slot0._tempRealCameraParam = LuaUtil.deepCopy(slot0._realCameraParam)
	RoomController.instance.touchMoveSpeed = slot0._realCameraParam.touchMoveSpeed

	slot0._scene.bending:setBendingAmount(slot0._realCameraParam.bendingAmount)
	slot0._scene.bending:setBendingPosition(Vector3(slot0._realCameraParam.posX, 0, slot0._realCameraParam.posY))
	slot0._scene.fog:setFogParam(slot0._realCameraParam.fogParam)
	slot0._scene.bending:setSkylineOffset(slot0._realCameraParam.offsetHorizon)
	slot0._scene.ocean:setOceanFog(slot0._realCameraParam.oceanFog)
	slot0._scene.light:setLightMin(slot0._realCameraParam.lightMin)
	slot0._scene.light:setLightRange(slot0._realCameraParam.lightRange)
	slot0._scene.light:setLightOffset(slot0._realCameraParam.lightOffset)

	slot3 = slot0._realCameraParam.shadowOffset

	slot0._scene.character:setShadowOffset(Vector4(slot3[1], slot3[2], slot3[3], slot3[4]))

	slot4 = slot0._realCameraParam.distance * Mathf.Cos(slot0._realCameraParam.angle)
	slot6 = -Mathf.Sin(slot0._realCameraParam.rotate) * slot4 + slot0._realCameraParam.posX
	slot7 = -Mathf.Cos(slot0._realCameraParam.rotate) * slot4 + slot0._realCameraParam.posY
	slot0._position = Vector3(slot6, math.max(0.11, slot0._realCameraParam.distance * Mathf.Sin(slot0._realCameraParam.angle) + slot0._realCameraParam.height + slot0._offsetY + slot0._scene.cameraFollow:getCameraOffsetY()), slot7)
	slot10 = Mathf.Rad2Deg * slot0._realCameraParam.rotate
	slot0._rotation = Quaternion.Euler(Mathf.Rad2Deg * slot0._realCameraParam.angle, slot10, 0)
	slot0._orthRotation = Quaternion.Euler(90, slot10, 0)
	slot0._inventoryRotation = Quaternion.Euler(0, slot10, 0)

	transformhelper.setPos(slot0.cameraTrs, slot0._position.x, slot0._position.y, slot0._position.z)
	transformhelper.setRotation(slot0.cameraTrs, slot0._rotation.x, slot0._rotation.y, slot0._rotation.z, slot0._rotation.w)
	transformhelper.setPos(slot0._scene.go.virtualCameraTrs, slot0._position.x, slot0._position.y, slot0._position.z)
	slot0:_setPosXZ(slot0._scene.go.virtualCameraXZTrs, slot6, slot7)
	transformhelper.setRotation(slot0._scene.go.virtualCameraTrs, slot0._rotation.x, slot0._rotation.y, slot0._rotation.z, slot0._rotation.w)
	transformhelper.setRotation(slot0.orthCameraTrs, slot0._orthRotation.x, slot0._orthRotation.y, slot0._orthRotation.z, slot0._orthRotation.w)
	transformhelper.setRotation(slot0._scene.go.inventoryRootTrs, slot0._inventoryRotation.x, slot0._inventoryRotation.y, slot0._inventoryRotation.z, slot0._inventoryRotation.w)
	slot0:_setPosXZ(slot0._scene.go.inventoryRootTrs, slot6, slot7)
	slot0:_setPosXZ(slot0.orthCameraTrs, slot6, slot7)
	RoomMapController.instance:dispatchEvent(RoomEvent.CameraTransformUpdate)
	RoomMapController.instance:dispatchEvent(RoomEvent.UpdateBlur, slot0._realCameraParam.blur)
	slot0:_cameraUpdateMask()

	if slot0._scene.graphics ~= nil then
		if slot0._isShadowHideMap[slot0._cameraState] or slot0._realCameraParam.distance < 2.7 then
			slot0._scene.graphics:setupShadowParam(false, slot0._realCameraParam.distance)
		else
			slot0._scene.graphics:setupShadowParam(true, slot0._realCameraParam.distance)
		end
	end

	if SLFramework.FrameworkSettings.IsEditor then
		-- Nothing
	end
end

function slot0._cameraUpdateMask(slot0)
	slot0._isCameraUpdateMask = true
	slot0._cameraUpdateMaskFrame = 0
end

function slot0._onUpdate(slot0)
	if slot0._isCameraUpdateMask then
		if slot0._cameraUpdateMaskFrame < 1 then
			slot0._cameraUpdateMaskFrame = slot0._cameraUpdateMaskFrame + 1
		else
			slot0._isCameraUpdateMask = false

			RoomMapController.instance:dispatchEvent(RoomEvent.CameraUpdateFinish)
		end
	end
end

function slot0._setPosXZ(slot0, slot1, slot2, slot3)
	slot4, slot5, slot6 = transformhelper.getPos(slot1)

	transformhelper.setPos(slot1, slot2, slot5, slot3)
end

function slot0.focusToPos(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = Vector2.zero

	if slot4 == RoomEnum.CameraState.Normal and not slot5 then
		slot8 = Vector2(0, (1 - slot1) * 0.90432 + slot1 * 1.204425)
		slot6.x = slot8.x * Mathf.Cos(slot3) + slot8.y * Mathf.Sin(slot3)
		slot6.y = slot8.y * Mathf.Cos(slot3) - slot8.x * Mathf.Sin(slot3)
	end

	return slot2 + slot6
end

function slot0.zoomToTouchMoveSpeed(slot0, slot1, slot2)
	return (1 - slot1) * slot0._touchMoveSpeedMin[slot2] + slot1 * slot0._touchMoveSpeedMax[slot2]
end

function slot0.zoomToOffsetY(slot0, slot1, slot2)
	return slot0._offsetHeightMap[slot2] or 0
end

function slot0.zoomToAngle(slot0, slot1, slot2)
	return ((1 - slot1) * slot0._angleMin[slot2] + slot1 * slot0._angleMax[slot2]) * Mathf.Deg2Rad
end

function slot0.zoomToBendingAmount(slot0, slot1, slot2)
	return (1 - slot1) * slot0._bendingAmountMin[slot2] + slot1 * slot0._bendingAmountMax[slot2]
end

function slot0.zoomToDistance(slot0, slot1, slot2)
	return (1 - slot1) * slot0._distanceMin[slot2] + slot1 * slot0._distanceMax[slot2]
end

function slot0.zoomToBlur(slot0, slot1, slot2)
	return (1 - slot1) * slot0._blurMin[slot2] + slot1 * slot0._blurMax[slot2]
end

function slot0.zoomToFogParam(slot0, slot1, slot2)
	for slot7, slot8 in pairs(slot0._fogParamMin[slot2]) do
		-- Nothing
	end

	return {
		[slot7] = (1 - slot1) * slot8 + slot1 * slot0._fogParamMax[slot2][slot7]
	}
end

function slot0.zoomToOffsetHorizon(slot0, slot1, slot2)
	return (1 - slot1) * slot0._offsetHorizonMin[slot2] + slot1 * slot0._offsetHorizonMax[slot2]
end

function slot0.zoomToOceanFog(slot0, slot1, slot2)
	return (1 - slot1) * slot0._oceanFogMin[slot2] + slot1 * slot0._oceanFogMax[slot2]
end

function slot0.zoomToHeight(slot0, slot1, slot2, slot3, slot4)
	if slot3 ~= RoomEnum.CameraState.Normal or slot4 then
		return 0
	end

	return RoomCharacterHelper.getLandHeightByRaycast(Vector3(slot2.x, 0, slot2.y)) - RoomCharacterEnum.CharacterHeightOffset
end

function slot0.zoomToLightRange(slot0, slot1, slot2)
	return (1 - slot1) * slot0._lightRangeMin[slot2] + slot1 * slot0._lightRangeMax[slot2]
end

function slot0.zoomToLightOffset(slot0, slot1, slot2)
	return (1 - slot1) * slot0._lightOffsetMin[slot2] + slot1 * slot0._lightOffsetMax[slot2]
end

function slot0.zoomToLightMin(slot0, slot1, slot2)
	return (1 - slot1) * slot0._lightMinMin[slot2] + slot1 * slot0._lightMinMax[slot2]
end

function slot0.zoomToShadowOffset(slot0, slot1, slot2)
	for slot7, slot8 in pairs(slot0._shadowOffsetMin[slot2]) do
		-- Nothing
	end

	return {
		[slot7] = (1 - slot1) * slot8 + slot1 * slot0._shadowOffsetMax[slot2][slot7]
	}
end

function slot0.switchCameraState(slot0, slot1, slot2, slot3, slot4, slot5)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
	slot0:_switchCameraStatePre(slot1)

	if slot2 then
		slot0:tweenCamera(slot2, slot3, slot4, slot5)
	end

	slot0:_switchCameraStateAft(slot1)
end

function slot0.switchCameraStateWithRealCameraParam(slot0, slot1, slot2, slot3, slot4, slot5)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
	slot0:_switchCameraStatePre(slot1)

	if slot2 then
		slot0:tweenRealCamera(slot2, slot3, slot4, slot5)
	end

	slot0:_switchCameraStateAft(slot1)
end

function slot0._switchCameraStatePre(slot0, slot1)
	if slot0._cameraState ~= RoomEnum.CameraState.Normal and slot0._cameraState ~= RoomEnum.CameraState.Character and (slot1 == RoomEnum.CameraState.Normal or slot1 == RoomEnum.CameraState.Character) then
		RoomCharacterController.instance:correctAllCharacterHeight()
	end

	if slot0._cameraSwitchAudioDict[slot0._cameraState] and slot0._cameraSwitchAudioDict[slot0._cameraState][slot1] then
		AudioMgr.instance:trigger(slot2)
	end

	if slot0._cameraState == RoomEnum.CameraState.Normal or slot0._cameraState == RoomEnum.CameraState.Overlook then
		slot0._savedCameraParam = LuaUtil.deepCopy(slot0._cameraParam)
		slot0._savedCameraState = slot0._cameraState
	end

	if slot0._cameraState ~= slot1 then
		slot0._cameraState = slot1

		slot0:_updateCameraClipPlane()
		RoomMapController.instance:dispatchEvent(RoomEvent.CameraStateUpdate)
	end
end

function slot0._switchCameraStateAft(slot0, slot1)
	if slot0._cameraState == RoomEnum.CameraState.Normal then
		RoomBuildingController.instance:setBuildingListShow(false)
		RoomCharacterController.instance:setCharacterListShow(false)
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.RefreshUIShow)
	RoomCharacterController.instance:dispatchEvent(RoomEvent.RefreshSpineShow)
end

function slot0.tweenCamera(slot0, slot1, slot2, slot3, slot4, slot5)
	for slot9, slot10 in pairs(slot1) do
		slot0._cameraParam[slot9] = slot10
	end

	slot0:tweenRealCamera(slot0:cameraParamToRealCameraParam(slot0._cameraParam), slot2, slot3, slot4, slot5)
end

function slot0.tweenRealCamera(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot0._tweenId then
		slot0._scene.tween:killById(slot0._tweenId)

		slot0._tweenId = nil
	end

	if ({
		srcParam = LuaUtil.deepCopy(slot0._realCameraParam),
		dstParam = slot1,
		frameCallback = slot2,
		finishCallback = slot3,
		callbackObj = slot4
	}).dstParam.bendingAmount then
		slot7 = Mathf.Max(Mathf.Abs(slot6.dstParam.bendingAmount - slot6.srcParam.bendingAmount), 0)
	end

	if slot6.dstParam.angle then
		slot7 = Mathf.Max(Mathf.Abs(slot6.dstParam.angle - slot6.srcParam.angle), slot7)
	end

	if slot6.dstParam.distance then
		slot7 = Mathf.Max(Mathf.Abs(slot6.dstParam.distance - slot6.srcParam.distance), slot7)
	end

	if slot6.dstParam.posX then
		slot7 = Mathf.Max(Mathf.Abs(slot6.dstParam.posX - slot6.srcParam.posX) / 2.5, slot7)
	end

	if slot6.dstParam.posY then
		slot7 = Mathf.Max(Mathf.Abs(slot6.dstParam.posY - slot6.srcParam.posY) / 2.5, slot7)
	end

	if slot6.dstParam.rotate then
		if Mathf.PI < Mathf.Abs(RoomRotateHelper.getMod(slot6.dstParam.rotate, Mathf.PI * 2) - RoomRotateHelper.getMod(slot6.srcParam.rotate, Mathf.PI * 2)) then
			slot10 = 2 * Mathf.PI - slot10
		end

		slot7 = Mathf.Max(slot10 / 2, slot7)
	end

	if slot6.dstParam.blur then
		slot7 = Mathf.Max(Mathf.Abs(slot6.dstParam.blur - slot6.srcParam.blur) / 1, slot7)
	end

	if slot6.dstParam.height then
		slot7 = Mathf.Max(Mathf.Abs(slot6.dstParam.height - slot6.srcParam.height) / 2.5, slot7)
	end

	if slot7 > 0 then
		if slot5 then
			slot0:_tweenCameraFinish(slot6)
		else
			slot0._isTweening = true

			UIBlockMgr.instance:startBlock(UIBlockKey.RoomCameraTweening)

			slot0._tweenId = slot0._scene.tween:tweenFloat(0, 1, Mathf.Clamp(slot7, 0.8, 1), slot0._tweenCameraFrame, slot0._tweenCameraFinish, slot0, slot6, EaseType.InOutQuart)
		end
	elseif slot6.finishCallback then
		slot6.finishCallback(slot6.callbackObj)
	end
end

function slot0._tweenCameraFrame(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot2.dstParam) do
		if type(slot7) == "table" then
			for slot11, slot12 in pairs(slot7) do
				slot0._realCameraParam[slot6][slot11] = (1 - slot1) * slot2.srcParam[slot6][slot11] + slot1 * slot12
			end
		elseif slot6 == "rotate" then
			slot0._realCameraParam[slot6] = RoomRotateHelper.simpleRotate(slot1, slot2.srcParam[slot6], slot7)
		else
			slot0._realCameraParam[slot6] = (1 - slot1) * slot2.srcParam[slot6] + slot1 * slot7
		end
	end

	if slot2.dstParam.rotate then
		slot0._realCameraParam.rotate = RoomRotateHelper.simpleRotate(slot1, slot2.srcParam.rotate, slot2.dstParam.rotate)
	end

	slot0:updateTransform()

	if slot2.frameCallback then
		if slot2.callbackObj then
			slot2.frameCallback(slot2.callbackObj, slot1)
		else
			slot2.frameCallback(slot1)
		end
	end
end

function slot0._tweenCameraFinish(slot0, slot1)
	for slot5, slot6 in pairs(slot1.dstParam) do
		slot0._realCameraParam[slot5] = slot6
	end

	slot0:updateTransform()

	slot0._isTweening = false

	UIBlockMgr.instance:endBlock(UIBlockKey.RoomCameraTweening)

	if slot1.finishCallback then
		if slot1.callbackObj then
			slot1.finishCallback(slot1.callbackObj)
		else
			slot1.finishCallback()
		end
	end
end

function slot0.getCameraPosition(slot0)
	return slot0._position
end

function slot0.getCameraRotation(slot0)
	return slot0._rotation
end

function slot0.getCameraFocus(slot0)
	if slot0._cameraParam then
		return Vector2(slot0._cameraParam.focusX, slot0._cameraParam.focusY)
	end

	return Vector2(0, 0)
end

function slot0.getCameraRotate(slot0)
	return slot0._cameraParam and slot0._cameraParam.rotate or 0
end

function slot0.getCameraZoom(slot0)
	return slot0._cameraParam and slot0._cameraParam.zoom or 0.5
end

function slot0.getCameraParam(slot0)
	return slot0._cameraParam
end

function slot0.getRealCameraParam(slot0)
	return slot0._realCameraParam
end

function slot0.getSavedCameraParam(slot0)
	return slot0._savedCameraParam
end

function slot0.getSavedCameraState(slot0)
	return slot0._savedCameraState
end

function slot0.getCameraState(slot0)
	return slot0._cameraState
end

function slot0.isTweening(slot0)
	return slot0._isTweening
end

function slot0._setCanvasCamera(slot0)
	slot0._scene.go.canvasGO:GetComponent(typeof(UnityEngine.Canvas)).worldCamera = CameraMgr.instance:getUnitCamera()
end

slot1 = 60
slot2 = 1.7777777777777777

function slot0._onScreenResize(slot0, slot1, slot2)
	slot3 = CameraMgr.instance:getVirtualCameras()
	slot6 = Mathf.Clamp(uv1 * uv0 / (slot1 / slot2), 60, 120)
	CameraMgr.instance:getMainCamera().fieldOfView = slot6
	CameraMgr.instance:getUnitCamera().fieldOfView = slot6
end

function slot0.playCameraAnim(slot0, slot1)
	if slot1 == "idle" then
		slot0:tweenOffsetY(0)
	elseif slot1 == "in_show" then
		slot0:tweenOffsetY(0, 0.3, 2)
	elseif slot1 == "in_edit" then
		slot0:tweenOffsetY(0, slot0._cameraStateInEditYDict[slot0._cameraState] or -0.3, 2)
	elseif slot1 == "out_show" then
		slot0:tweenOffsetY(0.3, 0, 2)
	elseif slot1 == "out_edit" then
		slot0:tweenOffsetY(-0.3, 0, 2)
	end
end

function slot0.tweenOffsetY(slot0, slot1, slot2, slot3)
	if slot0._tweenOffsetYId then
		slot0._scene.tween:killById(slot0._tweenOffsetYId)

		slot0._tweenOffsetYId = nil
	end

	slot0._offsetY = slot1

	slot0:updateTransform(true)

	if not slot2 or slot1 == slot2 then
		return
	end

	slot0._tweenOffsetYId = slot0._scene.tween:tweenFloat(slot1, slot2, slot3, slot0._tweenOffsetYFrame, slot0._tweenOffsetYFinish, slot0, {
		from = slot1,
		to = slot2
	}, EaseType.OutQuad)
end

function slot0._tweenOffsetYFrame(slot0, slot1, slot2)
	slot0._offsetY = slot1

	slot0:updateTransform(true)
end

function slot0._tweenOffsetYFinish(slot0, slot1)
	slot0._offsetY = slot1.to

	slot0:updateTransform(true)
end

function slot0._updateCameraClipPlane(slot0)
	if slot0._camerClipPlaneMin[slot0._cameraState] and slot0.camera then
		slot0.camera.nearClipPlane = slot0._camerClipPlaneMin[slot0._cameraState]
		slot0.camera.farClipPlane = slot0._camerClipPlaneMax[slot0._cameraState]
	end
end

function slot0.refreshOrthCamera(slot0)
	gohelper.setActive(slot0.orthCameraGO, true)
	TaskDispatcher.cancelTask(slot0._hideOrthCamera, slot0)
	TaskDispatcher.runDelay(slot0._hideOrthCamera, slot0, 0.01)
end

function slot0._hideOrthCamera(slot0)
	TaskDispatcher.cancelTask(slot0._hideOrthCamera, slot0)
	gohelper.setActive(slot0.orthCameraGO, false)
end

return slot0
