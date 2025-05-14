module("modules.logic.versionactivity.view.VersionActivityDungeonMapScene", package.seeall)

local var_0_0 = class("VersionActivityDungeonMapScene", BaseView)

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

	arg_4_0:_initCamera()
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

	var_17_0.orthographicSize = VersionActivityEnum.DungeonMapCameraSize * var_17_1
end

function var_0_0._resetCamera(arg_18_0)
	local var_18_0 = CameraMgr.instance:getMainCamera()

	var_18_0.orthographicSize = 5
	var_18_0.orthographic = false
end

function var_0_0._initMapRootNode(arg_19_0)
	local var_19_0 = CameraMgr.instance:getMainCameraTrs().parent
	local var_19_1 = CameraMgr.instance:getSceneRoot()

	arg_19_0._sceneRoot = UnityEngine.GameObject.New("VersionActivityDungeonMapScene")

	local var_19_2, var_19_3, var_19_4 = transformhelper.getLocalPos(var_19_0)

	transformhelper.setLocalPos(arg_19_0._sceneRoot.transform, 0, var_19_3, 0)
	gohelper.addChild(var_19_1, arg_19_0._sceneRoot)
end

function var_0_0.getSceneGo(arg_20_0)
	return arg_20_0._sceneGo
end

function var_0_0.refreshMap(arg_21_0)
	arg_21_0._mapCfg = VersionActivityDungeonController.instance:getEpisodeMapConfig(arg_21_0.activityDungeonMo.episodeId)

	if arg_21_0._mapCfg.id == arg_21_0._lastLoadMapId then
		arg_21_0:refreshHardMapEffectAndAudio()

		arg_21_0.dotTween = nil

		return
	end

	arg_21_0._lastLoadMapId = arg_21_0._mapCfg.id

	arg_21_0:loadMap()
end

function var_0_0.loadMap(arg_22_0)
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnChangeMap)

	if arg_22_0.loadedDone then
		arg_22_0._oldMapLoader = arg_22_0._mapLoader
		arg_22_0._oldSceneGo = arg_22_0._sceneGo
		arg_22_0._mapLoader = nil
	end

	if arg_22_0._mapLoader then
		arg_22_0._mapLoader:dispose()

		arg_22_0._mapLoader = nil
	end

	arg_22_0._tempMapCfg = nil
	arg_22_0.loadedDone = false
	arg_22_0._mapLoader = MultiAbLoader.New()

	local var_22_0 = {}

	arg_22_0:buildLoadRes(var_22_0, arg_22_0._mapCfg)

	arg_22_0._canvasUrl = var_22_0[1]
	arg_22_0._interactiveItemUrl = var_22_0[2]
	arg_22_0._sceneUrl = var_22_0[3]
	arg_22_0._mapAudioUrl = var_22_0[4]
	arg_22_0._mapLightUrl = var_22_0[5]
	arg_22_0._fogUrl = var_22_0[6]

	arg_22_0._mapLoader:addPath(arg_22_0._sceneUrl)
	arg_22_0._mapLoader:addPath(arg_22_0._canvasUrl)
	arg_22_0._mapLoader:addPath(arg_22_0._interactiveItemUrl)
	arg_22_0._mapLoader:addPath(arg_22_0._mapAudioUrl)
	arg_22_0._mapLoader:addPath(arg_22_0._mapLightUrl)
	arg_22_0._mapLoader:addPath(arg_22_0._fogUrl)
	arg_22_0._mapLoader:startLoad(arg_22_0._loadSceneFinish, arg_22_0)
end

function var_0_0._loadSceneFinish(arg_23_0)
	arg_23_0.loadedDone = true

	arg_23_0:disposeOldMap()

	local var_23_0 = arg_23_0._sceneUrl
	local var_23_1 = arg_23_0._mapLoader:getAssetItem(var_23_0):GetResource(var_23_0)

	arg_23_0._sceneGo = gohelper.clone(var_23_1, arg_23_0._sceneRoot, arg_23_0._mapCfg.id)
	arg_23_0._sceneTrans = arg_23_0._sceneGo.transform

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnLoadSceneFinish, {
		arg_23_0._mapCfg,
		arg_23_0._sceneGo,
		arg_23_0
	})
	DungeonController.instance:dispatchEvent(DungeonEvent.OnShowMap)

	arg_23_0.goFogEffect = gohelper.clone(arg_23_0._mapLoader:getAssetItem(arg_23_0._fogUrl):GetResource(arg_23_0._fogUrl), arg_23_0._sceneGo)
	arg_23_0.goRainEffect = gohelper.findChild(arg_23_0._sceneGo, "SceneEffect")

	local var_23_2 = gohelper.findChild(arg_23_0._sceneGo, "SceneEffect/big")

	gohelper.setActive(var_23_2, true)
	arg_23_0:refreshHardMapEffectAndAudio()
	arg_23_0:_initScene()
	arg_23_0:_initCanvas()
	arg_23_0:_addAllAudio()
	TaskDispatcher.runDelay(arg_23_0._addMapLight, arg_23_0, 0.3)
end

function var_0_0._addAllAudio(arg_24_0)
	arg_24_0:_addMapAudio()
end

function var_0_0.buildLoadRes(arg_25_0, arg_25_1, arg_25_2)
	table.insert(arg_25_1, "ui/viewres/dungeon/chaptermap/chaptermapscenecanvas.prefab")
	table.insert(arg_25_1, "ui/viewres/dungeon/chaptermap/dungeonmapinteractiveitem.prefab")
	table.insert(arg_25_1, ResUrl.getDungeonMapRes(arg_25_2.res))
	table.insert(arg_25_1, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_audio_1_1.prefab")
	table.insert(arg_25_1, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light.prefab")
	table.insert(arg_25_1, "scenes/m_s14_hddt_hd01/prefab/s08_hddt_hd_01_fog.prefab")
end

function var_0_0._disposeScene(arg_26_0)
	arg_26_0._oldScenePos = arg_26_0._targetPos
	arg_26_0._tempMapCfg = arg_26_0._mapCfg

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnDisposeScene)

	if arg_26_0._mapAudioGo then
		arg_26_0._mapAudioGo = nil

		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
	end

	if arg_26_0._sceneGo then
		gohelper.destroy(arg_26_0._sceneGo)

		arg_26_0._sceneGo = nil
	end

	arg_26_0._sceneTrans = nil
	arg_26_0._elementRoot = nil

	if arg_26_0._mapLoader then
		arg_26_0._mapLoader:dispose()

		arg_26_0._mapLoader = nil
	end

	TaskDispatcher.cancelTask(arg_26_0._addMapLight, arg_26_0)
	TaskDispatcher.cancelTask(arg_26_0._addAllAudio, arg_26_0)

	arg_26_0._mapAudioGo = nil
end

function var_0_0._rebuildScene(arg_27_0)
	arg_27_0:loadMap(arg_27_0._tempMapCfg)

	arg_27_0._tempMapCfg = nil
end

function var_0_0._addMapLight(arg_28_0)
	local var_28_0 = arg_28_0._mapLightUrl
	local var_28_1 = arg_28_0._mapLoader:getAssetItem(var_28_0):GetResource(var_28_0)

	gohelper.clone(var_28_1, arg_28_0._sceneGo)
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnInitElements)
end

function var_0_0._addMapAudio(arg_29_0)
	local var_29_0 = arg_29_0._mapAudioUrl
	local var_29_1 = arg_29_0._mapLoader:getAssetItem(var_29_0):GetResource(var_29_0)

	arg_29_0._mapAudioGo = gohelper.clone(var_29_1, arg_29_0._sceneGo, "audio")

	gohelper.addChild(arg_29_0._sceneGo, arg_29_0._mapAudioGo)
	gohelper.setActive(arg_29_0._mapAudioGo, true)
	transformhelper.setLocalPos(arg_29_0._mapAudioGo.transform, 0, 0, 0)

	local var_29_2 = arg_29_0._mapCfg.areaAudio

	if string.nilorempty(var_29_2) then
		return
	end

	local var_29_3 = gohelper.findChild(arg_29_0._mapAudioGo, "audio")

	if var_29_2 == "all" then
		local var_29_4 = var_29_3.transform
		local var_29_5 = var_29_4.childCount

		for iter_29_0 = 1, var_29_5 do
			local var_29_6 = var_29_4:GetChild(iter_29_0 - 1)

			gohelper.setActive(var_29_6.gameObject, true)
		end

		return
	end

	local var_29_7 = string.split(var_29_2, "#")

	for iter_29_1, iter_29_2 in ipairs(var_29_7) do
		local var_29_8 = gohelper.findChild(var_29_3, iter_29_2)

		gohelper.setActive(var_29_8, true)
	end
end

function var_0_0._initCanvas(arg_30_0)
	local var_30_0 = arg_30_0._mapLoader:getAssetItem(arg_30_0._canvasUrl):GetResource(arg_30_0._canvasUrl)

	arg_30_0._sceneCanvasGo = gohelper.clone(var_30_0, arg_30_0._sceneGo)
	arg_30_0._sceneCanvas = arg_30_0._sceneCanvasGo:GetComponent("Canvas")
	arg_30_0._sceneCanvas.worldCamera = CameraMgr.instance:getMainCamera()
	arg_30_0._itemPrefab = arg_30_0._mapLoader:getAssetItem(arg_30_0._interactiveItemUrl):GetResource(arg_30_0._interactiveItemUrl)
end

function var_0_0.getInteractiveItem(arg_31_0)
	arg_31_0._uiGo = gohelper.clone(arg_31_0._itemPrefab, arg_31_0._sceneCanvasGo)
	arg_31_0._interactiveItem = MonoHelper.addLuaComOnceToGo(arg_31_0._uiGo, DungeonMapInteractiveItem)

	arg_31_0._interactiveItem:setBtnClosePosZ(-5)
	gohelper.setActive(arg_31_0._uiGo, false)

	return arg_31_0._interactiveItem
end

function var_0_0.showInteractiveItem(arg_32_0)
	return not gohelper.isNil(arg_32_0._uiGo)
end

function var_0_0._initScene(arg_33_0)
	arg_33_0._mapSize = gohelper.findChild(arg_33_0._sceneGo, "root/size"):GetComponentInChildren(typeof(UnityEngine.BoxCollider)).size

	local var_33_0
	local var_33_1 = GameUtil.getAdapterScale()

	if var_33_1 ~= 1 then
		var_33_0 = ViewMgr.instance:getUILayer(UILayerName.Hud)
	else
		var_33_0 = ViewMgr.instance:getUIRoot()
	end

	local var_33_2 = var_33_0.transform:GetWorldCorners()
	local var_33_3 = CameraMgr.instance:getUICamera()
	local var_33_4 = var_33_3 and var_33_3.orthographicSize or 5
	local var_33_5 = VersionActivityEnum.DungeonMapCameraSize / var_33_4
	local var_33_6 = var_33_2[1] * var_33_1 * var_33_5
	local var_33_7 = var_33_2[3] * var_33_1 * var_33_5

	arg_33_0._viewWidth = math.abs(var_33_7.x - var_33_6.x)
	arg_33_0._viewHeight = math.abs(var_33_7.y - var_33_6.y)
	arg_33_0._mapMinX = var_33_6.x - (arg_33_0._mapSize.x - arg_33_0._viewWidth)
	arg_33_0._mapMaxX = var_33_6.x
	arg_33_0._mapMinY = var_33_6.y
	arg_33_0._mapMaxY = var_33_6.y + (arg_33_0._mapSize.y - arg_33_0._viewHeight)

	if arg_33_0._oldScenePos then
		arg_33_0._sceneTrans.localPosition = arg_33_0._oldScenePos
	end

	if arg_33_0.dotTween then
		arg_33_0:_setInitPos(false)
	else
		arg_33_0:_setInitPos(arg_33_0._oldScenePos)
	end

	arg_33_0.dotTween = nil
	arg_33_0._oldScenePos = nil
end

function var_0_0._setInitPos(arg_34_0, arg_34_1)
	if not arg_34_0._mapCfg then
		return
	end

	local var_34_0 = arg_34_0._mapCfg.initPos
	local var_34_1 = string.splitToNumber(var_34_0, "#")

	arg_34_0:setScenePosSafety(Vector3(var_34_1[1], var_34_1[2], 0), arg_34_1)
end

function var_0_0.disposeOldMap(arg_35_0)
	if arg_35_0._sceneTrans then
		arg_35_0._oldScenePos = arg_35_0._sceneTrans.localPosition
	else
		arg_35_0._oldScenePos = nil
	end

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnDisposeOldMap, arg_35_0.viewName)

	if arg_35_0._oldSceneGo then
		gohelper.destroy(arg_35_0._oldSceneGo)

		arg_35_0._oldSceneGo = nil
	end

	if arg_35_0._mapAudioGo then
		arg_35_0._mapAudioGo = nil

		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
	end

	if arg_35_0._oldMapLoader then
		arg_35_0._oldMapLoader:dispose()

		arg_35_0._oldMapLoader = nil
	end

	TaskDispatcher.cancelTask(arg_35_0._addAllAudio, arg_35_0)
	TaskDispatcher.cancelTask(arg_35_0._addMapLight, arg_35_0)
end

function var_0_0._showMapTip(arg_36_0)
	gohelper.setActive(arg_36_0._gotoptipsbg, false)
end

function var_0_0._hideMapTip(arg_37_0)
	gohelper.setActive(arg_37_0._gotoptipsbg, false)
end

function var_0_0.onUpdateParam(arg_38_0)
	arg_38_0:refreshMap()
end

function var_0_0.onOpen(arg_39_0)
	arg_39_0.activityDungeonMo = arg_39_0.viewContainer.versionActivityDungeonBaseMo

	arg_39_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnFocusElement, arg_39_0._focusElementById, arg_39_0)
	arg_39_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_39_0._onScreenResize, arg_39_0)
	arg_39_0:addEventCb(DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, arg_39_0._setEpisodeListVisible, arg_39_0)
	arg_39_0:addEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, arg_39_0.onModeChange, arg_39_0)
	arg_39_0:refreshMap()
end

function var_0_0.onModeChange(arg_40_0)
	arg_40_0.dotTween = true

	arg_40_0:refreshMap()
end

function var_0_0._setEpisodeListVisible(arg_41_0, arg_41_1)
	if arg_41_1 and arg_41_0._interactiveItem then
		arg_41_0._interactiveItem:_onOutAnimationFinished()
	end

	gohelper.setActive(arg_41_0._gofullscreen, arg_41_1)
end

function var_0_0._onScreenResize(arg_42_0)
	if arg_42_0._sceneGo then
		local var_42_0 = CameraMgr.instance:getMainCamera()
		local var_42_1 = GameUtil.getAdapterScale()

		var_42_0.orthographicSize = VersionActivityEnum.DungeonMapCameraSize * var_42_1

		arg_42_0:_initScene()
	end
end

function var_0_0._focusElementById(arg_43_0, arg_43_1)
	local var_43_0 = lua_chapter_map_element.configDict[arg_43_1]
	local var_43_1 = string.splitToNumber(var_43_0.pos, "#")
	local var_43_2 = var_43_1[1] or 0
	local var_43_3 = var_43_1[2] or 0
	local var_43_4 = string.splitToNumber(var_43_0.offsetPos, "#")
	local var_43_5 = var_43_2 + (var_43_4[1] or 0)
	local var_43_6 = var_43_3 + (var_43_4[2] or 0)
	local var_43_7 = arg_43_0._mapMaxX - var_43_5 + arg_43_0._viewWidth / 2
	local var_43_8 = arg_43_0._mapMinY - var_43_6 - arg_43_0._viewHeight / 2 + 2

	arg_43_0:setScenePosSafety(Vector3(var_43_7, var_43_8, 0), not DungeonMapModel.instance.directFocusElement)
end

function var_0_0.refreshHardMapEffectAndAudio(arg_44_0)
	local var_44_0 = arg_44_0.activityDungeonMo:isHardMode()

	if var_44_0 then
		AudioEffectMgr.instance:playAudio(AudioEnum.Story.Play_Chapter_Start)
	else
		AudioEffectMgr.instance:stopAudio(AudioEnum.Story.Play_Chapter_Start)
	end

	if arg_44_0.goRainEffect then
		gohelper.setActive(arg_44_0.goRainEffect, var_44_0)
	end

	if arg_44_0.goFogEffect then
		gohelper.setActive(arg_44_0.goFogEffect, var_44_0)
	end
end

function var_0_0.setVisible(arg_45_0, arg_45_1)
	gohelper.setActive(arg_45_0._sceneRoot, arg_45_1)

	if arg_45_1 then
		arg_45_0:_initCamera()
	end
end

function var_0_0.onClose(arg_46_0)
	arg_46_0:_resetCamera()
end

function var_0_0.onDestroyView(arg_47_0)
	gohelper.destroy(arg_47_0._sceneRoot)
	arg_47_0:disposeOldMap()

	if arg_47_0._mapLoader then
		arg_47_0._mapLoader:dispose()
	end

	arg_47_0._drag:RemoveDragBeginListener()
	arg_47_0._drag:RemoveDragListener()
	arg_47_0._drag:RemoveDragEndListener()
	TaskDispatcher.cancelTask(arg_47_0._hideMapTip, arg_47_0)
end

return var_0_0
