module("modules.logic.versionactivity1_8.dungeon.view.map.scene.VersionActivity1_8DungeonMapScene", package.seeall)

local var_0_0 = class("VersionActivity1_8DungeonMapScene", BaseView)

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
	arg_2_0:addEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnClickElement, arg_2_0.onClickElement, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.FocusElement, arg_2_0.onFocusElement, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.ManualClickElement, arg_2_0.manualClickElement, arg_2_0)

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
	arg_3_0:removeEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnClickElement, arg_3_0.onClickElement, arg_3_0)
	arg_3_0:removeEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.FocusElement, arg_3_0.onFocusElement, arg_3_0)
	arg_3_0:removeEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.ManualClickElement, arg_3_0.manualClickElement, arg_3_0)

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
		arg_5_0:_rebuildScene()
	end
end

function var_0_0._rebuildScene(arg_6_0)
	arg_6_0:loadMap(arg_6_0._tempMapCfg)

	arg_6_0._tempMapCfg = nil
end

function var_0_0._onScreenResize(arg_7_0)
	if arg_7_0._sceneGo then
		local var_7_0 = CameraMgr.instance:getMainCamera()
		local var_7_1 = GameUtil.getAdapterScale()

		var_7_0.orthographicSize = VersionActivity1_8DungeonEnum.DungeonMapCameraSize * var_7_1

		arg_7_0:_initScene()
	end
end

function var_0_0.onModeChange(arg_8_0)
	arg_8_0:refreshMap()
end

function var_0_0.onActivityDungeonMoChange(arg_9_0)
	arg_9_0:refreshMap(true)
end

function var_0_0.onClickElement(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.mapSceneElementsView:getElementComp(arg_10_1)

	if var_10_0 then
		local var_10_1 = var_10_0:getConfig()

		arg_10_0:focusElementByCo(var_10_1)
	end
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

function var_0_0.focusElementByCo(arg_13_0, arg_13_1)
	local var_13_0 = string.splitToNumber(arg_13_1.pos, "#")
	local var_13_1 = -var_13_0[1] or 0
	local var_13_2 = -var_13_0[2] or 0

	arg_13_0._tempVector:Set(var_13_1, var_13_2, 0)
	arg_13_0:tweenSetScenePos(arg_13_0._tempVector)
end

function var_0_0.manualClickElement(arg_14_0, arg_14_1)
	if arg_14_0.mapSceneElementsView:getElementComp(arg_14_1) then
		arg_14_0.mapSceneElementsView:manualClickElement(arg_14_1)
	else
		arg_14_0.mapSceneElementsView:setInitClickElement(arg_14_1)
		arg_14_0:changeToElementEpisode(arg_14_1)
	end
end

function var_0_0._onDragBegin(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0._dragBeginPos = arg_15_0:getDragWorldPos(arg_15_2)

	DungeonController.instance:dispatchEvent(DungeonEvent.OnBeginDragMap)
end

function var_0_0._onDragEnd(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0._dragBeginPos = nil
end

function var_0_0._onDrag(arg_17_0, arg_17_1, arg_17_2)
	if not arg_17_0._dragBeginPos then
		return
	end

	local var_17_0 = arg_17_0:getDragWorldPos(arg_17_2)
	local var_17_1 = var_17_0 - arg_17_0._dragBeginPos

	arg_17_0._dragBeginPos = var_17_0

	arg_17_0._tempVector:Set(arg_17_0._scenePos.x + var_17_1.x, arg_17_0._scenePos.y + var_17_1.y)
	arg_17_0:directSetScenePos(arg_17_0._tempVector)
end

function var_0_0.getDragWorldPos(arg_18_0, arg_18_1)
	local var_18_0 = CameraMgr.instance:getMainCamera()
	local var_18_1 = arg_18_0._gofullscreen.transform.position

	return (SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(arg_18_1.position, var_18_0, var_18_1))
end

function var_0_0._editableInitView(arg_19_0)
	arg_19_0.mapSceneElementsView = arg_19_0.viewContainer.mapSceneElements

	if ViewMgr.instance:isOpen(ViewName.MainThumbnailView) then
		MainThumbnailHeroView.setCameraIdle()
	end

	arg_19_0._tempVector = Vector3()
	arg_19_0._dragDeltaPos = Vector3()
	arg_19_0._scenePos = Vector3()

	arg_19_0:_initMapRootNode()
end

function var_0_0._initMapRootNode(arg_20_0)
	arg_20_0._sceneRoot = UnityEngine.GameObject.New(VersionActivity1_8DungeonEnum.SceneRootName)

	local var_20_0 = CameraMgr.instance:getMainCameraTrs().parent
	local var_20_1, var_20_2, var_20_3 = transformhelper.getLocalPos(var_20_0)

	transformhelper.setLocalPos(arg_20_0._sceneRoot.transform, 0, var_20_2, 0)

	local var_20_4 = CameraMgr.instance:getSceneRoot()

	gohelper.addChild(var_20_4, arg_20_0._sceneRoot)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnCreateMapRootGoDone, arg_20_0._sceneRoot)
end

function var_0_0.onUpdateParam(arg_21_0)
	arg_21_0:refreshMap()
end

function var_0_0.onOpen(arg_22_0)
	MainCameraMgr.instance:addView(arg_22_0.viewName, arg_22_0._initCamera, nil, arg_22_0)
	arg_22_0:refreshMap()
end

function var_0_0._initCamera(arg_23_0)
	local var_23_0 = CameraMgr.instance:getMainCamera()

	var_23_0.orthographic = true

	local var_23_1 = GameUtil.getAdapterScale()

	var_23_0.orthographicSize = VersionActivity1_8DungeonEnum.DungeonMapCameraSize * var_23_1
end

function var_0_0.refreshMap(arg_24_0, arg_24_1)
	arg_24_0._mapCfg = VersionActivity1_8DungeonConfig.instance:getEpisodeMapConfig(arg_24_0.activityDungeonMo.episodeId)

	if arg_24_0._mapCfg.id == arg_24_0._lastLoadMapId then
		arg_24_0:_initElements()
	else
		arg_24_0.needTween = arg_24_1
		arg_24_0._lastLoadMapId = arg_24_0._mapCfg.id

		arg_24_0:loadMap()
	end
end

function var_0_0._initElements(arg_25_0)
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnInitElements)
end

function var_0_0.loadMap(arg_26_0)
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnChangeMap)

	if arg_26_0.loadedDone then
		arg_26_0._oldMapLoader = arg_26_0._mapLoader
		arg_26_0._oldSceneGo = arg_26_0._sceneGo
		arg_26_0._mapLoader = nil
	end

	if arg_26_0._mapLoader then
		arg_26_0._mapLoader:dispose()

		arg_26_0._mapLoader = nil
	end

	arg_26_0._tempMapCfg = nil
	arg_26_0.loadedDone = false
	arg_26_0._mapLoader = MultiAbLoader.New()

	local var_26_0 = {}

	arg_26_0:buildLoadRes(var_26_0, arg_26_0._mapCfg)

	arg_26_0._sceneUrl = var_26_0[1]
	arg_26_0._mapLightUrl = var_26_0[2]
	arg_26_0._mapAudioUrl = var_26_0[3]

	arg_26_0._mapLoader:addPath(arg_26_0._sceneUrl)
	arg_26_0._mapLoader:addPath(arg_26_0._mapLightUrl)
	arg_26_0._mapLoader:addPath(arg_26_0._mapAudioUrl)
	arg_26_0._mapLoader:startLoad(arg_26_0._loadSceneFinish, arg_26_0)
end

function var_0_0.buildLoadRes(arg_27_0, arg_27_1, arg_27_2)
	table.insert(arg_27_1, ResUrl.getDungeonMapRes(arg_27_2.res))
	table.insert(arg_27_1, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light.prefab")
end

function var_0_0._loadSceneFinish(arg_28_0)
	arg_28_0.loadedDone = true

	arg_28_0:disposeOldMap()

	local var_28_0 = arg_28_0._sceneUrl
	local var_28_1 = arg_28_0._mapLoader:getAssetItem(var_28_0):GetResource(var_28_0)

	arg_28_0._sceneGo = gohelper.clone(var_28_1, arg_28_0._sceneRoot, arg_28_0._mapCfg.id)
	arg_28_0._sceneTrans = arg_28_0._sceneGo.transform

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnLoadSceneFinish, {
		mapConfig = arg_28_0._mapCfg,
		mapSceneGo = arg_28_0._sceneGo
	})
	arg_28_0:_initScene()
	arg_28_0:_setMapPos()
	arg_28_0:_addMapLight()
	arg_28_0:_initElements()
	arg_28_0:_addMapAudio()
end

function var_0_0.disposeOldMap(arg_29_0)
	if arg_29_0._sceneTrans then
		arg_29_0._oldScenePos = arg_29_0._scenePos
	else
		arg_29_0._oldScenePos = nil
	end

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnDisposeOldMap, arg_29_0.viewName)

	if arg_29_0._oldSceneGo then
		gohelper.destroy(arg_29_0._oldSceneGo)

		arg_29_0._oldSceneGo = nil
	end

	if arg_29_0._mapAudioGo then
		arg_29_0._mapAudioGo = nil

		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
	end

	if arg_29_0._oldMapLoader then
		arg_29_0._oldMapLoader:dispose()

		arg_29_0._oldMapLoader = nil
	end
end

function var_0_0._initScene(arg_30_0)
	arg_30_0._mapSize = gohelper.findChild(arg_30_0._sceneGo, "root/size"):GetComponentInChildren(typeof(UnityEngine.BoxCollider)).size

	local var_30_0
	local var_30_1 = GameUtil.getAdapterScale()

	if var_30_1 ~= 1 then
		var_30_0 = ViewMgr.instance:getUILayer(UILayerName.Hud)
	else
		var_30_0 = ViewMgr.instance:getUIRoot()
	end

	local var_30_2 = var_30_0.transform:GetWorldCorners()
	local var_30_3 = CameraMgr.instance:getUICamera()
	local var_30_4 = var_30_3 and var_30_3.orthographicSize or 5
	local var_30_5 = VersionActivity1_8DungeonEnum.DungeonMapCameraSize / var_30_4
	local var_30_6 = var_30_2[1] * var_30_1 * var_30_5
	local var_30_7 = var_30_2[3] * var_30_1 * var_30_5

	arg_30_0._viewWidth = math.abs(var_30_7.x - var_30_6.x)
	arg_30_0._viewHeight = math.abs(var_30_7.y - var_30_6.y)
	arg_30_0._mapMinX = var_30_6.x - (arg_30_0._mapSize.x - arg_30_0._viewWidth)
	arg_30_0._mapMaxX = var_30_6.x
	arg_30_0._mapMinY = var_30_6.y
	arg_30_0._mapMaxY = var_30_6.y + (arg_30_0._mapSize.y - arg_30_0._viewHeight)
end

function var_0_0._setMapPos(arg_31_0)
	if arg_31_0.tempInitPosX then
		arg_31_0._tempVector:Set(arg_31_0.tempInitPosX, arg_31_0.tempInitPosY, 0)

		arg_31_0.tempInitPosX = nil
		arg_31_0.tempInitPosY = nil
	else
		local var_31_0 = arg_31_0._mapCfg.initPos
		local var_31_1 = string.splitToNumber(var_31_0, "#")

		arg_31_0._tempVector:Set(var_31_1[1], var_31_1[2], 0)
	end

	if arg_31_0.needTween then
		arg_31_0:tweenSetScenePos(arg_31_0._tempVector, arg_31_0._oldScenePos)

		arg_31_0.needTween = nil
	else
		arg_31_0:directSetScenePos(arg_31_0._tempVector)
	end
end

function var_0_0._addMapLight(arg_32_0)
	local var_32_0 = arg_32_0._mapLightUrl
	local var_32_1 = arg_32_0._mapLoader:getAssetItem(var_32_0):GetResource(var_32_0)

	gohelper.clone(var_32_1, arg_32_0._sceneGo)
end

function var_0_0._addMapAudio(arg_33_0)
	if not arg_33_0._mapAudioUrl then
		return
	end

	local var_33_0 = arg_33_0._mapAudioUrl
	local var_33_1 = arg_33_0._mapLoader:getAssetItem(var_33_0):GetResource(var_33_0)

	arg_33_0._mapAudioGo = gohelper.clone(var_33_1, arg_33_0._sceneGo, "audio")

	gohelper.addChild(arg_33_0._sceneGo, arg_33_0._mapAudioGo)
	gohelper.setActive(arg_33_0._mapAudioGo, true)
	transformhelper.setLocalPos(arg_33_0._mapAudioGo.transform, 0, 0, 0)

	local var_33_2 = arg_33_0._mapCfg.areaAudio

	if string.nilorempty(var_33_2) then
		return
	end

	local var_33_3 = gohelper.findChild(arg_33_0._mapAudioGo, "audio")

	if var_33_2 == "all" then
		local var_33_4 = var_33_3.transform
		local var_33_5 = var_33_4.childCount

		for iter_33_0 = 1, var_33_5 do
			local var_33_6 = var_33_4:GetChild(iter_33_0 - 1)

			gohelper.setActive(var_33_6.gameObject, true)
		end

		return
	end

	local var_33_7 = string.split(var_33_2, "#")

	for iter_33_1, iter_33_2 in ipairs(var_33_7) do
		local var_33_8 = gohelper.findChild(var_33_3, iter_33_2)

		gohelper.setActive(var_33_8, true)
	end
end

function var_0_0.tweenSetScenePos(arg_34_0, arg_34_1, arg_34_2)
	arg_34_0._tweenTargetPosX, arg_34_0._tweenTargetPosY = arg_34_0:getTargetPos(arg_34_1)
	arg_34_0._tweenStartPosX, arg_34_0._tweenStartPosY = arg_34_0:getTargetPos(arg_34_2 or arg_34_0._scenePos)

	arg_34_0:killTween()

	arg_34_0.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, DungeonEnum.DefaultTweenMapTime, arg_34_0.tweenFrameCallback, arg_34_0.tweenFinishCallback, arg_34_0)

	arg_34_0:tweenFrameCallback(0)
end

function var_0_0.getTargetPos(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_1.x
	local var_35_1 = arg_35_1.y

	if not arg_35_0._mapMinX or not arg_35_0._mapMaxX or not arg_35_0._mapMinY or not arg_35_0._mapMaxY then
		local var_35_2 = arg_35_0._mapCfg and arg_35_0._mapCfg.initPos
		local var_35_3 = string.splitToNumber(var_35_2, "#")

		var_35_0 = var_35_3[1] or 0
		var_35_1 = var_35_3[2] or 0
	else
		if var_35_0 < arg_35_0._mapMinX then
			var_35_0 = arg_35_0._mapMinX
		elseif var_35_0 > arg_35_0._mapMaxX then
			var_35_0 = arg_35_0._mapMaxX
		end

		if var_35_1 < arg_35_0._mapMinY then
			var_35_1 = arg_35_0._mapMinY
		elseif var_35_1 > arg_35_0._mapMaxY then
			var_35_1 = arg_35_0._mapMaxY
		end
	end

	return var_35_0, var_35_1
end

function var_0_0.tweenFrameCallback(arg_36_0, arg_36_1)
	local var_36_0 = Mathf.Lerp(arg_36_0._tweenStartPosX, arg_36_0._tweenTargetPosX, arg_36_1)
	local var_36_1 = Mathf.Lerp(arg_36_0._tweenStartPosY, arg_36_0._tweenTargetPosY, arg_36_1)

	arg_36_0._tempVector:Set(var_36_0, var_36_1, 0)
	arg_36_0:directSetScenePos(arg_36_0._tempVector)
end

function var_0_0.tweenFinishCallback(arg_37_0)
	arg_37_0._tempVector:Set(arg_37_0._tweenTargetPosX, arg_37_0._tweenTargetPosY, 0)
	arg_37_0:directSetScenePos(arg_37_0._tempVector)
end

function var_0_0.directSetScenePos(arg_38_0, arg_38_1)
	local var_38_0, var_38_1 = arg_38_0:getTargetPos(arg_38_1)

	arg_38_0._scenePos.x = var_38_0
	arg_38_0._scenePos.y = var_38_1

	if not arg_38_0._sceneTrans or gohelper.isNil(arg_38_0._sceneTrans) then
		return
	end

	transformhelper.setLocalPos(arg_38_0._sceneTrans, arg_38_0._scenePos.x, arg_38_0._scenePos.y, 0)
	VersionActivity1_8DungeonController.instance:dispatchEvent(VersionActivity1_8DungeonEvent.OnMapPosChanged)
	arg_38_0:_updateElementArrow()
end

function var_0_0._updateElementArrow(arg_39_0)
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnUpdateElementArrow)
end

function var_0_0.setVisible(arg_40_0, arg_40_1)
	gohelper.setActive(arg_40_0._sceneRoot, arg_40_1)

	if arg_40_1 then
		arg_40_0:_initCamera()
	end
end

function var_0_0.getSceneGo(arg_41_0)
	return arg_41_0._sceneGo
end

function var_0_0.onClose(arg_42_0)
	arg_42_0:killTween()
	arg_42_0:_resetCamera()
end

function var_0_0.killTween(arg_43_0)
	if arg_43_0.tweenId then
		ZProj.TweenHelper.KillById(arg_43_0.tweenId)
	end
end

function var_0_0._resetCamera(arg_44_0)
	local var_44_0 = CameraMgr.instance:getMainCamera()

	var_44_0.orthographicSize = 5
	var_44_0.orthographic = false
end

function var_0_0.onDestroyView(arg_45_0)
	gohelper.destroy(arg_45_0._sceneRoot)
	arg_45_0:disposeOldMap()
	arg_45_0:_disposeScene()

	if arg_45_0._mapLoader then
		arg_45_0._mapLoader:dispose()
	end
end

function var_0_0._disposeScene(arg_46_0)
	arg_46_0._oldScenePos = arg_46_0._scenePos
	arg_46_0._tempMapCfg = arg_46_0._mapCfg

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
