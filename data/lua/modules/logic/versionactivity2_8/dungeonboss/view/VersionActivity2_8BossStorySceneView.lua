module("modules.logic.versionactivity2_8.dungeonboss.view.VersionActivity2_8BossStorySceneView", package.seeall)

local var_0_0 = class("VersionActivity2_8BossStorySceneView", BaseView)

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
	arg_4_0._gofullscreen = gohelper.findChild(arg_4_0.viewGO, "#go_fullscreen")
	arg_4_0._tempVector = Vector3()
	arg_4_0._dragDeltaPos = Vector3()

	arg_4_0:_initMap()
	arg_4_0:_initDrag()
end

function var_0_0._initMap(arg_5_0)
	local var_5_0 = CameraMgr.instance:getMainCameraTrs().parent
	local var_5_1 = CameraMgr.instance:getSceneRoot()

	arg_5_0._sceneRoot = UnityEngine.GameObject.New("BossStoryScene")

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
	if not arg_13_1 then
		logError("VersionActivity2_8BossStorySceneView mapCfg is nil")

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

	arg_13_0._mapCfg = arg_13_1
	arg_13_0._mapLoader = MultiAbLoader.New()
	arg_13_0._sceneUrl = string.format("scenes/%s.prefab", arg_13_1.res)

	arg_13_0._mapLoader:addPath(arg_13_0._sceneUrl)
	arg_13_0._mapLoader:startLoad(arg_13_0._loadSceneFinish, arg_13_0)
end

function var_0_0._loadSceneFinish(arg_14_0)
	arg_14_0:_disposeOldMap()

	local var_14_0 = arg_14_0._sceneUrl
	local var_14_1 = arg_14_0._mapLoader:getAssetItem(var_14_0):GetResource(var_14_0)

	arg_14_0._sceneGo = gohelper.clone(var_14_1, arg_14_0._sceneRoot)
	arg_14_0._sceneTrans = arg_14_0._sceneGo.transform
	arg_14_0._animator = arg_14_0._sceneGo:GetComponent("Animator")
	arg_14_0._animator.enabled = false

	transformhelper.setLocalScale(arg_14_0._sceneTrans, VersionActivity2_8BossEnum.SceneNearScale, VersionActivity2_8BossEnum.SceneNearScale, VersionActivity2_8BossEnum.SceneNearScale)
	MainCameraMgr.instance:addView(arg_14_0.viewName, arg_14_0._initCamera, nil, arg_14_0)
	arg_14_0:_initScene()
end

function var_0_0._initCamera(arg_15_0)
	local var_15_0 = CameraMgr.instance:getMainCamera()

	var_15_0.orthographic = true
	var_15_0.orthographicSize = 5 * GameUtil.getAdapterScale()
end

function var_0_0._initScene(arg_16_0)
	arg_16_0._mapSize = gohelper.findChild(arg_16_0._sceneGo, "root/size"):GetComponentInChildren(typeof(UnityEngine.BoxCollider)).size

	local var_16_0 = arg_16_0._mapSize.x * VersionActivity2_8BossEnum.SceneNearScale
	local var_16_1 = arg_16_0._mapSize.y * VersionActivity2_8BossEnum.SceneNearScale
	local var_16_2
	local var_16_3 = GameUtil.getAdapterScale()

	if var_16_3 ~= 1 then
		var_16_2 = ViewMgr.instance:getUILayer(UILayerName.Hud)
	else
		var_16_2 = ViewMgr.instance:getUIRoot()
	end

	local var_16_4 = var_16_2.transform:GetWorldCorners()
	local var_16_5 = var_16_4[1] * var_16_3
	local var_16_6 = var_16_4[3] * var_16_3

	arg_16_0._viewWidth = math.abs(var_16_6.x - var_16_5.x)
	arg_16_0._viewHeight = math.abs(var_16_6.y - var_16_5.y)
	arg_16_0._mapMinX = var_16_5.x - (var_16_0 - arg_16_0._viewWidth)
	arg_16_0._mapMaxX = var_16_5.x
	arg_16_0._mapMinY = var_16_5.y
	arg_16_0._mapMaxY = var_16_5.y + (var_16_1 - arg_16_0._viewHeight)

	arg_16_0:_setInitPos()
end

function var_0_0._getInitPos(arg_17_0)
	if ViewMgr.instance:isOpen(ViewName.VersionActivity2_8BossStoryLoadingView) and arg_17_0._episodeId == VersionActivity2_8BossEnum.StoryBossSecondEpisode and not GuideController.instance:isForbidGuides() and not GuideModel.instance:isGuideFinish(VersionActivity2_8BossEnum.StoryBossSecondEpisodeGuideId) then
		return "-31.5#14.4"
	end

	if arg_17_0._moveToTargetMap then
		local var_17_0 = arg_17_0._moveToTargetMap

		arg_17_0._moveToTargetMap = nil

		return var_17_0.initPos
	end

	return arg_17_0._mapCfg.initPos
end

function var_0_0._setInitPos(arg_18_0, arg_18_1)
	if not arg_18_0._sceneTrans then
		return
	end

	local var_18_0 = arg_18_0:_getInitPos()
	local var_18_1 = string.splitToNumber(var_18_0, "#")

	arg_18_0:setScenePosSafety(Vector3(var_18_1[1], var_18_1[2], 0), arg_18_1)
	arg_18_0:_moveMapPos()
end

function var_0_0.setScenePosSafety(arg_19_0, arg_19_1, arg_19_2)
	if not arg_19_0._sceneTrans then
		return
	end

	if arg_19_1.x < arg_19_0._mapMinX then
		arg_19_1.x = arg_19_0._mapMinX
	elseif arg_19_1.x > arg_19_0._mapMaxX then
		arg_19_1.x = arg_19_0._mapMaxX
	end

	if arg_19_1.y < arg_19_0._mapMinY then
		arg_19_1.y = arg_19_0._mapMinY
	elseif arg_19_1.y > arg_19_0._mapMaxY then
		arg_19_1.y = arg_19_0._mapMaxY
	end

	arg_19_0._targetPos = arg_19_1

	if arg_19_2 then
		local var_19_0 = arg_19_0._tweenTime or 0.3

		arg_19_0._tweenTime = nil

		UIBlockHelper.instance:startBlock("VersionActivity2_8BossStorySceneView", var_19_0, arg_19_0.viewName)
		ZProj.TweenHelper.DOLocalMove(arg_19_0._sceneTrans, arg_19_1.x, arg_19_1.y, 0, var_19_0, arg_19_0._localMoveDone, arg_19_0, nil, EaseType.InOutQuart)
	else
		arg_19_0._sceneTrans.localPosition = arg_19_1
	end
end

function var_0_0._localMoveDone(arg_20_0)
	return
end

function var_0_0.setSceneVisible(arg_21_0, arg_21_1)
	gohelper.setActive(arg_21_0._sceneRoot, arg_21_1 and true or false)
end

function var_0_0.onOpen(arg_22_0)
	arg_22_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_22_0._onScreenResize, arg_22_0)
	arg_22_0:addEventCb(DungeonController.instance, DungeonEvent.BossStoryReset, arg_22_0._onBossStoryReset, arg_22_0)
	arg_22_0:addEventCb(DungeonController.instance, DungeonEvent.BossStoryMoveMap, arg_22_0._onBossStoryMoveMap, arg_22_0)
	arg_22_0:addEventCb(DungeonController.instance, DungeonEvent.BossStoryMoveMapAnim, arg_22_0._onBossStoryMoveMapAnim, arg_22_0)
	arg_22_0:addEventCb(DungeonController.instance, DungeonEvent.BossStoryPreMoveMapPos, arg_22_0._onBossStoryPreMoveMapPos, arg_22_0)
	arg_22_0:_startChangeMap()
end

function var_0_0.getMap()
	local var_23_0 = VersionActivity2_8BossModel.instance:getStoryBossCurEpisodeId()
	local var_23_1 = VersionActivity2_8BossConfig.instance:getEpisodeMapId(var_23_0)

	return lua_chapter_map.configDict[var_23_1], var_23_0
end

function var_0_0._startChangeMap(arg_24_0)
	arg_24_0._map, arg_24_0._episodeId = var_0_0.getMap()

	if arg_24_0._map then
		arg_24_0:_changeMap(arg_24_0._map)
	else
		logError(string.format("map is not exist,episodeId:%s", arg_24_0._episodeId))
	end
end

function var_0_0._onScreenResize(arg_25_0)
	if arg_25_0._sceneGo then
		arg_25_0:_initScene()
	end
end

function var_0_0._onBossStoryMoveMap(arg_26_0, arg_26_1)
	arg_26_0._tweenMapPosParam = string.splitToNumber(arg_26_1, "_")

	arg_26_0:_moveMapPos()
end

function var_0_0._onBossStoryMoveMapAnim(arg_27_0, arg_27_1)
	arg_27_0._animator.enabled = true

	arg_27_0._animator:Play(arg_27_1, 0, 0)
end

function var_0_0._onBossStoryPreMoveMapPos(arg_28_0, arg_28_1)
	if not ViewMgr.instance:isOpen(ViewName.VersionActivity2_8BossStoryLoadingView) then
		return
	end

	local var_28_0 = tonumber(arg_28_1)
	local var_28_1 = VersionActivity2_8BossConfig.instance:getEpisodeMapId(var_28_0)

	arg_28_0._moveToTargetMap = lua_chapter_map.configDict[var_28_1]

	arg_28_0:_setInitPos()
end

function var_0_0._moveMapPos(arg_29_0)
	if not arg_29_0._sceneTrans then
		return
	end

	if not arg_29_0._tweenMapPosParam then
		return
	end

	local var_29_0 = arg_29_0._tweenMapPosParam[1]
	local var_29_1 = arg_29_0._tweenMapPosParam[2]

	arg_29_0._tweenTime, arg_29_0._tweenMapPosParam = arg_29_0._tweenMapPosParam[3]

	local var_29_2 = VersionActivity2_8BossConfig.instance:getEpisodeMapId(var_29_0)
	local var_29_3 = lua_chapter_map.configDict[var_29_2]
	local var_29_4 = VersionActivity2_8BossConfig.instance:getEpisodeMapId(var_29_1)
	local var_29_5 = lua_chapter_map.configDict[var_29_4]
	local var_29_6 = var_29_3.initPos
	local var_29_7 = string.splitToNumber(var_29_6, "#")

	arg_29_0:setScenePosSafety(Vector3(var_29_7[1], var_29_7[2], 0))

	local var_29_8 = var_29_5.initPos
	local var_29_9 = string.splitToNumber(var_29_8, "#")

	arg_29_0:setScenePosSafety(Vector3(var_29_9[1], var_29_9[2], 0), true)
end

function var_0_0._onBossStoryReset(arg_30_0)
	arg_30_0:_startChangeMap()
end

function var_0_0._disposeOldMap(arg_31_0)
	if arg_31_0._oldSceneGo then
		gohelper.destroy(arg_31_0._oldSceneGo)

		arg_31_0._oldSceneGo = nil
	end

	if arg_31_0._oldMapLoader then
		arg_31_0._oldMapLoader:dispose()

		arg_31_0._oldMapLoader = nil
	end
end

function var_0_0.onClose(arg_32_0)
	gohelper.destroy(arg_32_0._sceneRoot)

	if arg_32_0._mapLoader then
		arg_32_0._mapLoader:dispose()
	end

	arg_32_0:_disposeOldMap()
	arg_32_0._drag:RemoveDragBeginListener()
	arg_32_0._drag:RemoveDragListener()
	arg_32_0._drag:RemoveDragEndListener()
end

function var_0_0.onDestroyView(arg_33_0)
	return
end

return var_0_0
