module("modules.logic.commandstation.view.CommandStationMapSceneView", package.seeall)

local var_0_0 = class("CommandStationMapSceneView", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._gofullscreen = gohelper.findChild(arg_4_0.viewGO, "#go_bg")
	arg_4_0._tempVector = Vector3()
	arg_4_0._dragDeltaPos = Vector3()

	arg_4_0:_initMap()
	arg_4_0:_initDrag()
end

function var_0_0._initMap(arg_5_0)
	local var_5_0 = CameraMgr.instance:getMainCameraTrs().parent
	local var_5_1 = CameraMgr.instance:getSceneRoot()

	arg_5_0._sceneRoot = UnityEngine.GameObject.New("CommandStationMapScene")

	local var_5_2, var_5_3, var_5_4 = transformhelper.getLocalPos(var_5_0)

	transformhelper.setLocalPos(arg_5_0._sceneRoot.transform, 0, var_5_3, 0)
	gohelper.addChild(var_5_1, arg_5_0._sceneRoot)
end

function var_0_0._initDrag(arg_6_0)
	arg_6_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_6_0._gofullscreen)

	arg_6_0._drag:AddDragBeginListener(arg_6_0._onDragBegin, arg_6_0)
	arg_6_0._drag:AddDragEndListener(arg_6_0._onDragEnd, arg_6_0)
	arg_6_0._drag:AddDragListener(arg_6_0._onDrag, arg_6_0)
end

function var_0_0.getDragWorldPos(arg_7_0, arg_7_1)
	local var_7_0 = CameraMgr.instance:getMainCamera()
	local var_7_1 = arg_7_0._gofullscreen.transform.position

	return (SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(arg_7_1.position, var_7_0, var_7_1))
end

function var_0_0._onDragBegin(arg_8_0, arg_8_1, arg_8_2)
	if ViewMgr.instance:isOpen(ViewName.CommandStationCharacterEventView) then
		return
	end

	arg_8_0._dragBeginPos = arg_8_0:getDragWorldPos(arg_8_2)

	if arg_8_0._sceneTrans then
		arg_8_0._beginDragPos = arg_8_0._sceneTrans.localPosition
	end
end

function var_0_0._onDragEnd(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0._dragBeginPos = nil
	arg_9_0._beginDragPos = nil
end

function var_0_0._onDrag(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_0._dragBeginPos then
		return
	end

	local var_10_0 = arg_10_0:getDragWorldPos(arg_10_2) - arg_10_0._dragBeginPos

	arg_10_0:drag(var_10_0)
end

function var_0_0.drag(arg_11_0, arg_11_1)
	if not arg_11_0._sceneTrans or not arg_11_0._beginDragPos then
		return
	end

	arg_11_0._dragDeltaPos.x = arg_11_1.x
	arg_11_0._dragDeltaPos.y = arg_11_1.y

	local var_11_0 = arg_11_0:vectorAdd(arg_11_0._beginDragPos, arg_11_0._dragDeltaPos)

	arg_11_0:setScenePosSafety(var_11_0)
end

function var_0_0.vectorAdd(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0._tempVector

	var_12_0.x = arg_12_1.x + arg_12_2.x
	var_12_0.y = arg_12_1.y + arg_12_2.y

	return var_12_0
end

function var_0_0._changeMap(arg_13_0, arg_13_1)
	if arg_13_0._sceneUrl == arg_13_1 then
		CommandStationController.instance:dispatchEvent(CommandStationEvent.MapLoadFinish, arg_13_0._sceneGo)
		CommandStationController.instance:dispatchEvent(CommandStationEvent.MoveScene)

		return
	end

	if not arg_13_0._oldMapLoader and arg_13_0._sceneGo then
		arg_13_0._oldMapLoader = arg_13_0._mapLoader
		arg_13_0._oldSceneGo = arg_13_0._sceneGo
		arg_13_0._mapLoader = nil
	end

	if arg_13_0._mapLoader then
		arg_13_0._mapLoader:dispose()

		arg_13_0._mapLoader = nil
	end

	arg_13_0._sceneUrl = arg_13_1

	local var_13_0 = CommandStationMapModel.instance:getPreloadSceneLoader()
	local var_13_1 = CommandStationMapModel.instance:getPreloadScene()

	if var_13_0 and var_13_1 then
		CommandStationMapModel.instance:setPreloadScene(nil, nil)

		arg_13_0._mapLoader = var_13_0

		arg_13_0:_initSceneGo(var_13_1)

		return
	end

	arg_13_0._mapLoader = MultiAbLoader.New()

	arg_13_0._mapLoader:addPath(arg_13_0._sceneUrl)
	arg_13_0._mapLoader:startLoad(arg_13_0._loadSceneFinish, arg_13_0)
end

function var_0_0._loadSceneFinish(arg_14_0)
	arg_14_0:_disposeOldMap()

	local var_14_0 = arg_14_0._sceneUrl
	local var_14_1 = arg_14_0._mapLoader:getAssetItem(var_14_0):GetResource(var_14_0)
	local var_14_2 = gohelper.clone(var_14_1, arg_14_0._sceneRoot)

	arg_14_0:_initSceneGo(var_14_2)
end

function var_0_0._initSceneGo(arg_15_0, arg_15_1)
	gohelper.setActive(arg_15_1, true)

	arg_15_0._sceneGo = arg_15_1

	gohelper.addChild(arg_15_0._sceneRoot, arg_15_1)

	arg_15_0._sceneTrans = arg_15_0._sceneGo.transform

	transformhelper.setLocalPos(arg_15_0._sceneTrans, 0, 0, 0)
	transformhelper.setLocalScale(arg_15_0._sceneTrans, 1, 1, 1)
	CommandStationMapModel.instance:setSceneGo(arg_15_0._sceneGo)
	MainCameraMgr.instance:addView(arg_15_0.viewName, arg_15_0._initCamera, arg_15_0._resetCamera, arg_15_0)
	MainCameraMgr.instance:setCloseViewFinishReset(arg_15_0.viewName, true)
	arg_15_0:_initScene()
	CommandStationController.instance:dispatchEvent(CommandStationEvent.MapLoadFinish, arg_15_0._sceneGo)
end

function var_0_0.getSceneGo(arg_16_0)
	return arg_16_0._sceneGo
end

function var_0_0._setBlur(arg_17_0, arg_17_1)
	arg_17_0._blurOriginalParam = arg_17_0._blurOriginalParam or {
		dofFactor = PostProcessingMgr.instance:getUnitPPValue("dofFactor"),
		dofDistance = PostProcessingMgr.instance:getUnitPPValue("dofDistance"),
		dofSampleScale = PostProcessingMgr.instance:getUnitPPValue("dofSampleScale"),
		dofRT1Scale = PostProcessingMgr.instance:getUnitPPValue("dofRT1Scale"),
		dofRT2Scale = PostProcessingMgr.instance:getUnitPPValue("dofRT2Scale"),
		dofRT3Scale = PostProcessingMgr.instance:getUnitPPValue("dofRT3Scale"),
		dofTotalScale = PostProcessingMgr.instance:getUnitPPValue("dofTotalScale"),
		rolesStoryMaskActive = PostProcessingMgr.instance:getUnitPPValue("rolesStoryMaskActive"),
		bloomActive = PostProcessingMgr.instance:getUnitPPValue("bloomActive")
	}

	if arg_17_1 then
		if arg_17_0._tweenFactorFinish then
			PostProcessingMgr.instance:setUnitPPValue("dofFactor", 1)
		end

		PostProcessingMgr.instance:setUnitPPValue("dofDistance", 0)
		PostProcessingMgr.instance:setUnitPPValue("dofSampleScale", Vector4(0.1, 0.1, 2, 0))
		PostProcessingMgr.instance:setUnitPPValue("dofRT1Scale", 1)
		PostProcessingMgr.instance:setUnitPPValue("dofRT2Scale", 1)
		PostProcessingMgr.instance:setUnitPPValue("dofRT3Scale", 2)
		PostProcessingMgr.instance:setUnitPPValue("dofTotalScale", 1)
		PostProcessingMgr.instance:setUnitPPValue("rolesStoryMaskActive", false)
		PostProcessingMgr.instance:setUnitPPValue("bloomActive", false)
		gohelper.setActive(CameraMgr.instance:getUnitCameraGO(), true)
	else
		if not arg_17_0._blurOriginalParam then
			return
		end

		gohelper.setActive(CameraMgr.instance:getUnitCameraGO(), false)
		PostProcessingMgr.instance:setUnitPPValue("dofFactor", arg_17_0._blurOriginalParam.dofFactor)
		PostProcessingMgr.instance:setUnitPPValue("dofDistance", arg_17_0._blurOriginalParam.dofDistance)
		PostProcessingMgr.instance:setUnitPPValue("dofSampleScale", arg_17_0._blurOriginalParam.dofSampleScale)
		PostProcessingMgr.instance:setUnitPPValue("dofRT1Scale", arg_17_0._blurOriginalParam.dofRT1Scale)
		PostProcessingMgr.instance:setUnitPPValue("dofRT2Scale", arg_17_0._blurOriginalParam.dofRT2Scale)
		PostProcessingMgr.instance:setUnitPPValue("dofRT3Scale", arg_17_0._blurOriginalParam.dofRT3Scale)
		PostProcessingMgr.instance:setUnitPPValue("dofTotalScale", arg_17_0._blurOriginalParam.dofTotalScale)
		PostProcessingMgr.instance:setUnitPPValue("rolesStoryMaskActive", arg_17_0._blurOriginalParam.rolesStoryMaskActive)
		PostProcessingMgr.instance:setUnitPPValue("bloomActive", arg_17_0._blurOriginalParam.bloomActive)

		arg_17_0._blurOriginalParam = nil
	end
end

function var_0_0._initCamera(arg_18_0)
	if arg_18_0._sceneVisible == false then
		return
	end

	arg_18_0._targetOrghographic = false
	arg_18_0._targetFov = var_0_0.getFov(CommandStationEnum.CameraFov)
	arg_18_0._targetPosZ = -7.5
	arg_18_0._targetRotation = CommandStationEnum.CameraRotation + 360

	local var_18_0 = CameraMgr.instance:getMainCamera()

	var_18_0.orthographic = arg_18_0._targetOrghographic
	var_18_0.fieldOfView = arg_18_0._targetFov

	local var_18_1 = CameraMgr.instance:getCameraTraceGO()

	transformhelper.setLocalPos(var_18_1.transform, 0, 0, arg_18_0._targetPosZ)
	transformhelper.setLocalRotation(var_18_1.transform, arg_18_0._targetRotation, 0, 0)
	arg_18_0:_setBlur(true)
end

function var_0_0.getFov(arg_19_0)
	local var_19_0 = 1.7777777777777777 * (UnityEngine.Screen.height / UnityEngine.Screen.width)

	if BootNativeUtil.isWindows() and not SLFramework.FrameworkSettings.IsEditor then
		local var_19_1, var_19_2 = SettingsModel.instance:getCurrentScreenSize()

		var_19_0 = 16 * var_19_2 / 9 / var_19_1
	end

	return arg_19_0 * var_19_0
end

function var_0_0._resetCamera(arg_20_0)
	arg_20_0:_doScreenResize()
	arg_20_0:_setBlur(false)
end

function var_0_0._doScreenResize(arg_21_0)
	local var_21_0, var_21_1 = GameGlobalMgr.instance:getScreenState():getScreenSize()

	GameGlobalMgr.instance:dispatchEvent(GameStateEvent.OnScreenResize, var_21_0, var_21_1)
end

function var_0_0._initScene(arg_22_0)
	if arg_22_0._sceneVisible == false then
		return
	end

	arg_22_0:_initCamera()

	local var_22_0 = gohelper.findChild(arg_22_0._sceneGo, "root/size")
	local var_22_1 = var_22_0 and var_22_0:GetComponentInChildren(typeof(UnityEngine.BoxCollider))

	if var_22_1 then
		arg_22_0._mapSize = var_22_1.size
	else
		logError(string.format("CommandStationMapSceneView _initScene scene:%s 的root/size 缺少 BoxCollider,请联系地编处理", arg_22_0._sceneUrl))

		arg_22_0._mapSize = Vector2()
	end

	local var_22_2 = arg_22_0._mapSize.x
	local var_22_3 = arg_22_0._mapSize.y
	local var_22_4 = CameraMgr.instance:getMainCamera()
	local var_22_5 = UnityEngine.Screen.width
	local var_22_6 = UnityEngine.Screen.height
	local var_22_7 = Vector3(0, var_22_6, 0)
	local var_22_8 = Vector3(var_22_5, 0, 0)
	local var_22_9 = Vector3.forward
	local var_22_10 = Vector3.zero
	local var_22_11 = arg_22_0:_getRayPlaneIntersection(var_22_4:ScreenPointToRay(var_22_7), var_22_9, var_22_10)
	local var_22_12 = arg_22_0:_getRayPlaneIntersection(var_22_4:ScreenPointToRay(var_22_8), var_22_9, var_22_10)

	arg_22_0._viewWidth = math.abs(var_22_12.x - var_22_11.x)
	arg_22_0._viewHeight = math.abs(var_22_12.y - var_22_11.y)
	arg_22_0._halfViewWidth = arg_22_0._viewWidth / 2
	arg_22_0._halfViewHeight = arg_22_0._viewHeight / 2

	local var_22_13 = arg_22_0._sceneRoot.transform.position
	local var_22_14 = 1
	local var_22_15 = -1
	local var_22_16 = 1
	local var_22_17 = -1

	arg_22_0._mapMinX = var_22_11.x - (var_22_2 - arg_22_0._viewWidth) - var_22_13.x + var_22_14
	arg_22_0._mapMaxX = var_22_11.x - var_22_13.x + var_22_15
	arg_22_0._mapMinY = var_22_11.y - var_22_13.y + var_22_16
	arg_22_0._mapMaxY = var_22_11.y + (var_22_3 - arg_22_0._viewHeight) - var_22_13.y + var_22_17

	local var_22_18 = arg_22_0._sceneConfig.leftUpRange
	local var_22_19 = arg_22_0._sceneConfig.rightDownRange
	local var_22_20 = -var_22_19[1] + arg_22_0._halfViewWidth
	local var_22_21 = -var_22_18[1] - arg_22_0._halfViewWidth
	local var_22_22 = -var_22_18[2] + arg_22_0._halfViewHeight
	local var_22_23 = -var_22_19[2] - arg_22_0._halfViewHeight

	arg_22_0._dragMapMinX = math.min(var_22_20, var_22_21)
	arg_22_0._dragMapMaxX = math.max(var_22_20, var_22_21)
	arg_22_0._dragMapMinY = math.min(var_22_22, var_22_23)
	arg_22_0._dragMapMaxY = math.max(var_22_22, var_22_23)

	arg_22_0:_setInitPos()
end

function var_0_0._getRayPlaneIntersection(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = arg_23_1.origin
	local var_23_1 = arg_23_1.direction
	local var_23_2 = Vector3.Dot(var_23_1, arg_23_2)

	return var_23_0 + var_23_1 * (Vector3.Dot(arg_23_3 - var_23_0, arg_23_2) / var_23_2)
end

function var_0_0._getInitPos(arg_24_0)
	return "-8#4"
end

function var_0_0._setInitPos(arg_25_0, arg_25_1)
	if not arg_25_0._sceneTrans then
		return
	end

	if arg_25_0._targetPos then
		arg_25_0:setScenePosSafety(arg_25_0._targetPos, arg_25_1, arg_25_0._skipInBoundary)

		return
	end

	local var_25_0 = arg_25_0:_getInitPos()
	local var_25_1 = string.splitToNumber(var_25_0, "#")

	arg_25_0:setScenePosSafety(Vector3(var_25_1[1], var_25_1[2], 0), arg_25_1)
end

function var_0_0._getMapInfo(arg_26_0, arg_26_1)
	if arg_26_1 then
		return arg_26_0._mapMinX, arg_26_0._mapMinY, arg_26_0._mapMaxX, arg_26_0._mapMaxY
	else
		return arg_26_0._dragMapMinX, arg_26_0._dragMapMinY, arg_26_0._dragMapMaxX, arg_26_0._dragMapMaxY
	end
end

function var_0_0.setScenePosSafety(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	if not arg_27_0._sceneTrans then
		return
	end

	arg_27_0._skipInBoundary = arg_27_3

	local var_27_0, var_27_1, var_27_2, var_27_3 = arg_27_0:_getMapInfo(arg_27_3)

	arg_27_1.x = Mathf.Clamp(arg_27_1.x, var_27_0, var_27_2)
	arg_27_1.y = Mathf.Clamp(arg_27_1.y, var_27_1, var_27_3)
	arg_27_0._targetPos = arg_27_1

	if arg_27_0._tweenId then
		ZProj.TweenHelper.KillById(arg_27_0._tweenId)

		arg_27_0._tweenId = nil
	end

	if arg_27_2 then
		CommandStationController.instance:dispatchEvent(CommandStationEvent.MoveScene, true)

		local var_27_4 = arg_27_0._tweenTime or 0.6

		arg_27_0._tweenTime = nil

		UIBlockHelper.instance:startBlock("CommandStationMapSceneView", var_27_4, arg_27_0.viewName)

		arg_27_0._tweenId = ZProj.TweenHelper.DOLocalMove(arg_27_0._sceneTrans, arg_27_1.x, arg_27_1.y, 0, var_27_4, arg_27_0._localMoveDone, arg_27_0, nil, EaseType.InOutCubic)
	else
		arg_27_0._sceneTrans.localPosition = arg_27_1

		CommandStationController.instance:dispatchEvent(CommandStationEvent.MoveScene)
	end
end

function var_0_0._localMoveDone(arg_28_0)
	CommandStationController.instance:dispatchEvent(CommandStationEvent.MoveScene)
end

function var_0_0.setSceneVisible(arg_29_0, arg_29_1)
	arg_29_0._sceneVisible = arg_29_1

	gohelper.setActive(arg_29_0._sceneRoot, arg_29_1 and true or false)
	arg_29_0:_setBlur(arg_29_1)
	arg_29_0:_doScreenResize()
end

function var_0_0.onOpen(arg_30_0)
	arg_30_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_30_0._onScreenResize, arg_30_0, LuaEventSystem.Low)
	arg_30_0:addEventCb(CommandStationController.instance, CommandStationEvent.SelectTimePoint, arg_30_0._onSelectTimePoint, arg_30_0)
	arg_30_0:addEventCb(CommandStationController.instance, CommandStationEvent.SceneFocusPos, arg_30_0._onSceneFocusPos, arg_30_0)
	arg_30_0:addEventCb(CommandStationController.instance, CommandStationEvent.RTGoHide, arg_30_0._onRTGoHide, arg_30_0)
	arg_30_0:addEventCb(PostProcessingMgr.instance, PostProcessingEvent.onUnitCameraVisibleChange, arg_30_0._onUnitCameraVisibleChange, arg_30_0, LuaEventSystem.Low)
	arg_30_0:addEventCb(ViewMgr.instance, ViewEvent.BeforeOpenView, arg_30_0._onBeforeOpenView, arg_30_0)
	arg_30_0:addEventCb(ViewMgr.instance, ViewEvent.ReOpenWhileOpen, arg_30_0._onReOpenWhileOpen, arg_30_0)
	arg_30_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_30_0._OnCloseView, arg_30_0)
	arg_30_0:_showTimeId(CommandStationMapModel.instance:getTimeId())
	TaskDispatcher.runRepeat(arg_30_0._protectedCamera, arg_30_0, 0)
end

function var_0_0._protectedCamera(arg_31_0)
	if arg_31_0._sceneVisible == false or not arg_31_0._sceneGo then
		return
	end

	local var_31_0 = CameraMgr.instance:getMainCamera()
	local var_31_1 = CameraMgr.instance:getCameraTraceGO()
	local var_31_2 = transformhelper.getLocalRotation(var_31_1.transform)
	local var_31_3, var_31_4, var_31_5 = transformhelper.getLocalPos(var_31_1.transform)

	if var_31_0.orthographic ~= arg_31_0._targetOrghographic or var_31_5 ~= arg_31_0._targetPosZ or var_31_2 ~= arg_31_0._targetRotation then
		arg_31_0:_initCamera()
	end
end

function var_0_0._onRTGoHide(arg_32_0)
	arg_32_0._tweenFactor = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, arg_32_0._tweenUpdate, arg_32_0._tweenFinish, arg_32_0)
end

function var_0_0._tweenUpdate(arg_33_0, arg_33_1)
	if not arg_33_0._blurOriginalParam then
		return
	end

	PostProcessingMgr.instance:setUnitPPValue("dofFactor", arg_33_1)
end

function var_0_0._tweenFinish(arg_34_0)
	arg_34_0._tweenFactorFinish = true
end

function var_0_0.onOpenFinish(arg_35_0)
	TaskDispatcher.cancelTask(arg_35_0._protectedCamera, arg_35_0)
end

function var_0_0._onUnitCameraVisibleChange(arg_36_0, arg_36_1)
	if not arg_36_1 and arg_36_0._blurOriginalParam and arg_36_0._sceneVisible ~= false then
		gohelper.setActive(CameraMgr.instance:getUnitCameraGO(), true)
	end
end

function var_0_0._OnCloseView(arg_37_0, arg_37_1)
	if ViewMgr.instance:isFull(arg_37_1) and ViewHelper.instance:checkViewOnTheTop(arg_37_0.viewName) then
		arg_37_0._sceneVisible = true

		arg_37_0:_doScreenResize()
	end
end

function var_0_0._onBeforeOpenView(arg_38_0, arg_38_1)
	if arg_38_1 == ViewName.StoreView then
		return
	end

	if ViewMgr.instance:isFull(arg_38_1) and arg_38_1 ~= arg_38_0.viewName then
		arg_38_0.viewContainer:setVisibleInternal(false)

		local var_38_0 = ViewMgr.instance:getContainer(ViewName.CommandStationDispatchEventMainView)

		if var_38_0 then
			var_38_0:setVisibleInternal(false)
		end
	end
end

function var_0_0._onReOpenWhileOpen(arg_39_0, arg_39_1)
	if arg_39_0.viewName == arg_39_1 then
		ViewMgr.instance:closeView(ViewName.CommandStationDispatchEventMainView)

		return
	end

	if ViewMgr.instance:isFull(arg_39_1) and arg_39_1 ~= arg_39_0.viewName then
		arg_39_0.viewContainer:setVisibleInternal(false)
	end
end

function var_0_0._onSceneFocusPos(arg_40_0, arg_40_1, arg_40_2)
	arg_40_1.x = -arg_40_1.x
	arg_40_1.y = -arg_40_1.y - 0.5
	arg_40_1.z = 0

	arg_40_0:setScenePosSafety(arg_40_1, true, not arg_40_2)
end

function var_0_0._onSelectTimePoint(arg_41_0, arg_41_1)
	arg_41_0:_showTimeId(arg_41_1)
end

function var_0_0._showTimeId(arg_42_0, arg_42_1)
	if not arg_42_1 then
		return
	end

	if arg_42_0._timeId == arg_42_1 then
		return
	end

	arg_42_0._timeId = arg_42_1

	CommandStationMapModel.instance:setTimeId(arg_42_1)

	local var_42_0 = CommandStationMapModel.instance:getCurTimeIdScene()

	if not var_42_0 then
		return
	end

	arg_42_0._sceneConfig = var_42_0

	local var_42_1 = var_42_0.scene

	arg_42_0:_changeMap(var_42_1)
end

function var_0_0._onScreenResize(arg_43_0)
	if arg_43_0._sceneGo then
		arg_43_0:_initScene()
	end
end

function var_0_0._disposeOldMap(arg_44_0)
	if arg_44_0._oldSceneGo then
		gohelper.destroy(arg_44_0._oldSceneGo)

		arg_44_0._oldSceneGo = nil
	end

	if arg_44_0._oldMapLoader then
		arg_44_0._oldMapLoader:dispose()

		arg_44_0._oldMapLoader = nil
	end
end

function var_0_0.onClose(arg_45_0)
	arg_45_0:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_45_0._onScreenResize, arg_45_0)
	arg_45_0._drag:RemoveDragBeginListener()
	arg_45_0._drag:RemoveDragListener()
	arg_45_0._drag:RemoveDragEndListener()
	CommandStationMapModel.instance:clearSceneInfo()
	TaskDispatcher.cancelTask(arg_45_0._protectedCamera, arg_45_0)

	if arg_45_0._tweenFactor then
		ZProj.TweenHelper.KillById(arg_45_0._tweenFactor)

		arg_45_0._tweenFactor = nil
	end

	if arg_45_0._tweenId then
		ZProj.TweenHelper.KillById(arg_45_0._tweenId)

		arg_45_0._tweenId = nil
	end
end

function var_0_0.onCloseFinish(arg_46_0)
	return
end

function var_0_0.onDestroyView(arg_47_0)
	gohelper.destroy(arg_47_0._sceneRoot)

	if arg_47_0._mapLoader then
		arg_47_0._mapLoader:dispose()
	end

	arg_47_0:_disposeOldMap()
end

return var_0_0
