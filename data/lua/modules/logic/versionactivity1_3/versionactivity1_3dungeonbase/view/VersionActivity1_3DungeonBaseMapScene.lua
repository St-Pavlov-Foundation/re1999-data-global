module("modules.logic.versionactivity1_3.versionactivity1_3dungeonbase.view.VersionActivity1_3DungeonBaseMapScene", package.seeall)

local var_0_0 = class("VersionActivity1_3DungeonBaseMapScene", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gofullscreen = gohelper.findChild(arg_1_0.viewGO, "#go_fullscreen")
	arg_1_0._goarrow = gohelper.findChild(arg_1_0.viewGO, "#go_arrow")
	arg_1_0._gotoptipsbg = gohelper.findChild(arg_1_0.viewGO, "#go_main/#go_toptipsbg")

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
	if ViewMgr.instance:isOpen(ViewName.MainThumbnailView) then
		MainThumbnailHeroView.setCameraIdle()
	end

	arg_4_0._tempVector = Vector3()
	arg_4_0._dragDeltaPos = Vector3()

	arg_4_0:_initMapRootNode()
	arg_4_0:_initDrag()
end

function var_0_0._initDrag(arg_5_0)
	arg_5_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_5_0._gofullscreen)

	arg_5_0._drag:AddDragBeginListener(arg_5_0._onDragBegin, arg_5_0)
	arg_5_0._drag:AddDragEndListener(arg_5_0._onDragEnd, arg_5_0)
	arg_5_0._drag:AddDragListener(arg_5_0._onDrag, arg_5_0)
	arg_5_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_5_0._onOpenView, arg_5_0)
	arg_5_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_5_0._onCloseView, arg_5_0)
end

function var_0_0._onOpenView(arg_6_0, arg_6_1)
	if arg_6_1 == ViewName.StoryView then
		arg_6_0:_disposeScene()
		GameGCMgr.instance:dispatchEvent(GameGCEvent.DelayFullGC, 0, arg_6_0)
	end
end

function var_0_0._onCloseView(arg_7_0, arg_7_1)
	if arg_7_1 == ViewName.StoryView then
		arg_7_0:_rebuildScene()
	end
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

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnSetClickDown)
end

function var_0_0._onDrag(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_0._dragBeginPos then
		return
	end

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnSetClickDown)

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
	arg_11_0:_updateElementArrow()
end

function var_0_0._updateElementArrow(arg_12_0)
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnUpdateElementArrow)
end

function var_0_0.setScenePosSafety(arg_13_0, arg_13_1, arg_13_2)
	if not arg_13_0._sceneTrans then
		return
	end

	if arg_13_1.x < arg_13_0._mapMinX then
		arg_13_1.x = arg_13_0._mapMinX
	elseif arg_13_1.x > arg_13_0._mapMaxX then
		arg_13_1.x = arg_13_0._mapMaxX
	end

	if arg_13_1.y < arg_13_0._mapMinY then
		arg_13_1.y = arg_13_0._mapMinY
	elseif arg_13_1.y > arg_13_0._mapMaxY then
		arg_13_1.y = arg_13_0._mapMaxY
	end

	arg_13_0._targetPos = arg_13_1

	if arg_13_2 then
		local var_13_0 = arg_13_0._tweenTime or 0.26

		ZProj.TweenHelper.DOLocalMove(arg_13_0._sceneTrans, arg_13_1.x, arg_13_1.y, 0, var_13_0, arg_13_0._localMoveDone, arg_13_0, nil, EaseType.InOutQuart)
	else
		arg_13_0._sceneTrans.localPosition = arg_13_1
	end

	arg_13_0:_updateElementArrow()
end

function var_0_0._localMoveDone(arg_14_0)
	arg_14_0:_updateElementArrow()
end

function var_0_0.vectorAdd(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0._tempVector

	var_15_0.x = arg_15_1.x + arg_15_2.x
	var_15_0.y = arg_15_1.y + arg_15_2.y

	return var_15_0
end

function var_0_0.getDragWorldPos(arg_16_0, arg_16_1)
	local var_16_0 = CameraMgr.instance:getMainCamera()
	local var_16_1 = arg_16_0._gofullscreen.transform.position

	return (SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(arg_16_1.position, var_16_0, var_16_1))
end

function var_0_0._initCamera(arg_17_0)
	local var_17_0 = CameraMgr.instance:getMainCamera()

	var_17_0.orthographic = true

	local var_17_1 = GameUtil.getAdapterScale()

	var_17_0.orthographicSize = VersionActivity1_3DungeonEnum.DungeonMapCameraSize * var_17_1
end

function var_0_0._resetCamera(arg_18_0)
	local var_18_0 = CameraMgr.instance:getMainCamera()

	var_18_0.orthographicSize = 5
	var_18_0.orthographic = false
end

function var_0_0._initMapRootNode(arg_19_0)
	local var_19_0 = CameraMgr.instance:getMainCameraTrs().parent
	local var_19_1 = CameraMgr.instance:getSceneRoot()

	arg_19_0._sceneRoot = UnityEngine.GameObject.New("VersionActivity1_3DungeonBaseMapScene")

	local var_19_2, var_19_3, var_19_4 = transformhelper.getLocalPos(var_19_0)

	transformhelper.setLocalPos(arg_19_0._sceneRoot.transform, 0, var_19_3, 0)
	gohelper.addChild(var_19_1, arg_19_0._sceneRoot)
end

function var_0_0.getSceneGo(arg_20_0)
	return arg_20_0._sceneGo
end

function var_0_0._isSameMap(arg_21_0, arg_21_1, arg_21_2)
	return arg_21_1 == arg_21_2
end

function var_0_0.refreshMap(arg_22_0)
	arg_22_0._mapCfg = VersionActivity1_3DungeonController.instance:getEpisodeMapConfig(arg_22_0.activityDungeonMo.episodeId)

	if arg_22_0:_isSameMap(arg_22_0._mapCfg.id, arg_22_0._lastLoadMapId) then
		arg_22_0:refreshHardMapEffectAndAudio()

		arg_22_0.dotTween = nil

		VersionActivity1_3DungeonController.instance:dispatchEvent(VersionActivity1_3DungeonEvent.LoadSameScene)

		return
	end

	arg_22_0._lastLoadMapId = arg_22_0._mapCfg.id

	arg_22_0:loadMap()

	arg_22_0._lastEpisodeId = arg_22_0.activityDungeonMo.episodeId
end

function var_0_0.loadMap(arg_23_0)
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnChangeMap)

	if arg_23_0.loadedDone then
		arg_23_0._oldMapLoader = arg_23_0._mapLoader
		arg_23_0._oldSceneGo = arg_23_0._sceneGo
		arg_23_0._mapLoader = nil
	end

	if arg_23_0._mapLoader then
		arg_23_0._mapLoader:dispose()

		arg_23_0._mapLoader = nil
	end

	arg_23_0._tempMapCfg = nil
	arg_23_0.loadedDone = false
	arg_23_0._mapLoader = MultiAbLoader.New()

	local var_23_0 = {}

	arg_23_0:buildLoadRes(var_23_0, arg_23_0._mapCfg)

	arg_23_0._canvasUrl = var_23_0[1]
	arg_23_0._interactiveItemUrl = var_23_0[2]
	arg_23_0._sceneUrl = var_23_0[3]
	arg_23_0._mapLightUrl = var_23_0[5]

	if arg_23_0.activityDungeonMo:isHardMode() then
		arg_23_0._fogUrl = var_23_0[6]

		arg_23_0._mapLoader:addPath(arg_23_0._fogUrl)

		arg_23_0._bigEffectUrl = var_23_0[7]

		if arg_23_0._bigEffectUrl then
			arg_23_0._mapLoader:addPath(arg_23_0._bigEffectUrl)
		end
	end

	arg_23_0._mapLoader:addPath(arg_23_0._sceneUrl)
	arg_23_0._mapLoader:addPath(arg_23_0._canvasUrl)
	arg_23_0._mapLoader:addPath(arg_23_0._interactiveItemUrl)

	if arg_23_0._mapAudioUrl then
		arg_23_0._mapLoader:addPath(arg_23_0._mapAudioUrl)
	end

	arg_23_0._mapLoader:addPath(arg_23_0._mapLightUrl)
	arg_23_0._mapLoader:startLoad(arg_23_0._loadSceneFinish, arg_23_0)
end

function var_0_0._loadSceneFinish(arg_24_0)
	arg_24_0.loadedDone = true

	arg_24_0:disposeOldMap()

	local var_24_0 = arg_24_0._sceneUrl
	local var_24_1 = arg_24_0._mapLoader:getAssetItem(var_24_0):GetResource(var_24_0)

	arg_24_0._sceneGo = gohelper.clone(var_24_1, arg_24_0._sceneRoot, arg_24_0._mapCfg.id)
	arg_24_0._sceneTrans = arg_24_0._sceneGo.transform

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnLoadSceneFinish, {
		arg_24_0._mapCfg,
		arg_24_0._sceneGo,
		arg_24_0
	})
	DungeonController.instance:dispatchEvent(DungeonEvent.OnShowMap)

	arg_24_0.goRainEffect = gohelper.findChild(arg_24_0._sceneGo, "SceneEffect")

	if arg_24_0.activityDungeonMo:isHardMode() then
		if arg_24_0._fogUrl then
			arg_24_0.goFogEffect = gohelper.clone(arg_24_0._mapLoader:getAssetItem(arg_24_0._fogUrl):GetResource(arg_24_0._fogUrl), arg_24_0._sceneGo)
		end

		if arg_24_0._bigEffectUrl then
			arg_24_0.goBigEffect = gohelper.clone(arg_24_0._mapLoader:getAssetItem(arg_24_0._bigEffectUrl):GetResource(arg_24_0._bigEffectUrl), arg_24_0.goRainEffect)
		end
	end

	arg_24_0:refreshHardMapEffectAndAudio()
	arg_24_0:_initScene()
	arg_24_0:_initCanvas()
	arg_24_0:_addAllAudio()

	local var_24_2 = 0.3

	if VersionActivity1_3DungeonController.instance.directFocusDaily then
		var_24_2 = 0
	end

	TaskDispatcher.runDelay(arg_24_0._addMapLight, arg_24_0, var_24_2)
end

function var_0_0._addAllAudio(arg_25_0)
	arg_25_0:_addMapAudio()
end

function var_0_0.buildLoadRes(arg_26_0, arg_26_1, arg_26_2)
	table.insert(arg_26_1, "ui/viewres/dungeon/chaptermap/chaptermapscenecanvas.prefab")
	table.insert(arg_26_1, "ui/viewres/versionactivity_1_3/map/v1a3_dungeonmapinteractiveitem.prefab")
	table.insert(arg_26_1, ResUrl.getDungeonMapRes(arg_26_2.res))
	table.insert(arg_26_1, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_audio_1_1.prefab")
	table.insert(arg_26_1, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light.prefab")

	local var_26_0 = arg_26_0.activityDungeonMo.episodeId

	if VersionActivity1_3DungeonController.instance:isDayTime(var_26_0) then
		table.insert(arg_26_1, "scenes/v1a3_m_s14_hddt_hd03/prefab/s08_hddt_hd_03_fog_a.prefab")
	else
		table.insert(arg_26_1, "scenes/v1a3_m_s14_hddt_hd03/prefab/s08_hddt_hd_03_fog_b.prefab")
		table.insert(arg_26_1, "scenes/v1a3_m_s14_hddt_hd03/prefab/big.prefab")
	end
end

function var_0_0._disposeScene(arg_27_0)
	arg_27_0._oldScenePos = arg_27_0._targetPos
	arg_27_0._tempMapCfg = arg_27_0._mapCfg

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnDisposeScene)

	if arg_27_0._mapAudioGo then
		arg_27_0._mapAudioGo = nil

		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
	end

	if arg_27_0._sceneGo then
		gohelper.destroy(arg_27_0._sceneGo)

		arg_27_0._sceneGo = nil
	end

	arg_27_0._sceneTrans = nil
	arg_27_0._elementRoot = nil

	if arg_27_0._mapLoader then
		arg_27_0._mapLoader:dispose()

		arg_27_0._mapLoader = nil
	end

	TaskDispatcher.cancelTask(arg_27_0._addMapLight, arg_27_0)
	TaskDispatcher.cancelTask(arg_27_0._addAllAudio, arg_27_0)

	arg_27_0._mapAudioGo = nil
end

function var_0_0._rebuildScene(arg_28_0)
	arg_28_0:loadMap(arg_28_0._tempMapCfg)

	arg_28_0._tempMapCfg = nil
end

function var_0_0._addMapLight(arg_29_0)
	local var_29_0 = arg_29_0._mapLightUrl
	local var_29_1 = arg_29_0._mapLoader:getAssetItem(var_29_0):GetResource(var_29_0)

	gohelper.clone(var_29_1, arg_29_0._sceneGo)
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnInitElements)
end

function var_0_0._addMapAudio(arg_30_0)
	if not arg_30_0._mapAudioUrl then
		return
	end

	local var_30_0 = arg_30_0._mapAudioUrl
	local var_30_1 = arg_30_0._mapLoader:getAssetItem(var_30_0):GetResource(var_30_0)

	arg_30_0._mapAudioGo = gohelper.clone(var_30_1, arg_30_0._sceneGo, "audio")

	gohelper.addChild(arg_30_0._sceneGo, arg_30_0._mapAudioGo)
	gohelper.setActive(arg_30_0._mapAudioGo, true)
	transformhelper.setLocalPos(arg_30_0._mapAudioGo.transform, 0, 0, 0)

	local var_30_2 = arg_30_0._mapCfg.areaAudio

	if string.nilorempty(var_30_2) then
		return
	end

	local var_30_3 = gohelper.findChild(arg_30_0._mapAudioGo, "audio")

	if var_30_2 == "all" then
		local var_30_4 = var_30_3.transform
		local var_30_5 = var_30_4.childCount

		for iter_30_0 = 1, var_30_5 do
			local var_30_6 = var_30_4:GetChild(iter_30_0 - 1)

			gohelper.setActive(var_30_6.gameObject, true)
		end

		return
	end

	local var_30_7 = string.split(var_30_2, "#")

	for iter_30_1, iter_30_2 in ipairs(var_30_7) do
		local var_30_8 = gohelper.findChild(var_30_3, iter_30_2)

		gohelper.setActive(var_30_8, true)
	end
end

function var_0_0._initCanvas(arg_31_0)
	local var_31_0 = arg_31_0._mapLoader:getAssetItem(arg_31_0._canvasUrl):GetResource(arg_31_0._canvasUrl)

	arg_31_0._sceneCanvasGo = gohelper.clone(var_31_0, arg_31_0._sceneGo)
	arg_31_0._sceneCanvas = arg_31_0._sceneCanvasGo:GetComponent("Canvas")
	arg_31_0._sceneCanvas.worldCamera = CameraMgr.instance:getMainCamera()
	arg_31_0._itemPrefab = arg_31_0._mapLoader:getAssetItem(arg_31_0._interactiveItemUrl):GetResource(arg_31_0._interactiveItemUrl)
end

function var_0_0.getInteractiveItem(arg_32_0)
	arg_32_0._uiGo = gohelper.clone(arg_32_0._itemPrefab, arg_32_0._sceneCanvasGo)
	arg_32_0._interactiveItem = MonoHelper.addLuaComOnceToGo(arg_32_0._uiGo, DungeonMapInteractive1_3ItemComp)

	gohelper.setActive(arg_32_0._uiGo, false)

	return arg_32_0._interactiveItem
end

function var_0_0.showInteractiveItem(arg_33_0)
	return not gohelper.isNil(arg_33_0._uiGo)
end

function var_0_0._initScene(arg_34_0)
	arg_34_0._mapSize = gohelper.findChild(arg_34_0._sceneGo, "root/size"):GetComponentInChildren(typeof(UnityEngine.BoxCollider)).size

	local var_34_0
	local var_34_1 = GameUtil.getAdapterScale()

	if var_34_1 ~= 1 then
		var_34_0 = ViewMgr.instance:getUILayer(UILayerName.Hud)
	else
		var_34_0 = ViewMgr.instance:getUIRoot()
	end

	local var_34_2 = var_34_0.transform:GetWorldCorners()
	local var_34_3 = CameraMgr.instance:getUICamera()
	local var_34_4 = var_34_3 and var_34_3.orthographicSize or 5
	local var_34_5 = VersionActivity1_3DungeonEnum.DungeonMapCameraSize / var_34_4
	local var_34_6 = var_34_2[1] * var_34_1 * var_34_5
	local var_34_7 = var_34_2[3] * var_34_1 * var_34_5

	arg_34_0._viewWidth = math.abs(var_34_7.x - var_34_6.x)
	arg_34_0._viewHeight = math.abs(var_34_7.y - var_34_6.y)
	arg_34_0._mapMinX = var_34_6.x - (arg_34_0._mapSize.x - arg_34_0._viewWidth)
	arg_34_0._mapMaxX = var_34_6.x
	arg_34_0._mapMinY = var_34_6.y
	arg_34_0._mapMaxY = var_34_6.y + (arg_34_0._mapSize.y - arg_34_0._viewHeight)

	if arg_34_0._oldScenePos then
		arg_34_0._sceneTrans.localPosition = arg_34_0._oldScenePos
	end

	if arg_34_0.dotTween then
		arg_34_0:_setInitPos(false)
	else
		arg_34_0:_setInitPos(arg_34_0._oldScenePos)
	end

	arg_34_0.dotTween = nil
	arg_34_0._oldScenePos = nil
end

function var_0_0._setInitPos(arg_35_0, arg_35_1)
	if not arg_35_0._mapCfg then
		return
	end

	if VersionActivity1_3DungeonController.instance.directFocusDaily then
		arg_35_1 = false
	end

	local var_35_0 = arg_35_0._mapCfg.initPos
	local var_35_1 = string.splitToNumber(var_35_0, "#")

	arg_35_0:setScenePosSafety(Vector3(var_35_1[1], var_35_1[2], 0), arg_35_1)
end

function var_0_0.disposeOldMap(arg_36_0)
	if arg_36_0._sceneTrans then
		arg_36_0._oldScenePos = arg_36_0._sceneTrans.localPosition
	else
		arg_36_0._oldScenePos = nil
	end

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnDisposeOldMap, arg_36_0.viewName)

	if arg_36_0._oldSceneGo then
		gohelper.destroy(arg_36_0._oldSceneGo)

		arg_36_0._oldSceneGo = nil
	end

	if arg_36_0._mapAudioGo then
		arg_36_0._mapAudioGo = nil

		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
	end

	if arg_36_0._oldMapLoader then
		arg_36_0._oldMapLoader:dispose()

		arg_36_0._oldMapLoader = nil
	end

	TaskDispatcher.cancelTask(arg_36_0._addAllAudio, arg_36_0)
	TaskDispatcher.cancelTask(arg_36_0._addMapLight, arg_36_0)
end

function var_0_0._showMapTip(arg_37_0)
	gohelper.setActive(arg_37_0._gotoptipsbg, false)
end

function var_0_0._hideMapTip(arg_38_0)
	gohelper.setActive(arg_38_0._gotoptipsbg, false)
end

function var_0_0.onUpdateParam(arg_39_0)
	arg_39_0:refreshMap()
end

function var_0_0.onOpen(arg_40_0)
	arg_40_0.activityDungeonMo = arg_40_0.viewContainer.versionActivityDungeonBaseMo

	arg_40_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnFocusElement, arg_40_0._focusElementById, arg_40_0)
	arg_40_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_40_0._onScreenResize, arg_40_0)
	arg_40_0:addEventCb(DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, arg_40_0._setEpisodeListVisible, arg_40_0)
	arg_40_0:addEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, arg_40_0.onModeChange, arg_40_0)
	arg_40_0:refreshMap()
end

function var_0_0.onModeChange(arg_41_0)
	arg_41_0.dotTween = true

	arg_41_0:refreshMap()
end

function var_0_0._setEpisodeListVisible(arg_42_0, arg_42_1)
	if arg_42_1 and arg_42_0._interactiveItem then
		arg_42_0._interactiveItem:_onOutAnimationFinished()
	end

	gohelper.setActive(arg_42_0._gofullscreen, arg_42_1)
end

function var_0_0._onScreenResize(arg_43_0)
	if arg_43_0._sceneGo then
		local var_43_0 = CameraMgr.instance:getMainCamera()
		local var_43_1 = GameUtil.getAdapterScale()

		var_43_0.orthographicSize = VersionActivity1_3DungeonEnum.DungeonMapCameraSize * var_43_1

		arg_43_0:_initScene()
	end
end

function var_0_0._focusElementById(arg_44_0, arg_44_1)
	local var_44_0 = lua_chapter_map_element.configDict[arg_44_1]
	local var_44_1 = string.splitToNumber(var_44_0.pos, "#")
	local var_44_2 = var_44_1[1] or 0
	local var_44_3 = var_44_1[2] or 0
	local var_44_4 = string.splitToNumber(var_44_0.offsetPos, "#")
	local var_44_5 = var_44_2 + (var_44_4[1] or 0)
	local var_44_6 = var_44_3 + (var_44_4[2] or 0)
	local var_44_7 = arg_44_0._mapMaxX - var_44_5 + arg_44_0._viewWidth / 2
	local var_44_8 = arg_44_0._mapMinY - var_44_6 - arg_44_0._viewHeight / 2 + 2
	local var_44_9 = not DungeonMapModel.instance.directFocusElement

	if VersionActivity1_3DungeonController.instance.directFocusDaily then
		var_44_9 = nil
		VersionActivity1_3DungeonController.instance.directFocusDaily = false
	end

	arg_44_0:setScenePosSafety(Vector3(var_44_7, var_44_8, 0), var_44_9)
end

function var_0_0.refreshHardMapEffectAndAudio(arg_45_0)
	local var_45_0 = arg_45_0.activityDungeonMo:isHardMode()

	if var_45_0 then
		-- block empty
	end

	if arg_45_0.goRainEffect then
		gohelper.setActive(arg_45_0.goRainEffect, var_45_0)
	end

	if arg_45_0.goFogEffect then
		gohelper.setActive(arg_45_0.goFogEffect, var_45_0)
	end

	if arg_45_0.goBigEffect then
		gohelper.setActive(arg_45_0.goBigEffect, var_45_0)
	end
end

function var_0_0.setVisible(arg_46_0, arg_46_1)
	gohelper.setActive(arg_46_0._sceneRoot, arg_46_1)

	if arg_46_1 then
		arg_46_0:_initCamera()
	end
end

function var_0_0.onClose(arg_47_0)
	return
end

function var_0_0.onDestroyView(arg_48_0)
	gohelper.destroy(arg_48_0._sceneRoot)
	arg_48_0:disposeOldMap()

	if arg_48_0._mapLoader then
		arg_48_0._mapLoader:dispose()
	end

	arg_48_0._drag:RemoveDragBeginListener()
	arg_48_0._drag:RemoveDragListener()
	arg_48_0._drag:RemoveDragEndListener()
	TaskDispatcher.cancelTask(arg_48_0._hideMapTip, arg_48_0)
end

return var_0_0
