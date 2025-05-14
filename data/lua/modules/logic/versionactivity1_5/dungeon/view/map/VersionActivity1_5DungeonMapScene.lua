module("modules.logic.versionactivity1_5.dungeon.view.map.VersionActivity1_5DungeonMapScene", package.seeall)

local var_0_0 = class("VersionActivity1_5DungeonMapScene", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gofullscreen = gohelper.findChild(arg_1_0.viewGO, "#go_fullscreen")

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
	arg_4_0.mapSceneElementsView = arg_4_0.viewContainer.mapSceneElements

	if ViewMgr.instance:isOpen(ViewName.MainThumbnailView) then
		MainThumbnailHeroView.setCameraIdle()
	end

	arg_4_0._tempVector = Vector3()
	arg_4_0._dragDeltaPos = Vector3()
	arg_4_0._scenePos = Vector3()

	arg_4_0:_initMapRootNode()
	arg_4_0:_initDrag()
	gohelper.setActive(arg_4_0._gointeractitem, false)
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_5_0._onOpenView, arg_5_0)
	arg_5_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_5_0._onCloseView, arg_5_0)
	arg_5_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_5_0._onScreenResize, arg_5_0)
	arg_5_0:addEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, arg_5_0.onModeChange, arg_5_0)
	arg_5_0:addEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnActivityDungeonMoChange, arg_5_0.onActivityDungeonMoChange, arg_5_0)
	arg_5_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnClickElement, arg_5_0.onClickElement, arg_5_0)
	arg_5_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.FocusElement, arg_5_0.onFocusElement, arg_5_0)
	MainCameraMgr.instance:addView(arg_5_0.viewName, arg_5_0._initCamera, nil, arg_5_0)
	arg_5_0:refreshMap()
end

function var_0_0._initDrag(arg_6_0)
	arg_6_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_6_0._gofullscreen)

	arg_6_0._drag:AddDragBeginListener(arg_6_0._onDragBegin, arg_6_0)
	arg_6_0._drag:AddDragEndListener(arg_6_0._onDragEnd, arg_6_0)
	arg_6_0._drag:AddDragListener(arg_6_0._onDrag, arg_6_0)
end

function var_0_0._onOpenView(arg_7_0, arg_7_1)
	if arg_7_1 == ViewName.StoryView then
		arg_7_0:_disposeScene()
		GameGCMgr.instance:dispatchEvent(GameGCEvent.DelayFullGC, 0, arg_7_0)
	end
end

function var_0_0._onCloseView(arg_8_0, arg_8_1)
	if arg_8_1 == ViewName.StoryView then
		arg_8_0:_rebuildScene()
	end
end

function var_0_0._onDragBegin(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0._dragBeginPos = arg_9_0:getDragWorldPos(arg_9_2)

	DungeonController.instance:dispatchEvent(DungeonEvent.OnBeginDragMap)
end

function var_0_0._onDragEnd(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._dragBeginPos = nil
end

function var_0_0._onDrag(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_0._dragBeginPos then
		return
	end

	local var_11_0 = arg_11_0:getDragWorldPos(arg_11_2)
	local var_11_1 = var_11_0 - arg_11_0._dragBeginPos

	arg_11_0._dragBeginPos = var_11_0

	arg_11_0._tempVector:Set(arg_11_0._scenePos.x + var_11_1.x, arg_11_0._scenePos.y + var_11_1.y)
	arg_11_0:directSetScenePos(arg_11_0._tempVector)
end

function var_0_0.getTargetPos(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.x
	local var_12_1 = arg_12_1.y

	if var_12_0 < arg_12_0._mapMinX then
		var_12_0 = arg_12_0._mapMinX
	elseif var_12_0 > arg_12_0._mapMaxX then
		var_12_0 = arg_12_0._mapMaxX
	end

	if var_12_1 < arg_12_0._mapMinY then
		var_12_1 = arg_12_0._mapMinY
	elseif var_12_1 > arg_12_0._mapMaxY then
		var_12_1 = arg_12_0._mapMaxY
	end

	return var_12_0, var_12_1
end

function var_0_0.directSetScenePos(arg_13_0, arg_13_1)
	local var_13_0, var_13_1 = arg_13_0:getTargetPos(arg_13_1)

	arg_13_0._scenePos.x = var_13_0
	arg_13_0._scenePos.y = var_13_1

	transformhelper.setLocalPos(arg_13_0._sceneTrans, arg_13_0._scenePos.x, arg_13_0._scenePos.y, 0)
	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnMapPosChanged)
end

function var_0_0.tweenSetScenePos(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0._tweenTargetPosX, arg_14_0._tweenTargetPosY = arg_14_0:getTargetPos(arg_14_1)
	arg_14_0._tweenStartPosX, arg_14_0._tweenStartPosY = arg_14_0:getTargetPos(arg_14_2 or arg_14_0._scenePos)

	arg_14_0:killTween()

	arg_14_0.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, DungeonEnum.DefaultTweenMapTime, arg_14_0.tweenFrameCallback, arg_14_0.tweenFinishCallback, arg_14_0)

	arg_14_0:tweenFrameCallback(0)
end

function var_0_0.tweenFrameCallback(arg_15_0, arg_15_1)
	local var_15_0 = Mathf.Lerp(arg_15_0._tweenStartPosX, arg_15_0._tweenTargetPosX, arg_15_1)
	local var_15_1 = Mathf.Lerp(arg_15_0._tweenStartPosY, arg_15_0._tweenTargetPosY, arg_15_1)

	arg_15_0._tempVector:Set(var_15_0, var_15_1, 0)
	arg_15_0:directSetScenePos(arg_15_0._tempVector)
end

function var_0_0.tweenFinishCallback(arg_16_0)
	arg_16_0._tempVector:Set(arg_16_0._tweenTargetPosX, arg_16_0._tweenTargetPosY, 0)
	arg_16_0:directSetScenePos(arg_16_0._tempVector)
	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.TweenMapPosDone)
end

function var_0_0.vectorAdd(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0._tempVector

	var_17_0.x = arg_17_1.x + arg_17_2.x
	var_17_0.y = arg_17_1.y + arg_17_2.y

	return var_17_0
end

function var_0_0.getDragWorldPos(arg_18_0, arg_18_1)
	local var_18_0 = CameraMgr.instance:getMainCamera()
	local var_18_1 = arg_18_0._gofullscreen.transform.position

	return (SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(arg_18_1.position, var_18_0, var_18_1))
end

function var_0_0._initCamera(arg_19_0)
	local var_19_0 = CameraMgr.instance:getMainCamera()

	var_19_0.orthographic = true

	local var_19_1 = GameUtil.getAdapterScale()

	var_19_0.orthographicSize = VersionActivity1_5DungeonEnum.DungeonMapCameraSize * var_19_1
end

function var_0_0._resetCamera(arg_20_0)
	local var_20_0 = CameraMgr.instance:getMainCamera()

	var_20_0.orthographicSize = 5
	var_20_0.orthographic = false
end

function var_0_0._initMapRootNode(arg_21_0)
	local var_21_0 = CameraMgr.instance:getMainCameraTrs().parent
	local var_21_1 = CameraMgr.instance:getSceneRoot()

	arg_21_0._sceneRoot = UnityEngine.GameObject.New(VersionActivity1_5DungeonEnum.SceneRootName)

	local var_21_2, var_21_3, var_21_4 = transformhelper.getLocalPos(var_21_0)

	transformhelper.setLocalPos(arg_21_0._sceneRoot.transform, 0, var_21_3, 0)
	gohelper.addChild(var_21_1, arg_21_0._sceneRoot)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnCreateMapRootGoDone, arg_21_0._sceneRoot)
end

function var_0_0.getSceneGo(arg_22_0)
	return arg_22_0._sceneGo
end

function var_0_0._isSameMap(arg_23_0, arg_23_1, arg_23_2)
	return arg_23_1 == arg_23_2
end

function var_0_0.refreshMap(arg_24_0, arg_24_1)
	arg_24_0._mapCfg = VersionActivity1_5DungeonController.instance:getEpisodeMapConfig(arg_24_0.activityDungeonMo.episodeId)

	if arg_24_0._mapCfg.id == arg_24_0._lastLoadMapId then
		if not arg_24_0.loadDone then
			return
		end

		DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnLoadSceneFinish, {
			mapConfig = arg_24_0._mapCfg,
			mapSceneGo = arg_24_0._sceneGo
		})
		arg_24_0:_initElements()

		return
	end

	arg_24_0.needTween = arg_24_1
	arg_24_0._lastLoadMapId = arg_24_0._mapCfg.id

	arg_24_0:loadMap()
end

function var_0_0.loadMap(arg_25_0)
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnChangeMap)

	if arg_25_0.loadedDone then
		arg_25_0._oldMapLoader = arg_25_0._mapLoader
		arg_25_0._oldSceneGo = arg_25_0._sceneGo
		arg_25_0._mapLoader = nil
	end

	if arg_25_0._mapLoader then
		arg_25_0._mapLoader:dispose()

		arg_25_0._mapLoader = nil
	end

	arg_25_0._tempMapCfg = nil
	arg_25_0.loadedDone = false
	arg_25_0._mapLoader = MultiAbLoader.New()

	local var_25_0 = {}

	arg_25_0:buildLoadRes(var_25_0, arg_25_0._mapCfg)

	arg_25_0._sceneUrl = var_25_0[1]
	arg_25_0._mapLightUrl = var_25_0[2]

	arg_25_0._mapLoader:addPath(arg_25_0._sceneUrl)
	arg_25_0._mapLoader:addPath(arg_25_0._mapLightUrl)
	arg_25_0._mapLoader:startLoad(arg_25_0._loadSceneFinish, arg_25_0)
end

function var_0_0._loadSceneFinish(arg_26_0)
	arg_26_0.loadedDone = true

	arg_26_0:disposeOldMap()

	local var_26_0 = arg_26_0._sceneUrl
	local var_26_1 = arg_26_0._mapLoader:getAssetItem(var_26_0):GetResource(var_26_0)

	arg_26_0._sceneGo = gohelper.clone(var_26_1, arg_26_0._sceneRoot, arg_26_0._mapCfg.id)
	arg_26_0._sceneTrans = arg_26_0._sceneGo.transform

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnLoadSceneFinish, {
		mapConfig = arg_26_0._mapCfg,
		mapSceneGo = arg_26_0._sceneGo
	})
	arg_26_0:_initScene()
	arg_26_0:_setMapPos()
	arg_26_0:_addMapLight()
	arg_26_0:_initElements()
end

function var_0_0.buildLoadRes(arg_27_0, arg_27_1, arg_27_2)
	table.insert(arg_27_1, ResUrl.getDungeonMapRes(arg_27_2.res))
	table.insert(arg_27_1, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light.prefab")
end

function var_0_0._disposeScene(arg_28_0)
	arg_28_0._oldScenePos = arg_28_0._scenePos
	arg_28_0._tempMapCfg = arg_28_0._mapCfg

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnDisposeScene)

	if arg_28_0._mapAudioGo then
		arg_28_0._mapAudioGo = nil

		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
	end

	if arg_28_0._sceneGo then
		gohelper.destroy(arg_28_0._sceneGo)

		arg_28_0._sceneGo = nil
	end

	arg_28_0._sceneTrans = nil
	arg_28_0._elementRoot = nil

	if arg_28_0._mapLoader then
		arg_28_0._mapLoader:dispose()

		arg_28_0._mapLoader = nil
	end

	arg_28_0._mapAudioGo = nil
end

function var_0_0._rebuildScene(arg_29_0)
	arg_29_0:loadMap(arg_29_0._tempMapCfg)

	arg_29_0._tempMapCfg = nil
end

function var_0_0._addMapLight(arg_30_0)
	local var_30_0 = arg_30_0._mapLightUrl
	local var_30_1 = arg_30_0._mapLoader:getAssetItem(var_30_0):GetResource(var_30_0)

	gohelper.clone(var_30_1, arg_30_0._sceneGo)
end

function var_0_0._initElements(arg_31_0)
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnInitElements)
end

function var_0_0._initScene(arg_32_0)
	arg_32_0._mapSize = gohelper.findChild(arg_32_0._sceneGo, "root/size"):GetComponentInChildren(typeof(UnityEngine.BoxCollider)).size

	local var_32_0
	local var_32_1 = GameUtil.getAdapterScale()

	if var_32_1 ~= 1 then
		var_32_0 = ViewMgr.instance:getUILayer(UILayerName.Hud)
	else
		var_32_0 = ViewMgr.instance:getUIRoot()
	end

	local var_32_2 = var_32_0.transform:GetWorldCorners()
	local var_32_3 = CameraMgr.instance:getUICamera()
	local var_32_4 = var_32_3 and var_32_3.orthographicSize or 5
	local var_32_5 = VersionActivity1_5DungeonEnum.DungeonMapCameraSize / var_32_4
	local var_32_6 = var_32_2[1] * var_32_1 * var_32_5
	local var_32_7 = var_32_2[3] * var_32_1 * var_32_5

	arg_32_0._viewWidth = math.abs(var_32_7.x - var_32_6.x)
	arg_32_0._viewHeight = math.abs(var_32_7.y - var_32_6.y)
	arg_32_0._mapMinX = var_32_6.x - (arg_32_0._mapSize.x - arg_32_0._viewWidth)
	arg_32_0._mapMaxX = var_32_6.x
	arg_32_0._mapMinY = var_32_6.y
	arg_32_0._mapMaxY = var_32_6.y + (arg_32_0._mapSize.y - arg_32_0._viewHeight)
end

function var_0_0._setMapPos(arg_33_0)
	if arg_33_0.tempInitPosX then
		arg_33_0._tempVector:Set(arg_33_0.tempInitPosX, arg_33_0.tempInitPosY, 0)

		arg_33_0.tempInitPosX = nil
		arg_33_0.tempInitPosY = nil
	else
		local var_33_0 = arg_33_0._mapCfg.initPos
		local var_33_1 = string.splitToNumber(var_33_0, "#")

		arg_33_0._tempVector:Set(var_33_1[1], var_33_1[2], 0)
	end

	if arg_33_0.needTween then
		arg_33_0:tweenSetScenePos(arg_33_0._tempVector, arg_33_0._oldScenePos)
	else
		arg_33_0:directSetScenePos(arg_33_0._tempVector)
	end
end

function var_0_0.disposeOldMap(arg_34_0)
	if arg_34_0._sceneTrans then
		arg_34_0._oldScenePos = arg_34_0._scenePos
	else
		arg_34_0._oldScenePos = nil
	end

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnDisposeOldMap, arg_34_0.viewName)

	if arg_34_0._oldSceneGo then
		gohelper.destroy(arg_34_0._oldSceneGo)

		arg_34_0._oldSceneGo = nil
	end

	if arg_34_0._oldMapLoader then
		arg_34_0._oldMapLoader:dispose()

		arg_34_0._oldMapLoader = nil
	end
end

function var_0_0.onUpdateParam(arg_35_0)
	arg_35_0:refreshMap()
end

function var_0_0.onModeChange(arg_36_0)
	arg_36_0:refreshMap()
end

function var_0_0.onActivityDungeonMoChange(arg_37_0)
	arg_37_0:refreshMap(true)
end

function var_0_0._onScreenResize(arg_38_0)
	if arg_38_0._sceneGo then
		local var_38_0 = CameraMgr.instance:getMainCamera()
		local var_38_1 = GameUtil.getAdapterScale()

		var_38_0.orthographicSize = VersionActivity1_5DungeonEnum.DungeonMapCameraSize * var_38_1

		arg_38_0:_initScene()
	end
end

function var_0_0.onClickElement(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_1:getConfig()

	arg_39_0:focusElementByCo(var_39_0)
end

function var_0_0.onFocusElement(arg_40_0, arg_40_1)
	if not DungeonMapModel.instance:getElementById(arg_40_1) then
		logError("element not exist or not unlock, element id : " .. arg_40_1)

		return
	end

	local var_40_0 = arg_40_0.mapSceneElementsView:getElementComp(arg_40_1)

	if var_40_0 then
		local var_40_1 = var_40_0:getConfig()

		arg_40_0:focusElementByCo(var_40_1)

		return
	end

	local var_40_2 = lua_chapter_map_element.configDict[arg_40_1]
	local var_40_3 = lua_activity11502_episode_element.configDict[arg_40_1]
	local var_40_4 = var_40_2.mapId

	if not string.nilorempty(var_40_3.mapIds) then
		var_40_4 = string.splitToNumber(var_40_3.mapIds, "#")[1]
	end

	arg_40_0._mapCfg = lua_chapter_map.configDict[var_40_4]

	local var_40_5 = string.splitToNumber(var_40_2.pos, "#")

	arg_40_0.tempInitPosX = -var_40_5[1] or 0
	arg_40_0.tempInitPosY = -var_40_5[2] or 0

	local var_40_6 = DungeonConfig.instance:getEpisodeIdByMapCo(arg_40_0._mapCfg)

	if VersionActivityDungeonBaseEnum.DungeonMode.Story ~= arg_40_0.activityDungeonMo.mode then
		arg_40_0.activityDungeonMo:changeMode(VersionActivityDungeonBaseEnum.DungeonMode.Story)
	end

	arg_40_0.activityDungeonMo:changeEpisode(var_40_6)
end

function var_0_0.focusElementByCo(arg_41_0, arg_41_1)
	local var_41_0 = string.splitToNumber(arg_41_1.pos, "#")
	local var_41_1 = -var_41_0[1] or 0
	local var_41_2 = -var_41_0[2] or 0

	arg_41_0._tempVector:Set(var_41_1, var_41_2, 0)
	arg_41_0:tweenSetScenePos(arg_41_0._tempVector)
end

function var_0_0.setVisible(arg_42_0, arg_42_1)
	gohelper.setActive(arg_42_0._sceneRoot, arg_42_1)

	if arg_42_1 then
		arg_42_0:_initCamera()
	end
end

function var_0_0.killTween(arg_43_0)
	if arg_43_0.tweenId then
		ZProj.TweenHelper.KillById(arg_43_0.tweenId)
	end
end

function var_0_0.onClose(arg_44_0)
	arg_44_0:killTween()
end

function var_0_0.onDestroyView(arg_45_0)
	gohelper.destroy(arg_45_0._sceneRoot)
	arg_45_0:disposeOldMap()
	arg_45_0:_disposeScene()

	if arg_45_0._mapLoader then
		arg_45_0._mapLoader:dispose()
	end

	arg_45_0._drag:RemoveDragBeginListener()
	arg_45_0._drag:RemoveDragListener()
	arg_45_0._drag:RemoveDragEndListener()
end

return var_0_0
