module("modules.logic.versionactivity2_4.dungeon.view.map.scene.VersionActivity2_4DungeonMapScene", package.seeall)

local var_0_0 = class("VersionActivity2_4DungeonMapScene", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gofullscreen = gohelper.findChild(arg_1_0.viewGO, "#go_fullscreen")
	arg_1_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_1_0._gofullscreen)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0._onOpenView, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0)
	arg_2_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_2_0._onScreenResize, arg_2_0)
	arg_2_0:addEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, arg_2_0.onModeChange, arg_2_0)
	arg_2_0:addEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnActivityDungeonMoChange, arg_2_0.onActivityDungeonMoChange, arg_2_0)
	arg_2_0:addEventCb(VersionActivity2_4DungeonController.instance, VersionActivity2_4DungeonEvent.OnClickElement, arg_2_0.onClickElement, arg_2_0)
	arg_2_0:addEventCb(VersionActivity2_4DungeonController.instance, VersionActivity2_4DungeonEvent.FocusElement, arg_2_0.onFocusElement, arg_2_0)
	arg_2_0:addEventCb(VersionActivity2_4DungeonController.instance, VersionActivity2_4DungeonEvent.ManualClickElement, arg_2_0.manualClickElement, arg_2_0)

	if arg_2_0._drag then
		arg_2_0._drag:AddDragBeginListener(arg_2_0._onDragBegin, arg_2_0)
		arg_2_0._drag:AddDragEndListener(arg_2_0._onDragEnd, arg_2_0)
		arg_2_0._drag:AddDragListener(arg_2_0._onDrag, arg_2_0)
	end
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_3_0._onOpenView, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
	arg_3_0:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_3_0._onScreenResize, arg_3_0)
	arg_3_0:removeEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, arg_3_0.onModeChange, arg_3_0)
	arg_3_0:removeEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnActivityDungeonMoChange, arg_3_0.onActivityDungeonMoChange, arg_3_0)
	arg_3_0:removeEventCb(VersionActivity2_4DungeonController.instance, VersionActivity2_4DungeonEvent.OnClickElement, arg_3_0.onClickElement, arg_3_0)
	arg_3_0:removeEventCb(VersionActivity2_4DungeonController.instance, VersionActivity2_4DungeonEvent.FocusElement, arg_3_0.onFocusElement, arg_3_0)
	arg_3_0:removeEventCb(VersionActivity2_4DungeonController.instance, VersionActivity2_4DungeonEvent.ManualClickElement, arg_3_0.manualClickElement, arg_3_0)

	if arg_3_0._drag then
		arg_3_0._drag:RemoveDragBeginListener()
		arg_3_0._drag:RemoveDragListener()
		arg_3_0._drag:RemoveDragEndListener()
	end
end

function var_0_0._onOpenView(arg_4_0, arg_4_1)
	if arg_4_1 == ViewName.StoryView then
		arg_4_0:_disposeScene()
		GameGCMgr.instance:dispatchEvent(GameGCEvent.DelayFullGC, 0, arg_4_0)
	end
end

function var_0_0._onCloseView(arg_5_0, arg_5_1)
	if arg_5_1 == ViewName.StoryView then
		arg_5_0:loadMap()
	end
end

function var_0_0._onScreenResize(arg_6_0)
	if arg_6_0._sceneGo then
		local var_6_0 = CameraMgr.instance:getMainCamera()
		local var_6_1 = GameUtil.getAdapterScale()

		var_6_0.orthographicSize = VersionActivity2_4DungeonEnum.DungeonMapCameraSize * var_6_1

		arg_6_0:_initScene()
	end
end

function var_0_0.onModeChange(arg_7_0)
	arg_7_0:refreshMap()
end

function var_0_0.onActivityDungeonMoChange(arg_8_0)
	local var_8_0 = VersionActivity2_4DungeonModel.instance:getMapNeedTweenState()

	arg_8_0:refreshMap(var_8_0)
end

function var_0_0.onClickElement(arg_9_0, arg_9_1)
	if type(arg_9_1) ~= "table" then
		arg_9_1 = arg_9_0.viewContainer.mapSceneElements:getElementComp(tonumber(arg_9_1))
	end

	if arg_9_1 then
		local var_9_0 = arg_9_1:getConfig()

		arg_9_0:focusElementByCo(var_9_0)
	end
end

function var_0_0.focusElementByCo(arg_10_0, arg_10_1)
	local var_10_0 = string.splitToNumber(arg_10_1.pos, "#")
	local var_10_1 = -var_10_0[1] or 0
	local var_10_2 = -var_10_0[2] or 0

	arg_10_0._tempVector:Set(var_10_1, var_10_2, 0)
	arg_10_0:tweenSetScenePos(arg_10_0._tempVector)
end

function var_0_0.onFocusElement(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.mapSceneElementsView:getElementComp(arg_11_1)

	if var_11_0 or arg_11_2 then
		local var_11_1

		if var_11_0 then
			var_11_1 = var_11_0:getConfig()
		else
			var_11_1 = DungeonConfig.instance:getChapterMapElement(arg_11_1)
		end

		if var_11_1 then
			arg_11_0:focusElementByCo(var_11_1)
		end
	else
		arg_11_0:changeToElementEpisode(arg_11_1)
	end
end

function var_0_0.changeToElementEpisode(arg_12_0, arg_12_1)
	local var_12_0 = lua_chapter_map_element.configDict[arg_12_1]

	if not var_12_0 then
		return
	end

	local var_12_1 = var_12_0.mapId

	arg_12_0._mapCfg = lua_chapter_map.configDict[var_12_1]

	local var_12_2 = string.splitToNumber(var_12_0.pos, "#")

	arg_12_0.tempInitPosX = -var_12_2[1] or 0
	arg_12_0.tempInitPosY = -var_12_2[2] or 0

	local var_12_3 = DungeonConfig.instance:getEpisodeIdByMapCo(arg_12_0._mapCfg)

	if VersionActivityDungeonBaseEnum.DungeonMode.Story ~= arg_12_0.activityDungeonMo.mode then
		arg_12_0.activityDungeonMo:changeMode(VersionActivityDungeonBaseEnum.DungeonMode.Story)
	end

	arg_12_0.activityDungeonMo:changeEpisode(var_12_3)
end

function var_0_0.manualClickElement(arg_13_0, arg_13_1)
	if arg_13_0.mapSceneElementsView:getElementComp(arg_13_1) then
		arg_13_0.mapSceneElementsView:manualClickElement(arg_13_1)
	else
		arg_13_0.mapSceneElementsView:setInitClickElement(arg_13_1)
		arg_13_0:changeToElementEpisode(arg_13_1)
	end
end

function var_0_0._onDragBegin(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0._dragBeginPos = arg_14_0:getDragWorldPos(arg_14_2)

	DungeonController.instance:dispatchEvent(DungeonEvent.OnBeginDragMap)
end

function var_0_0._onDrag(arg_15_0, arg_15_1, arg_15_2)
	if not arg_15_0._dragBeginPos then
		return
	end

	local var_15_0 = arg_15_0:getDragWorldPos(arg_15_2)
	local var_15_1 = var_15_0 - arg_15_0._dragBeginPos

	arg_15_0._dragBeginPos = var_15_0

	arg_15_0._tempVector:Set(arg_15_0._scenePos.x + var_15_1.x, arg_15_0._scenePos.y + var_15_1.y)
	arg_15_0:directSetScenePos(arg_15_0._tempVector)
end

function var_0_0._onDragEnd(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0._dragBeginPos = nil
end

function var_0_0.getDragWorldPos(arg_17_0, arg_17_1)
	local var_17_0 = CameraMgr.instance:getMainCamera()
	local var_17_1 = arg_17_0._gofullscreen.transform.position

	return (SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(arg_17_1.position, var_17_0, var_17_1))
end

function var_0_0._editableInitView(arg_18_0)
	arg_18_0.mapSceneElementsView = arg_18_0.viewContainer.mapSceneElements

	if ViewMgr.instance:isOpen(ViewName.MainThumbnailView) then
		MainThumbnailHeroView.setCameraIdle()
	end

	arg_18_0._tempVector = Vector3()
	arg_18_0._dragDeltaPos = Vector3()
	arg_18_0._scenePos = Vector3()

	arg_18_0:_initMapRootNode()
end

function var_0_0._initMapRootNode(arg_19_0)
	arg_19_0._sceneRoot = UnityEngine.GameObject.New(VersionActivity2_4DungeonEnum.SceneRootName)

	local var_19_0 = CameraMgr.instance:getMainCameraTrs().parent
	local var_19_1, var_19_2, var_19_3 = transformhelper.getLocalPos(var_19_0)

	transformhelper.setLocalPos(arg_19_0._sceneRoot.transform, 0, var_19_2, 0)

	local var_19_4 = CameraMgr.instance:getSceneRoot()

	gohelper.addChild(var_19_4, arg_19_0._sceneRoot)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnCreateMapRootGoDone, arg_19_0._sceneRoot)
end

function var_0_0.onUpdateParam(arg_20_0)
	arg_20_0:refreshMap()
end

function var_0_0.onOpen(arg_21_0)
	MainCameraMgr.instance:addView(arg_21_0.viewName, arg_21_0._initCamera, nil, arg_21_0)
	arg_21_0:refreshMap()
end

function var_0_0._initCamera(arg_22_0)
	local var_22_0 = CameraMgr.instance:getMainCamera()

	var_22_0.orthographic = true

	local var_22_1 = GameUtil.getAdapterScale()

	var_22_0.orthographicSize = VersionActivity2_4DungeonEnum.DungeonMapCameraSize * var_22_1
end

function var_0_0.refreshMap(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0._mapCfg = arg_23_2 or VersionActivity2_4DungeonConfig.instance:getEpisodeMapConfig(arg_23_0.activityDungeonMo.episodeId)
	arg_23_0.needTween = arg_23_1

	if arg_23_0._mapCfg.id == arg_23_0._lastLoadMapId then
		if not arg_23_0.loadedDone then
			return
		end

		arg_23_0:_initElements()
		arg_23_0:_setMapPos()
	else
		arg_23_0._lastLoadMapId = arg_23_0._mapCfg.id

		arg_23_0:loadMap()
	end

	VersionActivity2_4DungeonModel.instance:setMapNeedTweenState(true)
end

function var_0_0._initElements(arg_24_0)
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnInitElements)
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

	arg_25_0.loadedDone = false
	arg_25_0._mapLoader = MultiAbLoader.New()

	local var_25_0 = {}

	arg_25_0:buildLoadRes(var_25_0, arg_25_0._mapCfg)

	arg_25_0._sceneUrl = var_25_0[1]
	arg_25_0._mapLightUrl = var_25_0[2]
	arg_25_0._sceneCanvas = var_25_0[3]
	arg_25_0._mapAudioUrl = var_25_0[4]

	arg_25_0._mapLoader:addPath(arg_25_0._sceneUrl)
	arg_25_0._mapLoader:addPath(arg_25_0._mapLightUrl)
	arg_25_0._mapLoader:addPath(arg_25_0._sceneCanvas)
	arg_25_0._mapLoader:addPath(arg_25_0._mapAudioUrl)
	arg_25_0._mapLoader:startLoad(arg_25_0._loadSceneFinish, arg_25_0)
end

function var_0_0.buildLoadRes(arg_26_0, arg_26_1, arg_26_2)
	table.insert(arg_26_1, ResUrl.getDungeonMapRes(arg_26_2.res))
	table.insert(arg_26_1, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light.prefab")
end

function var_0_0._loadSceneFinish(arg_27_0)
	arg_27_0.loadedDone = true

	arg_27_0:disposeOldMap()

	local var_27_0 = arg_27_0._sceneUrl
	local var_27_1 = arg_27_0._mapLoader:getAssetItem(var_27_0):GetResource(var_27_0)

	arg_27_0._sceneGo = gohelper.clone(var_27_1, arg_27_0._sceneRoot, arg_27_0._mapCfg.id)
	arg_27_0._sceneTrans = arg_27_0._sceneGo.transform

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnLoadSceneFinish, {
		mapConfig = arg_27_0._mapCfg,
		mapSceneGo = arg_27_0._sceneGo
	})
	arg_27_0:_initScene()
	arg_27_0:_setMapPos()
	arg_27_0:_addMapLight()
	arg_27_0:_initElements()
	arg_27_0:_addMapAudio()
	arg_27_0:_focusUnfinishStoryElement()
end

function var_0_0._initScene(arg_28_0)
	local var_28_0 = gohelper.findChild(arg_28_0._sceneGo, "root/size")

	arg_28_0._mapSize = var_28_0:GetComponentInChildren(typeof(UnityEngine.BoxCollider)).size

	local var_28_1, var_28_2, var_28_3 = transformhelper.getLocalScale(var_28_0.transform, 0, 0, 0)
	local var_28_4
	local var_28_5 = GameUtil.getAdapterScale()

	if var_28_5 ~= 1 then
		var_28_4 = ViewMgr.instance:getUILayer(UILayerName.Hud)
	else
		var_28_4 = ViewMgr.instance:getUIRoot()
	end

	local var_28_6 = var_28_4.transform:GetWorldCorners()
	local var_28_7 = CameraMgr.instance:getUICamera()
	local var_28_8 = var_28_7 and var_28_7.orthographicSize or 5
	local var_28_9 = VersionActivity2_4DungeonEnum.DungeonMapCameraSize / var_28_8
	local var_28_10 = var_28_6[1] * var_28_5 * var_28_9
	local var_28_11 = var_28_6[3] * var_28_5 * var_28_9

	arg_28_0._viewWidth = math.abs(var_28_11.x - var_28_10.x)
	arg_28_0._viewHeight = math.abs(var_28_11.y - var_28_10.y)
	arg_28_0._mapMinX = var_28_10.x - (arg_28_0._mapSize.x * var_28_1 - arg_28_0._viewWidth)
	arg_28_0._mapMaxX = var_28_10.x
	arg_28_0._mapMinY = var_28_10.y
	arg_28_0._mapMaxY = var_28_10.y + (arg_28_0._mapSize.y * var_28_2 - arg_28_0._viewHeight)
end

function var_0_0._setMapPos(arg_29_0)
	if arg_29_0.tempInitPosX then
		arg_29_0._tempVector:Set(arg_29_0.tempInitPosX, arg_29_0.tempInitPosY, 0)

		arg_29_0.tempInitPosX = nil
		arg_29_0.tempInitPosY = nil
	else
		local var_29_0 = arg_29_0._mapCfg.initPos
		local var_29_1 = string.splitToNumber(var_29_0, "#")

		arg_29_0._tempVector:Set(var_29_1[1], var_29_1[2], 0)
	end

	if arg_29_0.needTween then
		arg_29_0:tweenSetScenePos(arg_29_0._tempVector, arg_29_0._oldScenePos)

		arg_29_0.needTween = nil
	else
		arg_29_0:directSetScenePos(arg_29_0._tempVector)
	end
end

function var_0_0._addMapLight(arg_30_0)
	local var_30_0 = arg_30_0._mapLightUrl
	local var_30_1 = arg_30_0._mapLoader:getAssetItem(var_30_0):GetResource(var_30_0)

	gohelper.clone(var_30_1, arg_30_0._sceneGo)
end

function var_0_0._addMapAudio(arg_31_0)
	if not arg_31_0._mapAudioUrl then
		return
	end

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

function var_0_0._focusUnfinishStoryElement(arg_32_0)
	local var_32_0 = VersionActivity2_4DungeonModel.instance:checkAndGetUnfinishStoryElementCo(arg_32_0._mapCfg.id)

	if var_32_0 then
		VersionActivity2_4DungeonController.instance:dispatchEvent(VersionActivity2_4DungeonEvent.FocusElement, var_32_0.id)
	end
end

function var_0_0.tweenSetScenePos(arg_33_0, arg_33_1, arg_33_2)
	arg_33_0._tweenTargetPosX, arg_33_0._tweenTargetPosY = arg_33_0:getTargetPos(arg_33_1)
	arg_33_0._tweenStartPosX, arg_33_0._tweenStartPosY = arg_33_0:getTargetPos(arg_33_2 or arg_33_0._scenePos)

	arg_33_0:killTween()

	arg_33_0.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, DungeonEnum.DefaultTweenMapTime, arg_33_0.tweenFrameCallback, arg_33_0.tweenFinishCallback, arg_33_0)

	arg_33_0:tweenFrameCallback(0)
end

function var_0_0.getTargetPos(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_1.x
	local var_34_1 = arg_34_1.y

	if not arg_34_0._mapMinX or not arg_34_0._mapMaxX or not arg_34_0._mapMinY or not arg_34_0._mapMaxY then
		local var_34_2 = arg_34_0._mapCfg and arg_34_0._mapCfg.initPos
		local var_34_3 = string.splitToNumber(var_34_2, "#")

		var_34_0 = var_34_3[1] or 0
		var_34_1 = var_34_3[2] or 0
	else
		if var_34_0 < arg_34_0._mapMinX then
			var_34_0 = arg_34_0._mapMinX
		elseif var_34_0 > arg_34_0._mapMaxX then
			var_34_0 = arg_34_0._mapMaxX
		end

		if var_34_1 < arg_34_0._mapMinY then
			var_34_1 = arg_34_0._mapMinY
		elseif var_34_1 > arg_34_0._mapMaxY then
			var_34_1 = arg_34_0._mapMaxY
		end
	end

	return var_34_0, var_34_1
end

function var_0_0.tweenFrameCallback(arg_35_0, arg_35_1)
	local var_35_0 = Mathf.Lerp(arg_35_0._tweenStartPosX, arg_35_0._tweenTargetPosX, arg_35_1)
	local var_35_1 = Mathf.Lerp(arg_35_0._tweenStartPosY, arg_35_0._tweenTargetPosY, arg_35_1)

	arg_35_0._tempVector:Set(var_35_0, var_35_1, 0)
	arg_35_0:directSetScenePos(arg_35_0._tempVector)
end

function var_0_0.tweenFinishCallback(arg_36_0)
	arg_36_0._tempVector:Set(arg_36_0._tweenTargetPosX, arg_36_0._tweenTargetPosY, 0)
	arg_36_0:directSetScenePos(arg_36_0._tempVector)
end

function var_0_0.directSetScenePos(arg_37_0, arg_37_1)
	local var_37_0, var_37_1 = arg_37_0:getTargetPos(arg_37_1)

	arg_37_0._scenePos.x = var_37_0
	arg_37_0._scenePos.y = var_37_1

	if not arg_37_0._sceneTrans or gohelper.isNil(arg_37_0._sceneTrans) then
		return
	end

	transformhelper.setLocalPos(arg_37_0._sceneTrans, arg_37_0._scenePos.x, arg_37_0._scenePos.y, 0)
	VersionActivity2_4DungeonController.instance:dispatchEvent(VersionActivity2_4DungeonEvent.OnMapPosChanged, arg_37_0._scenePos, arg_37_0.needTween)
	arg_37_0:_updateElementArrow()
end

function var_0_0._updateElementArrow(arg_38_0)
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnUpdateElementArrow)
end

function var_0_0.setVisible(arg_39_0, arg_39_1)
	gohelper.setActive(arg_39_0._sceneRoot, arg_39_1)

	if arg_39_1 then
		arg_39_0:_initCamera()
	end
end

function var_0_0.getSceneGo(arg_40_0)
	return arg_40_0._sceneGo
end

function var_0_0.onClose(arg_41_0)
	arg_41_0:killTween()
	arg_41_0:_resetCamera()
end

function var_0_0.killTween(arg_42_0)
	if arg_42_0.tweenId then
		ZProj.TweenHelper.KillById(arg_42_0.tweenId)
	end
end

function var_0_0._resetCamera(arg_43_0)
	local var_43_0 = CameraMgr.instance:getMainCamera()

	var_43_0.orthographicSize = 5
	var_43_0.orthographic = false
end

function var_0_0.onDestroyView(arg_44_0)
	gohelper.destroy(arg_44_0._sceneRoot)
	arg_44_0:disposeOldMap()
	arg_44_0:_disposeScene()

	if arg_44_0._mapLoader then
		arg_44_0._mapLoader:dispose()
	end
end

function var_0_0.disposeOldMap(arg_45_0)
	if arg_45_0._sceneTrans then
		arg_45_0._oldScenePos = arg_45_0._scenePos
	else
		arg_45_0._oldScenePos = nil
	end

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnDisposeOldMap, arg_45_0.viewName)

	if arg_45_0._oldSceneGo then
		gohelper.destroy(arg_45_0._oldSceneGo)

		arg_45_0._oldSceneGo = nil
	end

	if arg_45_0._mapAudioGo then
		arg_45_0._mapAudioGo = nil

		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
	end

	if arg_45_0._oldMapLoader then
		arg_45_0._oldMapLoader:dispose()

		arg_45_0._oldMapLoader = nil
	end
end

function var_0_0._disposeScene(arg_46_0)
	arg_46_0._oldScenePos = arg_46_0._scenePos

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnDisposeScene)

	if arg_46_0._mapAudioGo then
		arg_46_0._mapAudioGo = nil

		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
	end

	if arg_46_0._sceneGo then
		gohelper.destroy(arg_46_0._sceneGo)

		arg_46_0._sceneGo = nil
	end

	arg_46_0._sceneTrans = nil
	arg_46_0._elementRoot = nil

	if arg_46_0._mapLoader then
		arg_46_0._mapLoader:dispose()

		arg_46_0._mapLoader = nil
	end

	arg_46_0._mapAudioGo = nil
end

return var_0_0
