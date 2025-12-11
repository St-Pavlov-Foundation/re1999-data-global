module("modules.logic.scene.room.comp.RoomSceneCameraComp", package.seeall)

local var_0_0 = class("RoomSceneCameraComp", BaseSceneComp)

function var_0_0.onInit(arg_1_0)
	arg_1_0.cameraGO = nil
	arg_1_0.camera = nil
	arg_1_0._moveDistance = 2
end

function var_0_0._setCPMinMaxStr(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = string.splitToNumber(arg_2_4, "#")

	arg_2_0:_setCPMinMax(arg_2_1, arg_2_2, arg_2_3, var_2_0)
end

function var_0_0._setCPMinMax(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_2[arg_3_1] = arg_3_4[1]
	arg_3_3[arg_3_1] = arg_3_4[2]
end

function var_0_0._setFogMinMax(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0 = GameUtil.splitString2(arg_4_4.fogRangeXYZW, true)
	local var_4_1 = GameUtil.splitString2(arg_4_4.fogNearColorRGBA, true)
	local var_4_2 = GameUtil.splitString2(arg_4_4.fogFarColorRGBA, true)
	local var_4_3 = string.splitToNumber(arg_4_4.fogParticles, "#")
	local var_4_4 = string.splitToNumber(arg_4_4.fogViewType, "#")

	for iter_4_0 = 1, 2 do
		(iter_4_0 == 1 and arg_4_2 or arg_4_3)[arg_4_1] = {
			maxParticles = var_4_3[iter_4_0],
			centerY = var_4_0[iter_4_0][1],
			height = var_4_0[iter_4_0][2],
			fogRangeZ = var_4_0[iter_4_0][3],
			fogRangeW = var_4_0[iter_4_0][4],
			nearColorR = var_4_1[iter_4_0][1],
			nearColorG = var_4_1[iter_4_0][2],
			nearColorB = var_4_1[iter_4_0][3],
			nearColorA = var_4_1[iter_4_0][4],
			farColorR = var_4_2[iter_4_0][1],
			farColorG = var_4_2[iter_4_0][2],
			farColorB = var_4_2[iter_4_0][3],
			farColorA = var_4_2[iter_4_0][4],
			fogViewType = var_4_4[iter_4_0]
		}
	end
end

function var_0_0._initCameraParam(arg_5_0)
	arg_5_0._angleMin = {}
	arg_5_0._angleMax = {}
	arg_5_0._distanceMin = {}
	arg_5_0._distanceMax = {}
	arg_5_0._bendingAmountMin = {}
	arg_5_0._bendingAmountMax = {}
	arg_5_0._blurMin = {}
	arg_5_0._blurMax = {}
	arg_5_0._fogParamMin = {}
	arg_5_0._fogParamMax = {}
	arg_5_0._offsetHorizonMin = {}
	arg_5_0._offsetHorizonMax = {}
	arg_5_0._oceanFogMin = {}
	arg_5_0._oceanFogMax = {}
	arg_5_0._lightRangeMin = {}
	arg_5_0._lightRangeMax = {}
	arg_5_0._lightOffsetMin = {}
	arg_5_0._lightOffsetMax = {}
	arg_5_0._shadowOffsetMin = {}
	arg_5_0._shadowOffsetMax = {}
	arg_5_0._touchMoveSpeedMin = {}
	arg_5_0._touchMoveSpeedMax = {}
	arg_5_0._zoomInitValue = {}
	arg_5_0._lightMinMin = {}
	arg_5_0._lightMinMax = {}
	arg_5_0._offsetHeightMap = {}
	arg_5_0._camerClipPlaneMin = {}
	arg_5_0._camerClipPlaneMax = {}
	arg_5_0._isShadowHideMap = {}

	local var_5_0 = RoomModel.instance:getGameMode()

	for iter_5_0, iter_5_1 in pairs(RoomEnum.CameraState) do
		local var_5_1 = RoomConfig.instance:getCameraParamByStateId(iter_5_1, var_5_0)

		arg_5_0._offsetHeightMap[iter_5_1] = 0

		if var_5_1 then
			arg_5_0:_setCPMinMaxStr(iter_5_1, arg_5_0._angleMin, arg_5_0._angleMax, var_5_1.angle)
			arg_5_0:_setCPMinMaxStr(iter_5_1, arg_5_0._distanceMin, arg_5_0._distanceMax, var_5_1.distance)
			arg_5_0:_setCPMinMaxStr(iter_5_1, arg_5_0._bendingAmountMin, arg_5_0._bendingAmountMax, var_5_1.bendingAmount)
			arg_5_0:_setCPMinMaxStr(iter_5_1, arg_5_0._touchMoveSpeedMin, arg_5_0._touchMoveSpeedMax, var_5_1.touchMoveSpeed)
			arg_5_0:_setCPMinMaxStr(iter_5_1, arg_5_0._blurMin, arg_5_0._blurMax, var_5_1.blur)
			arg_5_0:_setCPMinMaxStr(iter_5_1, arg_5_0._offsetHorizonMin, arg_5_0._offsetHorizonMax, var_5_1.offsetHorizon)
			arg_5_0:_setCPMinMaxStr(iter_5_1, arg_5_0._oceanFogMin, arg_5_0._oceanFogMax, var_5_1.oceanFog)
			arg_5_0:_setCPMinMaxStr(iter_5_1, arg_5_0._lightMinMin, arg_5_0._lightMinMax, var_5_1.lightMin)
			arg_5_0:_setFogMinMax(iter_5_1, arg_5_0._fogParamMin, arg_5_0._fogParamMax, var_5_1)
			arg_5_0:_setCPMinMax(iter_5_1, arg_5_0._shadowOffsetMin, arg_5_0._shadowOffsetMax, GameUtil.splitString2(var_5_1.shadowOffsetXYZW, true))
			arg_5_0:_setCPMinMax(iter_5_1, arg_5_0._lightRangeMin, arg_5_0._lightRangeMax, {
				0.5,
				0.5
			})
			arg_5_0:_setCPMinMax(iter_5_1, arg_5_0._lightOffsetMin, arg_5_0._lightOffsetMax, {
				0.5,
				0.5
			})
			arg_5_0:_setCPMinMax(iter_5_1, arg_5_0._camerClipPlaneMin, arg_5_0._camerClipPlaneMax, {
				0.01,
				100
			})

			arg_5_0._zoomInitValue[iter_5_1] = var_5_1.zoom * 0.001
			arg_5_0._isShadowHideMap[iter_5_1] = true
		else
			logError(string.format("小屋相机镜头配置缺失[RoomEnum.CameraState.%s]:【export_镜头参数】state:%s", iter_5_0, iter_5_1))
		end
	end

	for iter_5_2, iter_5_3 in ipairs(RoomEnum.CameraOverlooks) do
		arg_5_0._camerClipPlaneMin[iter_5_3] = 0.3
		arg_5_0._isShadowHideMap[iter_5_3] = false
	end

	arg_5_0._cameraSwitchAudioDict = {
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
	arg_5_0._cameraStateInEditYDict = {
		[RoomEnum.CameraState.Normal] = 0.3,
		[RoomEnum.CameraState.Manufacture] = 0.3
	}

	local var_5_2 = {}
	local var_5_3 = CommonConfig.instance:getConstNum(ConstEnum.RoomMapMaxRadius)

	for iter_5_4 = 1, 6 do
		local var_5_4 = HexPoint.directions[iter_5_4] * var_5_3

		table.insert(var_5_2, HexMath.hexToPosition(var_5_4, RoomBlockEnum.BlockSize))
	end

	arg_5_0._editModeConvexHull = RoomCameraHelper.getConvexHull(var_5_2)
end

function var_0_0.setChangeCameraParamsById(arg_6_0, arg_6_1, arg_6_2)
	if RoomEnum.ChangeCameraParamDict[arg_6_1] then
		local var_6_0 = RoomConfig.instance:getCharacterBuildingInteractCameraConfig(arg_6_2) or RoomConfig.instance:getCameraParamByStateId(arg_6_1, RoomModel.instance:getGameMode())

		if var_6_0 then
			arg_6_0:_setCPMinMaxStr(arg_6_1, arg_6_0._angleMin, arg_6_0._angleMax, var_6_0.angle)
			arg_6_0:_setCPMinMaxStr(arg_6_1, arg_6_0._distanceMin, arg_6_0._distanceMax, var_6_0.distance)

			local var_6_1 = var_6_0.focusXYZ and string.splitToNumber(var_6_0.focusXYZ, "#")

			arg_6_0._offsetHeightMap[arg_6_1] = var_6_1 and var_6_1[2] or 0
		end
	end
end

function var_0_0.setCharacterbuildingInteractionById(arg_7_0, arg_7_1)
	local var_7_0 = RoomEnum.CameraState.InteractionCharacterBuilding

	arg_7_0:setChangeCameraParamsById(var_7_0, arg_7_1)
end

function var_0_0.init(arg_8_0, arg_8_1, arg_8_2)
	TaskDispatcher.runRepeat(arg_8_0._onUpdate, arg_8_0, 0)
	arg_8_0:_initCameraParam()
	arg_8_0:_initCamera()

	arg_8_0._scene = arg_8_0:getCurScene()
	arg_8_0._cameraParam = nil
	arg_8_0._realCameraParam = nil
	arg_8_0._tempRealCameraParam = nil
	arg_8_0._offsetY = 0
	arg_8_0.cameraGO = CameraMgr.instance:getMainCameraGO()
	arg_8_0.cameraTrs = CameraMgr.instance:getMainCameraTrs()
	arg_8_0.camera = CameraMgr.instance:getMainCamera()
	arg_8_0.orthCameraGO = CameraMgr.instance:getOrthCameraGO()
	arg_8_0.orthCamera = CameraMgr.instance:getOrthCamera()

	RenderPipelineSetting.SetCameraRenderingLayerMask(arg_8_0.orthCamera, 128)
	PostProcessingMgr.setCameraLayer(arg_8_0.orthCamera, "Scene", true)
	PostProcessingMgr.setCameraLayer(arg_8_0.orthCamera, "SceneOpaque", true)
	PostProcessingMgr.setCameraLayer(arg_8_0.orthCamera, "CullOnLowQuality", true)
	PostProcessingMgr.setCameraLayer(arg_8_0.orthCamera, "CullByDistance", true)
	PostProcessingMgr.setCameraLayer(arg_8_0.orthCamera, "SceneOrthogonal", false)
	PostProcessingMgr.setCameraLayer(arg_8_0.orthCamera, "SceneOrthogonalOpaque", false)

	arg_8_0.orthCameraTrs = arg_8_0.orthCameraGO.transform
	arg_8_0.orthCameraTrs.position = Vector3(0, 3.5, 0)
	arg_8_0.orthCameraTrs.rotation = Quaternion.Euler(90, 0, 0)

	arg_8_0:_setCanvasCamera()
	arg_8_0:resetTransform()
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, arg_8_0._onScreenResize, arg_8_0)
end

function var_0_0._initCamera(arg_9_0)
	gohelper.setActive(CameraMgr.instance:getVirtualCameraGO(), false)
	transformhelper.setLocalPos(CameraMgr.instance:getMainCameraTrs(), 0, 0, 0)
	transformhelper.setLocalRotation(CameraMgr.instance:getMainCameraTrs(), 0, 0, 0)
end

function var_0_0.onSceneStart(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0:_onScreenResize(UnityEngine.Screen.width, UnityEngine.Screen.height)
end

function var_0_0.onSceneClose(arg_11_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)

	if arg_11_0._tweenOffsetYId then
		arg_11_0._scene.tween:killById(arg_11_0._tweenOffsetYId)

		arg_11_0._tweenOffsetYId = nil
	end

	TaskDispatcher.cancelTask(arg_11_0._onUpdate, arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._forceUpdataTransform, arg_11_0)
	UIBlockMgr.instance:endBlock(UIBlockKey.RoomCameraTweening)

	if arg_11_0._tweenId then
		arg_11_0._scene.tween:killById(arg_11_0._tweenId)

		arg_11_0._tweenId = nil
	end

	transformhelper.setPos(arg_11_0.cameraTrs, 0, 0, 0)
	transformhelper.setLocalRotation(arg_11_0.cameraTrs, 0, 0, 0)
	RenderPipelineSetting.SetCameraRenderingLayerMask(arg_11_0.orthCamera, 1)
	PostProcessingMgr.setCameraLayer(arg_11_0.orthCamera, "Scene", false)
	PostProcessingMgr.setCameraLayer(arg_11_0.orthCamera, "SceneOpaque", false)
	PostProcessingMgr.setCameraLayer(arg_11_0.orthCamera, "CullOnLowQuality", false)
	PostProcessingMgr.setCameraLayer(arg_11_0.orthCamera, "CullByDistance", false)
	PostProcessingMgr.setCameraLayer(arg_11_0.orthCamera, "SceneOrthogonal", true)
	PostProcessingMgr.setCameraLayer(arg_11_0.orthCamera, "SceneOrthogonalOpaque", true)

	arg_11_0.orthCamera = nil
	arg_11_0._cameraParam = nil
	arg_11_0._realCameraParam = nil
	arg_11_0._tempRealCameraParam = nil
	arg_11_0.cameraGO = nil
	arg_11_0.cameraTrs = nil
	arg_11_0.camera = nil

	arg_11_0:_hideOrthCamera()

	arg_11_0.orthCameraGO = nil
	arg_11_0.orthCameraTrs = nil

	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, arg_11_0._onScreenResize, arg_11_0)
end

function var_0_0.move(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:moveTo(arg_12_0._cameraParam.focusX + arg_12_1, arg_12_0._cameraParam.focusY + arg_12_2)
end

function var_0_0.moveTo(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = Vector2(arg_13_1, arg_13_2)
	local var_13_1

	if RoomController.instance:isEditMode() then
		var_13_1 = arg_13_0._editModeConvexHull
	else
		var_13_1 = RoomMapBlockModel.instance:getConvexHull()
	end

	local var_13_2 = RoomCameraHelper.getOffsetPosition(Vector2(arg_13_0._cameraParam.focusX, arg_13_0._cameraParam.focusY), Vector2(arg_13_1, arg_13_2), var_13_1)

	arg_13_0._cameraParam.focusX = var_13_2.x
	arg_13_0._cameraParam.focusY = var_13_2.y
	arg_13_0._realCameraParam = arg_13_0:cameraParamToRealCameraParam(arg_13_0._cameraParam)

	arg_13_0:updateTransform()
end

function var_0_0.zoom(arg_14_0, arg_14_1)
	arg_14_0:zoomTo(arg_14_0._cameraParam.zoom + arg_14_1)
end

function var_0_0.zoomTo(arg_15_0, arg_15_1)
	arg_15_0._cameraParam.zoom = Mathf.Clamp(arg_15_1, 0, 1)
	arg_15_0._realCameraParam = arg_15_0:cameraParamToRealCameraParam(arg_15_0._cameraParam)

	arg_15_0:updateTransform()
end

function var_0_0.rotate(arg_16_0, arg_16_1)
	arg_16_0:rotateTo(arg_16_0._cameraParam.rotate + arg_16_1)
end

function var_0_0.rotateTo(arg_17_0, arg_17_1)
	arg_17_0._cameraParam.rotate = RoomRotateHelper.getMod(arg_17_1, 2 * Mathf.PI)
	arg_17_0._realCameraParam = arg_17_0:cameraParamToRealCameraParam(arg_17_0._cameraParam)

	arg_17_0:updateTransform()
end

function var_0_0.getZoomInitValue(arg_18_0, arg_18_1)
	return arg_18_0._zoomInitValue and arg_18_0._zoomInitValue[arg_18_1] or 0.5
end

function var_0_0.resetTransform(arg_19_0)
	arg_19_0._cameraState = RoomEnum.CameraState.Overlook

	if FishingModel.instance:isInFishing() then
		arg_19_0._cameraState = RoomEnum.CameraState.OverlookAll
	end

	arg_19_0._cameraParam = {
		focusY = 0,
		focusX = 0,
		rotate = 0,
		zoom = arg_19_0:getZoomInitValue(arg_19_0._cameraState)
	}
	arg_19_0._realCameraParam = arg_19_0:cameraParamToRealCameraParam(arg_19_0._cameraParam)
	arg_19_0._savedCameraParam = LuaUtil.deepCopy(arg_19_0._cameraParam)
	arg_19_0._savedCameraState = arg_19_0._cameraState
	arg_19_0._isTweening = false

	UIBlockMgr.instance:endBlock(UIBlockKey.RoomCameraTweening)
	arg_19_0:updateTransform()
	TaskDispatcher.runDelay(arg_19_0._forceUpdataTransform, arg_19_0, 0.0001)
	arg_19_0:_updateCameraClipPlane()
end

function var_0_0._forceUpdataTransform(arg_20_0)
	arg_20_0:updateTransform(true)
end

function var_0_0.cameraParamToRealCameraParam(arg_21_0, arg_21_1, arg_21_2)
	arg_21_2 = arg_21_2 or arg_21_0._cameraState

	local var_21_0 = arg_21_0:focusToPos(arg_21_1.zoom, Vector2(arg_21_1.focusX, arg_21_1.focusY), arg_21_1.rotate, arg_21_2, arg_21_1.isPart)
	local var_21_1 = arg_21_0:zoomToOffsetY(arg_21_1.zoom, arg_21_2)

	return {
		zoom = arg_21_1.zoom,
		bendingAmount = arg_21_0:zoomToBendingAmount(arg_21_1.zoom, arg_21_2),
		angle = arg_21_0:zoomToAngle(arg_21_1.zoom, arg_21_2),
		distance = arg_21_0:zoomToDistance(arg_21_1.zoom, arg_21_2),
		blur = arg_21_0:zoomToBlur(arg_21_1.zoom, arg_21_2),
		fogParam = arg_21_0:zoomToFogParam(arg_21_1.zoom, arg_21_2),
		offsetHorizon = arg_21_0:zoomToOffsetHorizon(arg_21_1.zoom, arg_21_2),
		oceanFog = arg_21_0:zoomToOceanFog(arg_21_1.zoom, arg_21_2),
		lightRange = arg_21_0:zoomToLightRange(arg_21_1.zoom, arg_21_2),
		lightOffset = arg_21_0:zoomToLightOffset(arg_21_1.zoom, arg_21_2),
		lightMin = arg_21_0:zoomToLightMin(arg_21_1.zoom, arg_21_2),
		shadowOffset = arg_21_0:zoomToShadowOffset(arg_21_1.zoom, arg_21_2),
		touchMoveSpeed = arg_21_0:zoomToTouchMoveSpeed(arg_21_1.zoom, arg_21_2),
		posX = var_21_0.x,
		posY = var_21_0.y,
		rotate = arg_21_1.rotate,
		height = var_21_1 + arg_21_0:zoomToHeight(arg_21_1.zoom, Vector2(arg_21_1.focusX, arg_21_1.focusY), arg_21_2, arg_21_1.isPart)
	}
end

function var_0_0.updateTransform(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_1

	if not arg_22_0._tempRealCameraParam then
		var_22_0 = true
	else
		for iter_22_0, iter_22_1 in pairs(arg_22_0._realCameraParam) do
			if type(iter_22_1) == "table" then
				for iter_22_2, iter_22_3 in pairs(iter_22_1) do
					if iter_22_3 ~= arg_22_0._tempRealCameraParam[iter_22_0][iter_22_2] then
						var_22_0 = true

						break
					end
				end
			elseif iter_22_1 ~= arg_22_0._tempRealCameraParam[iter_22_0] then
				var_22_0 = true
			end

			if var_22_0 then
				break
			end
		end
	end

	if not var_22_0 then
		return
	end

	arg_22_0._tempRealCameraParam = LuaUtil.deepCopy(arg_22_0._realCameraParam)
	RoomController.instance.touchMoveSpeed = arg_22_0._realCameraParam.touchMoveSpeed

	arg_22_0._scene.bending:setBendingAmount(arg_22_0._realCameraParam.bendingAmount)
	arg_22_0._scene.bending:setBendingPosition(Vector3(arg_22_0._realCameraParam.posX, 0, arg_22_0._realCameraParam.posY))
	arg_22_0._scene.fog:setFogParam(arg_22_0._realCameraParam.fogParam)
	arg_22_0._scene.bending:setSkylineOffset(arg_22_0._realCameraParam.offsetHorizon)
	arg_22_0._scene.ocean:setOceanFog(arg_22_0._realCameraParam.oceanFog)
	arg_22_0._scene.light:setLightMin(arg_22_0._realCameraParam.lightMin)
	arg_22_0._scene.light:setLightRange(arg_22_0._realCameraParam.lightRange)
	arg_22_0._scene.light:setLightOffset(arg_22_0._realCameraParam.lightOffset)

	local var_22_1 = arg_22_0._realCameraParam.shadowOffset

	arg_22_0._scene.character:setShadowOffset(Vector4(var_22_1[1], var_22_1[2], var_22_1[3], var_22_1[4]))

	local var_22_2 = arg_22_0._realCameraParam.distance * Mathf.Cos(arg_22_0._realCameraParam.angle)
	local var_22_3 = arg_22_0._realCameraParam.distance * Mathf.Sin(arg_22_0._realCameraParam.angle) + arg_22_0._realCameraParam.height
	local var_22_4 = -Mathf.Sin(arg_22_0._realCameraParam.rotate) * var_22_2 + arg_22_0._realCameraParam.posX
	local var_22_5 = -Mathf.Cos(arg_22_0._realCameraParam.rotate) * var_22_2 + arg_22_0._realCameraParam.posY
	local var_22_6 = var_22_3 + arg_22_0._offsetY + arg_22_0._scene.cameraFollow:getCameraOffsetY()
	local var_22_7 = math.max(0.11, var_22_6)

	arg_22_0._position = Vector3(var_22_4, var_22_7, var_22_5)

	local var_22_8 = Mathf.Rad2Deg * arg_22_0._realCameraParam.angle
	local var_22_9 = Mathf.Rad2Deg * arg_22_0._realCameraParam.rotate

	arg_22_0._rotation = Quaternion.Euler(var_22_8, var_22_9, 0)
	arg_22_0._orthRotation = Quaternion.Euler(90, var_22_9, 0)
	arg_22_0._inventoryRotation = Quaternion.Euler(0, var_22_9, 0)

	transformhelper.setPos(arg_22_0.cameraTrs, arg_22_0._position.x, arg_22_0._position.y, arg_22_0._position.z)
	transformhelper.setRotation(arg_22_0.cameraTrs, arg_22_0._rotation.x, arg_22_0._rotation.y, arg_22_0._rotation.z, arg_22_0._rotation.w)
	transformhelper.setPos(arg_22_0._scene.go.virtualCameraTrs, arg_22_0._position.x, arg_22_0._position.y, arg_22_0._position.z)
	arg_22_0:_setPosXZ(arg_22_0._scene.go.virtualCameraXZTrs, var_22_4, var_22_5)
	transformhelper.setRotation(arg_22_0._scene.go.virtualCameraTrs, arg_22_0._rotation.x, arg_22_0._rotation.y, arg_22_0._rotation.z, arg_22_0._rotation.w)
	transformhelper.setRotation(arg_22_0.orthCameraTrs, arg_22_0._orthRotation.x, arg_22_0._orthRotation.y, arg_22_0._orthRotation.z, arg_22_0._orthRotation.w)
	transformhelper.setRotation(arg_22_0._scene.go.inventoryRootTrs, arg_22_0._inventoryRotation.x, arg_22_0._inventoryRotation.y, arg_22_0._inventoryRotation.z, arg_22_0._inventoryRotation.w)
	arg_22_0:_setPosXZ(arg_22_0._scene.go.inventoryRootTrs, var_22_4, var_22_5)
	arg_22_0:_setPosXZ(arg_22_0.orthCameraTrs, var_22_4, var_22_5)
	RoomMapController.instance:dispatchEvent(RoomEvent.CameraTransformUpdate)
	RoomMapController.instance:dispatchEvent(RoomEvent.UpdateBlur, arg_22_0._realCameraParam.blur)
	arg_22_0:_cameraUpdateMask()

	if arg_22_0._scene.graphics ~= nil then
		if arg_22_0._isShadowHideMap[arg_22_0._cameraState] or arg_22_0._realCameraParam.distance < 2.7 then
			arg_22_0._scene.graphics:setupShadowParam(false, arg_22_0._realCameraParam.distance)
		else
			arg_22_0._scene.graphics:setupShadowParam(true, arg_22_0._realCameraParam.distance)
		end
	end

	if SLFramework.FrameworkSettings.IsEditor then
		-- block empty
	end
end

function var_0_0._cameraUpdateMask(arg_23_0)
	arg_23_0._isCameraUpdateMask = true
	arg_23_0._cameraUpdateMaskFrame = 0
end

function var_0_0._onUpdate(arg_24_0)
	if arg_24_0._isCameraUpdateMask then
		if arg_24_0._cameraUpdateMaskFrame < 1 then
			arg_24_0._cameraUpdateMaskFrame = arg_24_0._cameraUpdateMaskFrame + 1
		else
			arg_24_0._isCameraUpdateMask = false

			RoomMapController.instance:dispatchEvent(RoomEvent.CameraUpdateFinish)
		end
	end
end

function var_0_0._setPosXZ(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0, var_25_1, var_25_2 = transformhelper.getPos(arg_25_1)

	transformhelper.setPos(arg_25_1, arg_25_2, var_25_1, arg_25_3)
end

function var_0_0.focusToPos(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4, arg_26_5)
	local var_26_0 = Vector2.zero

	if arg_26_4 == RoomEnum.CameraState.Normal and not arg_26_5 then
		local var_26_1 = (1 - arg_26_1) * 0.90432 + arg_26_1 * 1.204425
		local var_26_2 = Vector2(0, var_26_1)

		var_26_0.x = var_26_2.x * Mathf.Cos(arg_26_3) + var_26_2.y * Mathf.Sin(arg_26_3)
		var_26_0.y = var_26_2.y * Mathf.Cos(arg_26_3) - var_26_2.x * Mathf.Sin(arg_26_3)
	end

	return arg_26_2 + var_26_0
end

function var_0_0.zoomToTouchMoveSpeed(arg_27_0, arg_27_1, arg_27_2)
	return (1 - arg_27_1) * arg_27_0._touchMoveSpeedMin[arg_27_2] + arg_27_1 * arg_27_0._touchMoveSpeedMax[arg_27_2]
end

function var_0_0.zoomToOffsetY(arg_28_0, arg_28_1, arg_28_2)
	return arg_28_0._offsetHeightMap[arg_28_2] or 0
end

function var_0_0.zoomToAngle(arg_29_0, arg_29_1, arg_29_2)
	return ((1 - arg_29_1) * arg_29_0._angleMin[arg_29_2] + arg_29_1 * arg_29_0._angleMax[arg_29_2]) * Mathf.Deg2Rad
end

function var_0_0.zoomToBendingAmount(arg_30_0, arg_30_1, arg_30_2)
	return (1 - arg_30_1) * arg_30_0._bendingAmountMin[arg_30_2] + arg_30_1 * arg_30_0._bendingAmountMax[arg_30_2]
end

function var_0_0.zoomToDistance(arg_31_0, arg_31_1, arg_31_2)
	return (1 - arg_31_1) * arg_31_0._distanceMin[arg_31_2] + arg_31_1 * arg_31_0._distanceMax[arg_31_2]
end

function var_0_0.zoomToBlur(arg_32_0, arg_32_1, arg_32_2)
	return (1 - arg_32_1) * arg_32_0._blurMin[arg_32_2] + arg_32_1 * arg_32_0._blurMax[arg_32_2]
end

function var_0_0.zoomToFogParam(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = {}

	for iter_33_0, iter_33_1 in pairs(arg_33_0._fogParamMin[arg_33_2]) do
		var_33_0[iter_33_0] = (1 - arg_33_1) * iter_33_1 + arg_33_1 * arg_33_0._fogParamMax[arg_33_2][iter_33_0]
	end

	return var_33_0
end

function var_0_0.zoomToOffsetHorizon(arg_34_0, arg_34_1, arg_34_2)
	return (1 - arg_34_1) * arg_34_0._offsetHorizonMin[arg_34_2] + arg_34_1 * arg_34_0._offsetHorizonMax[arg_34_2]
end

function var_0_0.zoomToOceanFog(arg_35_0, arg_35_1, arg_35_2)
	return (1 - arg_35_1) * arg_35_0._oceanFogMin[arg_35_2] + arg_35_1 * arg_35_0._oceanFogMax[arg_35_2]
end

function var_0_0.zoomToHeight(arg_36_0, arg_36_1, arg_36_2, arg_36_3, arg_36_4)
	if arg_36_3 ~= RoomEnum.CameraState.Normal or arg_36_4 then
		return 0
	end

	return RoomCharacterHelper.getLandHeightByRaycast(Vector3(arg_36_2.x, 0, arg_36_2.y)) - RoomCharacterEnum.CharacterHeightOffset
end

function var_0_0.zoomToLightRange(arg_37_0, arg_37_1, arg_37_2)
	return (1 - arg_37_1) * arg_37_0._lightRangeMin[arg_37_2] + arg_37_1 * arg_37_0._lightRangeMax[arg_37_2]
end

function var_0_0.zoomToLightOffset(arg_38_0, arg_38_1, arg_38_2)
	return (1 - arg_38_1) * arg_38_0._lightOffsetMin[arg_38_2] + arg_38_1 * arg_38_0._lightOffsetMax[arg_38_2]
end

function var_0_0.zoomToLightMin(arg_39_0, arg_39_1, arg_39_2)
	return (1 - arg_39_1) * arg_39_0._lightMinMin[arg_39_2] + arg_39_1 * arg_39_0._lightMinMax[arg_39_2]
end

function var_0_0.zoomToShadowOffset(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = {}

	for iter_40_0, iter_40_1 in pairs(arg_40_0._shadowOffsetMin[arg_40_2]) do
		var_40_0[iter_40_0] = (1 - arg_40_1) * iter_40_1 + arg_40_1 * arg_40_0._shadowOffsetMax[arg_40_2][iter_40_0]
	end

	return var_40_0
end

function var_0_0.switchCameraState(arg_41_0, arg_41_1, arg_41_2, arg_41_3, arg_41_4, arg_41_5)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
	arg_41_0:_switchCameraStatePre(arg_41_1)

	if arg_41_2 then
		arg_41_0:tweenCamera(arg_41_2, arg_41_3, arg_41_4, arg_41_5)
	end

	arg_41_0:_switchCameraStateAft(arg_41_1)
end

function var_0_0.switchCameraStateWithRealCameraParam(arg_42_0, arg_42_1, arg_42_2, arg_42_3, arg_42_4, arg_42_5)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
	arg_42_0:_switchCameraStatePre(arg_42_1)

	if arg_42_2 then
		arg_42_0:tweenRealCamera(arg_42_2, arg_42_3, arg_42_4, arg_42_5)
	end

	arg_42_0:_switchCameraStateAft(arg_42_1)
end

function var_0_0._switchCameraStatePre(arg_43_0, arg_43_1)
	if arg_43_0._cameraState ~= RoomEnum.CameraState.Normal and arg_43_0._cameraState ~= RoomEnum.CameraState.Character and (arg_43_1 == RoomEnum.CameraState.Normal or arg_43_1 == RoomEnum.CameraState.Character) then
		RoomCharacterController.instance:correctAllCharacterHeight()
	end

	local var_43_0 = arg_43_0._cameraSwitchAudioDict[arg_43_0._cameraState] and arg_43_0._cameraSwitchAudioDict[arg_43_0._cameraState][arg_43_1]

	if var_43_0 then
		AudioMgr.instance:trigger(var_43_0)
	end

	if arg_43_0._cameraState == RoomEnum.CameraState.Normal or arg_43_0._cameraState == RoomEnum.CameraState.Overlook then
		arg_43_0._savedCameraParam = LuaUtil.deepCopy(arg_43_0._cameraParam)
		arg_43_0._savedCameraState = arg_43_0._cameraState
	end

	if arg_43_0._cameraState ~= arg_43_1 then
		arg_43_0._cameraState = arg_43_1

		arg_43_0:_updateCameraClipPlane()
		RoomMapController.instance:dispatchEvent(RoomEvent.CameraStateUpdate)
	end
end

function var_0_0._switchCameraStateAft(arg_44_0, arg_44_1)
	if arg_44_0._cameraState == RoomEnum.CameraState.Normal then
		RoomBuildingController.instance:setBuildingListShow(false)
		RoomCharacterController.instance:setCharacterListShow(false)
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.RefreshUIShow)
	RoomCharacterController.instance:dispatchEvent(RoomEvent.RefreshSpineShow)
end

function var_0_0.tweenCamera(arg_45_0, arg_45_1, arg_45_2, arg_45_3, arg_45_4, arg_45_5)
	for iter_45_0, iter_45_1 in pairs(arg_45_1) do
		arg_45_0._cameraParam[iter_45_0] = iter_45_1
	end

	local var_45_0 = arg_45_0:cameraParamToRealCameraParam(arg_45_0._cameraParam)

	arg_45_0:tweenRealCamera(var_45_0, arg_45_2, arg_45_3, arg_45_4, arg_45_5)
end

function var_0_0.tweenRealCamera(arg_46_0, arg_46_1, arg_46_2, arg_46_3, arg_46_4, arg_46_5)
	if arg_46_0._tweenId then
		arg_46_0._scene.tween:killById(arg_46_0._tweenId)

		arg_46_0._tweenId = nil
	end

	local var_46_0 = {
		srcParam = LuaUtil.deepCopy(arg_46_0._realCameraParam),
		dstParam = arg_46_1,
		frameCallback = arg_46_2,
		finishCallback = arg_46_3,
		callbackObj = arg_46_4
	}
	local var_46_1 = 0

	if var_46_0.dstParam.bendingAmount then
		local var_46_2 = Mathf.Abs(var_46_0.dstParam.bendingAmount - var_46_0.srcParam.bendingAmount)

		var_46_1 = Mathf.Max(var_46_2, var_46_1)
	end

	if var_46_0.dstParam.angle then
		local var_46_3 = Mathf.Abs(var_46_0.dstParam.angle - var_46_0.srcParam.angle)

		var_46_1 = Mathf.Max(var_46_3, var_46_1)
	end

	if var_46_0.dstParam.distance then
		local var_46_4 = Mathf.Abs(var_46_0.dstParam.distance - var_46_0.srcParam.distance)

		var_46_1 = Mathf.Max(var_46_4, var_46_1)
	end

	if var_46_0.dstParam.posX then
		local var_46_5 = Mathf.Abs(var_46_0.dstParam.posX - var_46_0.srcParam.posX) / 2.5

		var_46_1 = Mathf.Max(var_46_5, var_46_1)
	end

	if var_46_0.dstParam.posY then
		local var_46_6 = Mathf.Abs(var_46_0.dstParam.posY - var_46_0.srcParam.posY) / 2.5

		var_46_1 = Mathf.Max(var_46_6, var_46_1)
	end

	if var_46_0.dstParam.rotate then
		local var_46_7 = RoomRotateHelper.getMod(var_46_0.dstParam.rotate, Mathf.PI * 2)
		local var_46_8 = RoomRotateHelper.getMod(var_46_0.srcParam.rotate, Mathf.PI * 2)
		local var_46_9 = Mathf.Abs(var_46_7 - var_46_8)

		if var_46_9 > Mathf.PI then
			var_46_9 = 2 * Mathf.PI - var_46_9
		end

		local var_46_10 = var_46_9 / 2

		var_46_1 = Mathf.Max(var_46_10, var_46_1)
	end

	if var_46_0.dstParam.blur then
		local var_46_11 = Mathf.Abs(var_46_0.dstParam.blur - var_46_0.srcParam.blur) / 1

		var_46_1 = Mathf.Max(var_46_11, var_46_1)
	end

	if var_46_0.dstParam.height then
		local var_46_12 = Mathf.Abs(var_46_0.dstParam.height - var_46_0.srcParam.height) / 2.5

		var_46_1 = Mathf.Max(var_46_12, var_46_1)
	end

	if var_46_1 > 0 then
		if arg_46_5 then
			arg_46_0:_tweenCameraFinish(var_46_0)
		else
			local var_46_13 = Mathf.Clamp(var_46_1, 0.8, 1)

			arg_46_0._isTweening = true

			UIBlockMgr.instance:startBlock(UIBlockKey.RoomCameraTweening)

			arg_46_0._tweenId = arg_46_0._scene.tween:tweenFloat(0, 1, var_46_13, arg_46_0._tweenCameraFrame, arg_46_0._tweenCameraFinish, arg_46_0, var_46_0, EaseType.InOutQuart)
		end
	elseif var_46_0.finishCallback then
		var_46_0.finishCallback(var_46_0.callbackObj)
	end
end

function var_0_0._tweenCameraFrame(arg_47_0, arg_47_1, arg_47_2)
	for iter_47_0, iter_47_1 in pairs(arg_47_2.dstParam) do
		if type(iter_47_1) == "table" then
			for iter_47_2, iter_47_3 in pairs(iter_47_1) do
				arg_47_0._realCameraParam[iter_47_0][iter_47_2] = (1 - arg_47_1) * arg_47_2.srcParam[iter_47_0][iter_47_2] + arg_47_1 * iter_47_3
			end
		elseif iter_47_0 == "rotate" then
			arg_47_0._realCameraParam[iter_47_0] = RoomRotateHelper.simpleRotate(arg_47_1, arg_47_2.srcParam[iter_47_0], iter_47_1)
		else
			arg_47_0._realCameraParam[iter_47_0] = (1 - arg_47_1) * arg_47_2.srcParam[iter_47_0] + arg_47_1 * iter_47_1
		end
	end

	if arg_47_2.dstParam.rotate then
		arg_47_0._realCameraParam.rotate = RoomRotateHelper.simpleRotate(arg_47_1, arg_47_2.srcParam.rotate, arg_47_2.dstParam.rotate)
	end

	arg_47_0:updateTransform()

	if arg_47_2.frameCallback then
		if arg_47_2.callbackObj then
			arg_47_2.frameCallback(arg_47_2.callbackObj, arg_47_1)
		else
			arg_47_2.frameCallback(arg_47_1)
		end
	end
end

function var_0_0._tweenCameraFinish(arg_48_0, arg_48_1)
	for iter_48_0, iter_48_1 in pairs(arg_48_1.dstParam) do
		arg_48_0._realCameraParam[iter_48_0] = iter_48_1
	end

	arg_48_0:updateTransform()

	arg_48_0._isTweening = false

	UIBlockMgr.instance:endBlock(UIBlockKey.RoomCameraTweening)

	if arg_48_1.finishCallback then
		if arg_48_1.callbackObj then
			arg_48_1.finishCallback(arg_48_1.callbackObj)
		else
			arg_48_1.finishCallback()
		end
	end
end

function var_0_0.getCameraPosition(arg_49_0)
	return arg_49_0._position
end

function var_0_0.getCameraRotation(arg_50_0)
	return arg_50_0._rotation
end

function var_0_0.getCameraFocus(arg_51_0)
	if arg_51_0._cameraParam then
		return Vector2(arg_51_0._cameraParam.focusX, arg_51_0._cameraParam.focusY)
	end

	return Vector2(0, 0)
end

function var_0_0.getCameraRotate(arg_52_0)
	return arg_52_0._cameraParam and arg_52_0._cameraParam.rotate or 0
end

function var_0_0.getCameraZoom(arg_53_0)
	return arg_53_0._cameraParam and arg_53_0._cameraParam.zoom or 0.5
end

function var_0_0.getCameraParam(arg_54_0)
	return arg_54_0._cameraParam
end

function var_0_0.getRealCameraParam(arg_55_0)
	return arg_55_0._realCameraParam
end

function var_0_0.getSavedCameraParam(arg_56_0)
	return arg_56_0._savedCameraParam
end

function var_0_0.getSavedCameraState(arg_57_0)
	return arg_57_0._savedCameraState
end

function var_0_0.getCameraState(arg_58_0)
	return arg_58_0._cameraState
end

function var_0_0.isTweening(arg_59_0)
	return arg_59_0._isTweening
end

function var_0_0._setCanvasCamera(arg_60_0)
	arg_60_0._scene.go.canvasGO:GetComponent(typeof(UnityEngine.Canvas)).worldCamera = CameraMgr.instance:getUnitCamera()
end

local var_0_1 = 60
local var_0_2 = 1.7777777777777777

function var_0_0._onScreenResize(arg_61_0, arg_61_1, arg_61_2)
	local var_61_0 = CameraMgr.instance:getVirtualCameras()
	local var_61_1 = arg_61_1 / arg_61_2
	local var_61_2 = var_0_2 / var_61_1
	local var_61_3 = var_0_1 * var_61_2
	local var_61_4 = Mathf.Clamp(var_61_3, 60, 120)

	CameraMgr.instance:getMainCamera().fieldOfView = var_61_4
	CameraMgr.instance:getUnitCamera().fieldOfView = var_61_4
end

function var_0_0.playCameraAnim(arg_62_0, arg_62_1)
	if arg_62_1 == "idle" then
		arg_62_0:tweenOffsetY(0)
	elseif arg_62_1 == "in_show" then
		arg_62_0:tweenOffsetY(0, 0.3, 2)
	elseif arg_62_1 == "in_edit" then
		arg_62_0:tweenOffsetY(0, arg_62_0._cameraStateInEditYDict[arg_62_0._cameraState] or -0.3, 2)
	elseif arg_62_1 == "out_show" then
		arg_62_0:tweenOffsetY(0.3, 0, 2)
	elseif arg_62_1 == "out_edit" then
		arg_62_0:tweenOffsetY(-0.3, 0, 2)
	end
end

function var_0_0.tweenOffsetY(arg_63_0, arg_63_1, arg_63_2, arg_63_3)
	if arg_63_0._tweenOffsetYId then
		arg_63_0._scene.tween:killById(arg_63_0._tweenOffsetYId)

		arg_63_0._tweenOffsetYId = nil
	end

	arg_63_0._offsetY = arg_63_1

	arg_63_0:updateTransform(true)

	if not arg_63_2 or arg_63_1 == arg_63_2 then
		return
	end

	arg_63_0._tweenOffsetYId = arg_63_0._scene.tween:tweenFloat(arg_63_1, arg_63_2, arg_63_3, arg_63_0._tweenOffsetYFrame, arg_63_0._tweenOffsetYFinish, arg_63_0, {
		from = arg_63_1,
		to = arg_63_2
	}, EaseType.OutQuad)
end

function var_0_0._tweenOffsetYFrame(arg_64_0, arg_64_1, arg_64_2)
	arg_64_0._offsetY = arg_64_1

	arg_64_0:updateTransform(true)
end

function var_0_0._tweenOffsetYFinish(arg_65_0, arg_65_1)
	arg_65_0._offsetY = arg_65_1.to

	arg_65_0:updateTransform(true)
end

function var_0_0._updateCameraClipPlane(arg_66_0)
	if arg_66_0._camerClipPlaneMin[arg_66_0._cameraState] and arg_66_0.camera then
		arg_66_0.camera.nearClipPlane = arg_66_0._camerClipPlaneMin[arg_66_0._cameraState]
		arg_66_0.camera.farClipPlane = arg_66_0._camerClipPlaneMax[arg_66_0._cameraState]
	end
end

function var_0_0.refreshOrthCamera(arg_67_0)
	gohelper.setActive(arg_67_0.orthCameraGO, true)
	TaskDispatcher.cancelTask(arg_67_0._hideOrthCamera, arg_67_0)
	TaskDispatcher.runDelay(arg_67_0._hideOrthCamera, arg_67_0, 0.01)
end

function var_0_0._hideOrthCamera(arg_68_0)
	TaskDispatcher.cancelTask(arg_68_0._hideOrthCamera, arg_68_0)
	gohelper.setActive(arg_68_0.orthCameraGO, false)
end

return var_0_0
