module("modules.logic.versionactivity1_2.versionactivity1_2dungeonbase.view.VersionActivity1_2DungeonMapBaseScene", package.seeall)

local var_0_0 = class("VersionActivity1_2DungeonMapBaseScene", BaseViewExtended)

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
	arg_4_0:playBgm()
end

function var_0_0.playBgm(arg_5_0)
	return
end

function var_0_0._initDrag(arg_6_0)
	arg_6_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_6_0._gofullscreen)

	arg_6_0._drag:AddDragBeginListener(arg_6_0._onDragBegin, arg_6_0)
	arg_6_0._drag:AddDragEndListener(arg_6_0._onDragEnd, arg_6_0)
	arg_6_0._drag:AddDragListener(arg_6_0._onDrag, arg_6_0)
	arg_6_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_6_0._onOpenView, arg_6_0)
	arg_6_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_6_0._onCloseView, arg_6_0)
end

function var_0_0._onOpenView(arg_7_0, arg_7_1)
	if arg_7_1 == ViewName.StoryView then
		arg_7_0:_disposeScene()
	end
end

function var_0_0._onCloseView(arg_8_0, arg_8_1)
	if arg_8_1 == ViewName.StoryView then
		arg_8_0:_rebuildScene()
	end
end

function var_0_0._onDragBegin(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0._dragBeginPos = arg_9_0:getDragWorldPos(arg_9_2)

	if arg_9_0._sceneTrans then
		arg_9_0._beginDragPos = arg_9_0._sceneTrans.localPosition
	end
end

function var_0_0._onDragEnd(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._dragBeginPos = nil
	arg_10_0._beginDragPos = nil

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnSetClickDown)
end

function var_0_0._onDrag(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_0._dragBeginPos then
		return
	end

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnSetClickDown)

	local var_11_0 = arg_11_0:getDragWorldPos(arg_11_2) - arg_11_0._dragBeginPos

	arg_11_0:drag(var_11_0)
	arg_11_0:_showFocusBtnState()
end

function var_0_0.drag(arg_12_0, arg_12_1)
	if not arg_12_0._sceneTrans or not arg_12_0._beginDragPos then
		return
	end

	arg_12_0._dragDeltaPos.x = arg_12_1.x
	arg_12_0._dragDeltaPos.y = arg_12_1.y

	local var_12_0 = arg_12_0:vectorAdd(arg_12_0._beginDragPos, arg_12_0._dragDeltaPos)

	arg_12_0:setScenePosSafety(var_12_0)
	arg_12_0:_updateElementArrow()
end

function var_0_0._updateElementArrow(arg_13_0)
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnUpdateElementArrow)
end

function var_0_0.setScenePosSafety(arg_14_0, arg_14_1, arg_14_2)
	if not arg_14_0._sceneTrans then
		return
	end

	if arg_14_1.x < arg_14_0._mapMinX then
		arg_14_1.x = arg_14_0._mapMinX
	elseif arg_14_1.x > arg_14_0._mapMaxX then
		arg_14_1.x = arg_14_0._mapMaxX
	end

	if arg_14_1.y < arg_14_0._mapMinY then
		arg_14_1.y = arg_14_0._mapMinY
	elseif arg_14_1.y > arg_14_0._mapMaxY then
		arg_14_1.y = arg_14_0._mapMaxY
	end

	arg_14_0._targetPos = arg_14_1

	if arg_14_2 then
		local var_14_0 = arg_14_0._tweenTime or 0.26

		ZProj.TweenHelper.DOLocalMove(arg_14_0._sceneTrans, arg_14_1.x, arg_14_1.y, 0, var_14_0, arg_14_0._localMoveDone, arg_14_0, nil, EaseType.InOutQuart)
	else
		arg_14_0._sceneTrans.localPosition = arg_14_1
	end

	arg_14_0:_updateElementArrow()
end

function var_0_0._localMoveDone(arg_15_0)
	arg_15_0:_updateElementArrow()
	arg_15_0:_showFocusBtnState()
end

function var_0_0.vectorAdd(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0._tempVector

	var_16_0.x = arg_16_1.x + arg_16_2.x
	var_16_0.y = arg_16_1.y + arg_16_2.y

	return var_16_0
end

function var_0_0.getDragWorldPos(arg_17_0, arg_17_1)
	local var_17_0 = CameraMgr.instance:getMainCamera()
	local var_17_1 = arg_17_0._gofullscreen.transform.position

	return (SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(arg_17_1.position, var_17_0, var_17_1))
end

function var_0_0._initCamera(arg_18_0)
	local var_18_0 = CameraMgr.instance:getMainCamera()

	var_18_0.orthographic = true

	local var_18_1 = GameUtil.getAdapterScale()

	var_18_0.orthographicSize = VersionActivityEnum.DungeonMapCameraSize * var_18_1
end

function var_0_0._initMapRootNode(arg_19_0)
	local var_19_0 = CameraMgr.instance:getMainCameraTrs().parent
	local var_19_1 = CameraMgr.instance:getSceneRoot()

	arg_19_0._sceneRoot = UnityEngine.GameObject.New("VersionActivity1_2DungeonMapBaseScene")

	local var_19_2, var_19_3, var_19_4 = transformhelper.getLocalPos(var_19_0)

	transformhelper.setLocalPos(arg_19_0._sceneRoot.transform, 0, var_19_3, 20)
	gohelper.addChild(var_19_1, arg_19_0._sceneRoot)
end

function var_0_0.getSceneGo(arg_20_0)
	return arg_20_0._sceneGo
end

function var_0_0.changeMap(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0._forcePos = arg_21_2

	if arg_21_0._mapCfg and arg_21_0._mapCfg.id == arg_21_1.id then
		return
	end

	arg_21_0._mapCfg = arg_21_1

	arg_21_0:initMap()
end

function var_0_0.initMap(arg_22_0)
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
	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.guideOnLoadSceneFinish, arg_23_0._mapCfg.id)

	arg_23_0.goFogEffect = gohelper.clone(arg_23_0._mapLoader:getAssetItem(arg_23_0._fogUrl):GetResource(arg_23_0._fogUrl), arg_23_0._sceneGo)

	transformhelper.setLocalPos(arg_23_0.goFogEffect.transform, 0, 0, -5)

	arg_23_0.goRainEffect = gohelper.findChild(arg_23_0._sceneGo, "SceneEffect")

	arg_23_0:changeDungeonMode(arg_23_0.isHardDungeonMode)
	arg_23_0:_initScene()
	arg_23_0:_initCanvas()
	arg_23_0:_addAllAudio()
	arg_23_0:_onLoadSceneFinish()
end

function var_0_0._onLoadSceneFinish(arg_24_0)
	return
end

function var_0_0._addAllAudio(arg_25_0)
	arg_25_0:_addMapAudio()
end

function var_0_0.buildLoadRes(arg_26_0, arg_26_1, arg_26_2)
	table.insert(arg_26_1, "ui/viewres/dungeon/chaptermap/chaptermapscenecanvas.prefab")
	table.insert(arg_26_1, "ui/viewres/dungeon/chaptermap/dungeonmapinteractiveitem.prefab")
	table.insert(arg_26_1, ResUrl.getDungeonMapRes(arg_26_2.res))
	table.insert(arg_26_1, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_audio_1_1.prefab")
	table.insert(arg_26_1, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light.prefab")
	table.insert(arg_26_1, "scenes/m_s08_hddt/prefab/s08_hddt_hd_01_fog.prefab")
end

function var_0_0.setVisible(arg_27_0, arg_27_1)
	gohelper.setActive(arg_27_0._sceneRoot, arg_27_1)

	if arg_27_1 then
		arg_27_0:_initCamera()
	end
end

function var_0_0._disposeScene(arg_28_0)
	arg_28_0._oldScenePos = arg_28_0._targetPos
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

	TaskDispatcher.cancelTask(arg_28_0._addMapLight, arg_28_0)
	TaskDispatcher.cancelTask(arg_28_0._addAllAudio, arg_28_0)

	arg_28_0._mapAudioGo = nil
end

function var_0_0._rebuildScene(arg_29_0)
	arg_29_0:initMap(arg_29_0._tempMapCfg)

	arg_29_0._tempMapCfg = nil
end

function var_0_0._addMapLight(arg_30_0)
	if arg_30_0._mapLoader then
		local var_30_0 = arg_30_0._mapLightUrl
		local var_30_1 = arg_30_0._mapLoader:getAssetItem(var_30_0):GetResource(var_30_0)

		gohelper.clone(var_30_1, arg_30_0._sceneGo)
	end

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnNormalDungeonInitElements)
end

function var_0_0._addMapAudio(arg_31_0)
	local var_31_0 = arg_31_0._mapAudioUrl
	local var_31_1 = arg_31_0._mapLoader:getAssetItem(var_31_0):GetResource(var_31_0)

	arg_31_0._mapAudioGo = gohelper.clone(var_31_1, arg_31_0._sceneGo, "audio")

	gohelper.addChild(arg_31_0._sceneGo, arg_31_0._mapAudioGo)
	gohelper.setActive(arg_31_0._mapAudioGo, true)
	transformhelper.setLocalPos(arg_31_0._mapAudioGo.transform, 0, 0, 0)

	local var_31_2 = arg_31_0._mapCfg.areaAudio

	if string.nilorempty(var_31_2) then
		return
	end

	local var_31_3 = gohelper.findChild(arg_31_0._mapAudioGo, "audio")

	if var_31_2 == "all" then
		local var_31_4 = var_31_3.transform
		local var_31_5 = var_31_4.childCount

		for iter_31_0 = 1, var_31_5 do
			local var_31_6 = var_31_4:GetChild(iter_31_0 - 1)

			gohelper.setActive(var_31_6.gameObject, true)
		end

		return
	end

	local var_31_7 = string.split(var_31_2, "#")

	for iter_31_1, iter_31_2 in ipairs(var_31_7) do
		local var_31_8 = gohelper.findChild(var_31_3, iter_31_2)

		gohelper.setActive(var_31_8, true)
	end
end

function var_0_0._initCanvas(arg_32_0)
	local var_32_0 = arg_32_0._mapLoader:getAssetItem(arg_32_0._canvasUrl):GetResource(arg_32_0._canvasUrl)

	arg_32_0._sceneCanvasGo = gohelper.clone(var_32_0, arg_32_0._sceneGo)
	arg_32_0._sceneCanvas = arg_32_0._sceneCanvasGo:GetComponent("Canvas")
	arg_32_0._sceneCanvas.worldCamera = CameraMgr.instance:getMainCamera()
	arg_32_0._itemPrefab = arg_32_0._mapLoader:getAssetItem(arg_32_0._interactiveItemUrl):GetResource(arg_32_0._interactiveItemUrl)
end

function var_0_0.getInteractiveItem(arg_33_0)
	arg_33_0._uiGo = gohelper.clone(arg_33_0._itemPrefab, arg_33_0._sceneCanvasGo)
	arg_33_0._interactiveItem = MonoHelper.addLuaComOnceToGo(arg_33_0._uiGo, DungeonMapInteractiveItem)

	arg_33_0._interactiveItem:setBtnClosePosZ(-5)
	gohelper.setActive(arg_33_0._uiGo, false)

	return arg_33_0._interactiveItem
end

function var_0_0.showInteractiveItem(arg_34_0)
	return not gohelper.isNil(arg_34_0._uiGo)
end

function var_0_0._initScene(arg_35_0)
	arg_35_0._mapSize = gohelper.findChild(arg_35_0._sceneGo, "root/size"):GetComponentInChildren(typeof(UnityEngine.BoxCollider)).size

	local var_35_0
	local var_35_1 = GameUtil.getAdapterScale()

	if var_35_1 ~= 1 then
		var_35_0 = ViewMgr.instance:getUILayer(UILayerName.Hud)
	else
		var_35_0 = ViewMgr.instance:getUIRoot()
	end

	local var_35_2 = var_35_0.transform:GetWorldCorners()
	local var_35_3 = CameraMgr.instance:getUICamera()
	local var_35_4 = var_35_3 and var_35_3.orthographicSize or 5
	local var_35_5 = VersionActivityEnum.DungeonMapCameraSize / var_35_4
	local var_35_6 = var_35_2[1] * var_35_1 * var_35_5
	local var_35_7 = var_35_2[3] * var_35_1 * var_35_5

	arg_35_0._viewWidth = math.abs(var_35_7.x - var_35_6.x)
	arg_35_0._viewHeight = math.abs(var_35_7.y - var_35_6.y)
	arg_35_0._mapMinX = var_35_6.x - (arg_35_0._mapSize.x - arg_35_0._viewWidth)
	arg_35_0._mapMaxX = var_35_6.x
	arg_35_0._mapMinY = var_35_6.y
	arg_35_0._mapMaxY = var_35_6.y + (arg_35_0._mapSize.y - arg_35_0._viewHeight)

	if arg_35_0._oldScenePos then
		arg_35_0._sceneTrans.localPosition = arg_35_0._oldScenePos
	end

	if arg_35_0._forcePos then
		arg_35_0._oldScenePos = nil
	end

	arg_35_0._forcePos = nil

	arg_35_0:_setInitPos(arg_35_0._oldScenePos)

	arg_35_0._oldScenePos = nil
end

function var_0_0._setInitPos(arg_36_0, arg_36_1)
	if not arg_36_0._mapCfg then
		return
	end

	local var_36_0 = arg_36_0._mapCfg.initPos
	local var_36_1 = string.splitToNumber(var_36_0, "#")

	arg_36_0:setScenePosSafety(Vector3(var_36_1[1], var_36_1[2], 0), arg_36_1)
end

function var_0_0.disposeOldMap(arg_37_0)
	if arg_37_0._sceneTrans then
		arg_37_0._oldScenePos = arg_37_0._sceneTrans.localPosition
	else
		arg_37_0._oldScenePos = nil
	end

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnDisposeOldMap, arg_37_0.viewName)

	if arg_37_0._oldSceneGo then
		gohelper.destroy(arg_37_0._oldSceneGo)

		arg_37_0._oldSceneGo = nil
	end

	if arg_37_0._mapAudioGo then
		arg_37_0._mapAudioGo = nil

		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
	end

	if arg_37_0._oldMapLoader then
		arg_37_0._oldMapLoader:dispose()

		arg_37_0._oldMapLoader = nil
	end

	TaskDispatcher.cancelTask(arg_37_0._addAllAudio, arg_37_0)
	TaskDispatcher.cancelTask(arg_37_0._addMapLight, arg_37_0)
end

function var_0_0._showMapTip(arg_38_0)
	gohelper.setActive(arg_38_0._gotoptipsbg, false)
end

function var_0_0._hideMapTip(arg_39_0)
	gohelper.setActive(arg_39_0._gotoptipsbg, false)
end

function var_0_0.onOpen(arg_40_0)
	arg_40_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnFocusElement, arg_40_0._focusElementById, arg_40_0)
	arg_40_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_40_0._onScreenResize, arg_40_0)
	arg_40_0:addEventCb(DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, arg_40_0._setEpisodeListVisible, arg_40_0)
end

function var_0_0._setEpisodeListVisible(arg_41_0, arg_41_1)
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
	if arg_43_1 and type(arg_43_1) == "string" then
		arg_43_1 = tonumber(arg_43_1)
	end

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

function var_0_0.changeDungeonMode(arg_44_0, arg_44_1)
	if arg_44_1 then
		AudioEffectMgr.instance:playAudio(AudioEnum.Story.Play_Chapter_Start)
	else
		AudioEffectMgr.instance:stopAudio(AudioEnum.Story.Play_Chapter_Start)
	end

	arg_44_0.isHardDungeonMode = arg_44_1

	if arg_44_0.goRainEffect then
		gohelper.setActive(arg_44_0.goRainEffect, arg_44_1)
	end

	if arg_44_0.goFogEffect then
		gohelper.setActive(arg_44_0.goFogEffect, arg_44_1)
	end
end

function var_0_0.onClose(arg_45_0)
	arg_45_0._drag:RemoveDragBeginListener()
	arg_45_0._drag:RemoveDragListener()
	arg_45_0._drag:RemoveDragEndListener()
end

function var_0_0.onDestroyView(arg_46_0)
	arg_46_0:disposeOldMap()

	if arg_46_0._mapLoader then
		arg_46_0._mapLoader:dispose()

		arg_46_0._mapLoader = nil
	end

	TaskDispatcher.cancelTask(arg_46_0._hideMapTip, arg_46_0)
	gohelper.destroy(arg_46_0._sceneRoot)
end

return var_0_0
