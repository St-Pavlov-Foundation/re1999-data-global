module("modules.logic.versionactivity1_6.dungeon.view.map.VersionActivity1_6DungeonMapScene", package.seeall)

local var_0_0 = class("VersionActivity1_6DungeonMapScene", BaseView)

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
	arg_5_0:addEventCb(VersionActivity1_6DungeonController.instance, VersionActivity1_6DungeonEvent.OnClickElement, arg_5_0.onClickElement, arg_5_0)
	arg_5_0:addEventCb(VersionActivity1_6DungeonController.instance, VersionActivity1_6DungeonEvent.FocusElement, arg_5_0.onFocusElement, arg_5_0)
	MainCameraMgr.instance:addView(arg_5_0.viewName, arg_5_0._initCamera, nil, arg_5_0)
	arg_5_0:refreshMap()
end

function var_0_0._initDrag(arg_6_0)
	arg_6_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_6_0._gofullscreen)

	arg_6_0._drag:AddDragBeginListener(arg_6_0._onDragBegin, arg_6_0)
	arg_6_0._drag:AddDragEndListener(arg_6_0._onDragEnd, arg_6_0)
	arg_6_0._drag:AddDragListener(arg_6_0._onDrag, arg_6_0)
end

function var_0_0._onDragBegin(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._dragBeginPos = arg_7_0:getDragWorldPos(arg_7_2)

	VersionActivity1_6DungeonController.instance:dispatchEvent(DungeonEvent.OnBeginDragMap)
end

function var_0_0._onDragEnd(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._dragBeginPos = nil
end

function var_0_0._onDrag(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_0._dragBeginPos then
		return
	end

	local var_9_0 = arg_9_0:getDragWorldPos(arg_9_2)
	local var_9_1 = var_9_0 - arg_9_0._dragBeginPos

	arg_9_0._dragBeginPos = var_9_0

	arg_9_0._tempVector:Set(arg_9_0._scenePos.x + var_9_1.x, arg_9_0._scenePos.y + var_9_1.y)
	arg_9_0:directSetScenePos(arg_9_0._tempVector)
end

function var_0_0.getDragWorldPos(arg_10_0, arg_10_1)
	local var_10_0 = CameraMgr.instance:getMainCamera()
	local var_10_1 = arg_10_0._gofullscreen.transform.position

	return (SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(arg_10_1.position, var_10_0, var_10_1))
end

function var_0_0.onClose(arg_11_0)
	arg_11_0:killTween()
end

function var_0_0.onDestroyView(arg_12_0)
	gohelper.destroy(arg_12_0._sceneRoot)
	arg_12_0:disposeOldMap()
	arg_12_0:_disposeScene()

	if arg_12_0._mapLoader then
		arg_12_0._mapLoader:dispose()
	end

	arg_12_0._drag:RemoveDragBeginListener()
	arg_12_0._drag:RemoveDragListener()
	arg_12_0._drag:RemoveDragEndListener()
end

function var_0_0.onUpdateParam(arg_13_0)
	arg_13_0:refreshMap()
end

function var_0_0.setVisible(arg_14_0, arg_14_1)
	gohelper.setActive(arg_14_0._sceneRoot, arg_14_1)

	if arg_14_1 then
		arg_14_0:_initCamera()
	end
end

function var_0_0._initMapRootNode(arg_15_0)
	local var_15_0 = CameraMgr.instance:getMainCameraTrs().parent
	local var_15_1 = CameraMgr.instance:getSceneRoot()

	arg_15_0._sceneRoot = UnityEngine.GameObject.New(VersionActivity1_6DungeonEnum.SceneRootName)

	local var_15_2, var_15_3, var_15_4 = transformhelper.getLocalPos(var_15_0)

	transformhelper.setLocalPos(arg_15_0._sceneRoot.transform, 0, var_15_3, 0)
	gohelper.addChild(var_15_1, arg_15_0._sceneRoot)
	VersionActivity1_6DungeonController.instance:dispatchEvent(DungeonEvent.OnCreateMapRootGoDone, arg_15_0._sceneRoot)
end

function var_0_0._onOpenView(arg_16_0, arg_16_1)
	if arg_16_1 == ViewName.StoryView then
		arg_16_0:_disposeScene()
		GameGCMgr.instance:dispatchEvent(GameGCEvent.DelayFullGC, 0, arg_16_0)
	end
end

function var_0_0._onCloseView(arg_17_0, arg_17_1)
	if arg_17_1 == ViewName.StoryView then
		arg_17_0:_rebuildScene()
	end
end

function var_0_0.onModeChange(arg_18_0)
	arg_18_0:refreshMap()
end

function var_0_0.onActivityDungeonMoChange(arg_19_0)
	arg_19_0:refreshMap(true)
end

function var_0_0._onScreenResize(arg_20_0)
	if arg_20_0._sceneGo then
		local var_20_0 = CameraMgr.instance:getMainCamera()
		local var_20_1 = GameUtil.getAdapterScale()

		var_20_0.orthographicSize = VersionActivity1_6DungeonEnum.DungeonMapCameraSize * var_20_1

		arg_20_0:_initScene()
	end
end

function var_0_0.getTargetPos(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1.x
	local var_21_1 = arg_21_1.y

	if var_21_0 < arg_21_0._mapMinX then
		var_21_0 = arg_21_0._mapMinX
	elseif var_21_0 > arg_21_0._mapMaxX then
		var_21_0 = arg_21_0._mapMaxX
	end

	if var_21_1 < arg_21_0._mapMinY then
		var_21_1 = arg_21_0._mapMinY
	elseif var_21_1 > arg_21_0._mapMaxY then
		var_21_1 = arg_21_0._mapMaxY
	end

	return var_21_0, var_21_1
end

function var_0_0.directSetScenePos(arg_22_0, arg_22_1)
	local var_22_0, var_22_1 = arg_22_0:getTargetPos(arg_22_1)

	arg_22_0._scenePos.x = var_22_0
	arg_22_0._scenePos.y = var_22_1

	if not arg_22_0._sceneTrans or gohelper.isNil(arg_22_0._sceneTrans) then
		return
	end

	transformhelper.setLocalPos(arg_22_0._sceneTrans, arg_22_0._scenePos.x, arg_22_0._scenePos.y, 0)
	VersionActivity1_6DungeonController.instance:dispatchEvent(VersionActivity1_6DungeonEvent.OnMapPosChanged)
end

function var_0_0.tweenSetScenePos(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0._tweenTargetPosX, arg_23_0._tweenTargetPosY = arg_23_0:getTargetPos(arg_23_1)
	arg_23_0._tweenStartPosX, arg_23_0._tweenStartPosY = arg_23_0:getTargetPos(arg_23_2 or arg_23_0._scenePos)

	arg_23_0:killTween()

	arg_23_0.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, DungeonEnum.DefaultTweenMapTime, arg_23_0.tweenFrameCallback, arg_23_0.tweenFinishCallback, arg_23_0)

	arg_23_0:tweenFrameCallback(0)
end

function var_0_0.tweenFrameCallback(arg_24_0, arg_24_1)
	local var_24_0 = Mathf.Lerp(arg_24_0._tweenStartPosX, arg_24_0._tweenTargetPosX, arg_24_1)
	local var_24_1 = Mathf.Lerp(arg_24_0._tweenStartPosY, arg_24_0._tweenTargetPosY, arg_24_1)

	arg_24_0._tempVector:Set(var_24_0, var_24_1, 0)
	arg_24_0:directSetScenePos(arg_24_0._tempVector)
end

function var_0_0.tweenFinishCallback(arg_25_0)
	arg_25_0._tempVector:Set(arg_25_0._tweenTargetPosX, arg_25_0._tweenTargetPosY, 0)
	arg_25_0:directSetScenePos(arg_25_0._tempVector)
end

function var_0_0.killTween(arg_26_0)
	if arg_26_0.tweenId then
		ZProj.TweenHelper.KillById(arg_26_0.tweenId)
	end
end

function var_0_0._initCamera(arg_27_0)
	local var_27_0 = CameraMgr.instance:getMainCamera()

	var_27_0.orthographic = true

	local var_27_1 = GameUtil.getAdapterScale()

	var_27_0.orthographicSize = VersionActivity1_6DungeonEnum.DungeonMapCameraSize * var_27_1
end

function var_0_0._resetCamera(arg_28_0)
	local var_28_0 = CameraMgr.instance:getMainCamera()

	var_28_0.orthographicSize = 5
	var_28_0.orthographic = false
end

function var_0_0._isSameMap(arg_29_0, arg_29_1, arg_29_2)
	return arg_29_1 == arg_29_2
end

function var_0_0.refreshMap(arg_30_0, arg_30_1)
	arg_30_0._mapCfg = VersionActivity1_6DungeonController.instance:getEpisodeMapConfig(arg_30_0.activityDungeonMo.episodeId)

	if arg_30_0._mapCfg.id == arg_30_0._lastLoadMapId then
		arg_30_0:_initElements()

		return
	end

	arg_30_0.needTween = arg_30_1
	arg_30_0._lastLoadMapId = arg_30_0._mapCfg.id

	arg_30_0:loadMap()
end

function var_0_0.loadMap(arg_31_0)
	VersionActivity1_6DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnChangeMap)

	if arg_31_0.loadedDone then
		arg_31_0._oldMapLoader = arg_31_0._mapLoader
		arg_31_0._oldSceneGo = arg_31_0._sceneGo
		arg_31_0._mapLoader = nil
	end

	if arg_31_0._mapLoader then
		arg_31_0._mapLoader:dispose()

		arg_31_0._mapLoader = nil
	end

	arg_31_0._tempMapCfg = nil
	arg_31_0.loadedDone = false
	arg_31_0._mapLoader = MultiAbLoader.New()

	local var_31_0 = {}

	arg_31_0:buildLoadRes(var_31_0, arg_31_0._mapCfg)

	arg_31_0._sceneUrl = var_31_0[1]
	arg_31_0._mapLightUrl = var_31_0[2]
	arg_31_0._mapAudioUrl = var_31_0[3]

	arg_31_0._mapLoader:addPath(arg_31_0._sceneUrl)
	arg_31_0._mapLoader:addPath(arg_31_0._mapLightUrl)
	arg_31_0._mapLoader:addPath(arg_31_0._mapAudioUrl)
	arg_31_0._mapLoader:startLoad(arg_31_0._loadSceneFinish, arg_31_0)
end

function var_0_0._loadSceneFinish(arg_32_0)
	arg_32_0.loadedDone = true

	arg_32_0:disposeOldMap()

	local var_32_0 = arg_32_0._sceneUrl
	local var_32_1 = arg_32_0._mapLoader:getAssetItem(var_32_0):GetResource(var_32_0)

	arg_32_0._sceneGo = gohelper.clone(var_32_1, arg_32_0._sceneRoot, arg_32_0._mapCfg.id)
	arg_32_0._sceneTrans = arg_32_0._sceneGo.transform

	VersionActivity1_6DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnLoadSceneFinish, {
		mapConfig = arg_32_0._mapCfg,
		mapSceneGo = arg_32_0._sceneGo
	})
	arg_32_0:_initScene()
	arg_32_0:_setMapPos()
	arg_32_0:_addMapLight()
	arg_32_0:_initElements()
	arg_32_0:_addMapAudio()
end

function var_0_0.buildLoadRes(arg_33_0, arg_33_1, arg_33_2)
	table.insert(arg_33_1, ResUrl.getDungeonMapRes(arg_33_2.res))
	table.insert(arg_33_1, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light.prefab")
	table.insert(arg_33_1, "scenes/v1a6_m_s15_sj_wcmt/scene_prefab/v1a6_map_audio.prefab")
end

function var_0_0._disposeScene(arg_34_0)
	arg_34_0._oldScenePos = arg_34_0._scenePos
	arg_34_0._tempMapCfg = arg_34_0._mapCfg

	VersionActivity1_6DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnDisposeScene)

	if arg_34_0._mapAudioGo then
		arg_34_0._mapAudioGo = nil

		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
	end

	if arg_34_0._sceneGo then
		gohelper.destroy(arg_34_0._sceneGo)

		arg_34_0._sceneGo = nil
	end

	arg_34_0._sceneTrans = nil
	arg_34_0._elementRoot = nil

	if arg_34_0._mapLoader then
		arg_34_0._mapLoader:dispose()

		arg_34_0._mapLoader = nil
	end

	arg_34_0._mapAudioGo = nil
end

function var_0_0._rebuildScene(arg_35_0)
	arg_35_0:loadMap(arg_35_0._tempMapCfg)

	arg_35_0._tempMapCfg = nil
end

function var_0_0._addMapLight(arg_36_0)
	local var_36_0 = arg_36_0._mapLightUrl
	local var_36_1 = arg_36_0._mapLoader:getAssetItem(var_36_0):GetResource(var_36_0)

	gohelper.clone(var_36_1, arg_36_0._sceneGo)
end

function var_0_0._addMapAudio(arg_37_0)
	if not arg_37_0._mapAudioUrl then
		return
	end

	local var_37_0 = arg_37_0._mapAudioUrl
	local var_37_1 = arg_37_0._mapLoader:getAssetItem(var_37_0):GetResource(var_37_0)

	arg_37_0._mapAudioGo = gohelper.clone(var_37_1, arg_37_0._sceneGo, "audio")

	gohelper.addChild(arg_37_0._sceneGo, arg_37_0._mapAudioGo)
	gohelper.setActive(arg_37_0._mapAudioGo, true)
	transformhelper.setLocalPos(arg_37_0._mapAudioGo.transform, 0, 0, 0)

	local var_37_2 = arg_37_0._mapCfg.areaAudio

	if string.nilorempty(var_37_2) then
		return
	end

	local var_37_3 = gohelper.findChild(arg_37_0._mapAudioGo, "audio")

	if var_37_2 == "all" then
		local var_37_4 = var_37_3.transform
		local var_37_5 = var_37_4.childCount

		for iter_37_0 = 1, var_37_5 do
			local var_37_6 = var_37_4:GetChild(iter_37_0 - 1)

			gohelper.setActive(var_37_6.gameObject, true)
		end

		return
	end

	local var_37_7 = string.split(var_37_2, "#")

	for iter_37_1, iter_37_2 in ipairs(var_37_7) do
		local var_37_8 = gohelper.findChild(var_37_3, iter_37_2)

		gohelper.setActive(var_37_8, true)
	end
end

function var_0_0._initScene(arg_38_0)
	arg_38_0._mapSize = gohelper.findChild(arg_38_0._sceneGo, "root/size"):GetComponentInChildren(typeof(UnityEngine.BoxCollider)).size

	local var_38_0
	local var_38_1 = GameUtil.getAdapterScale()

	if var_38_1 ~= 1 then
		var_38_0 = ViewMgr.instance:getUILayer(UILayerName.Hud)
	else
		var_38_0 = ViewMgr.instance:getUIRoot()
	end

	local var_38_2 = var_38_0.transform:GetWorldCorners()
	local var_38_3 = CameraMgr.instance:getUICamera()
	local var_38_4 = var_38_3 and var_38_3.orthographicSize or 5
	local var_38_5 = VersionActivity1_6DungeonEnum.DungeonMapCameraSize / var_38_4
	local var_38_6 = var_38_2[1] * var_38_1 * var_38_5
	local var_38_7 = var_38_2[3] * var_38_1 * var_38_5

	arg_38_0._viewWidth = math.abs(var_38_7.x - var_38_6.x)
	arg_38_0._viewHeight = math.abs(var_38_7.y - var_38_6.y)
	arg_38_0._mapMinX = var_38_6.x - (arg_38_0._mapSize.x - arg_38_0._viewWidth)
	arg_38_0._mapMaxX = var_38_6.x
	arg_38_0._mapMinY = var_38_6.y
	arg_38_0._mapMaxY = var_38_6.y + (arg_38_0._mapSize.y - arg_38_0._viewHeight)
end

function var_0_0._setMapPos(arg_39_0)
	if arg_39_0.tempInitPosX then
		arg_39_0._tempVector:Set(arg_39_0.tempInitPosX, arg_39_0.tempInitPosY, 0)

		arg_39_0.tempInitPosX = nil
		arg_39_0.tempInitPosY = nil
	else
		local var_39_0 = arg_39_0._mapCfg.initPos
		local var_39_1 = string.splitToNumber(var_39_0, "#")

		arg_39_0._tempVector:Set(var_39_1[1], var_39_1[2], 0)
	end

	if arg_39_0.needTween then
		arg_39_0:tweenSetScenePos(arg_39_0._tempVector, arg_39_0._oldScenePos)
	else
		arg_39_0:directSetScenePos(arg_39_0._tempVector)
	end
end

function var_0_0.disposeOldMap(arg_40_0)
	if arg_40_0._sceneTrans then
		arg_40_0._oldScenePos = arg_40_0._scenePos
	else
		arg_40_0._oldScenePos = nil
	end

	VersionActivity1_6DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnDisposeOldMap, arg_40_0.viewName)

	if arg_40_0._oldSceneGo then
		gohelper.destroy(arg_40_0._oldSceneGo)

		arg_40_0._oldSceneGo = nil
	end

	if arg_40_0._mapAudioGo then
		arg_40_0._mapAudioGo = nil

		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
	end

	if arg_40_0._oldMapLoader then
		arg_40_0._oldMapLoader:dispose()

		arg_40_0._oldMapLoader = nil
	end
end

function var_0_0.getSceneGo(arg_41_0)
	return arg_41_0._sceneGo
end

function var_0_0._initElements(arg_42_0)
	VersionActivity1_6DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnInitElements)
end

function var_0_0.onClickElement(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_1:getConfig()

	arg_43_0:focusElementByCo(var_43_0)
end

function var_0_0.onFocusElement(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_0.mapSceneElementsView:getElementComp(arg_44_1)

	if var_44_0 then
		local var_44_1 = var_44_0:getConfig()

		arg_44_0:focusElementByCo(var_44_1)
	end
end

function var_0_0.focusElementByCo(arg_45_0, arg_45_1)
	local var_45_0 = string.splitToNumber(arg_45_1.pos, "#")
	local var_45_1 = -var_45_0[1] or 0
	local var_45_2 = -var_45_0[2] or 0

	arg_45_0._tempVector:Set(var_45_1, var_45_2, 0)
	arg_45_0:tweenSetScenePos(arg_45_0._tempVector)
end

return var_0_0
