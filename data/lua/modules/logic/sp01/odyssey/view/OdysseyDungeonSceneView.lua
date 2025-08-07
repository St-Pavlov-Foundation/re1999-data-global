module("modules.logic.sp01.odyssey.view.OdysseyDungeonSceneView", package.seeall)

local var_0_0 = class("OdysseyDungeonSceneView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gofullscreen = gohelper.findChild(arg_1_0.viewGO, "#go_fullscreen")
	arg_1_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_1_0._gofullscreen)
	arg_1_0._gomapName = gohelper.findChild(arg_1_0.viewGO, "root/#go_mapName")
	arg_1_0._gotransitionEffect = gohelper.findChild(arg_1_0.viewGO, "#go_transitionEffect")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(OdysseyDungeonController.instance, OdysseyEvent.OnClickElement, arg_2_0.onClickElement, arg_2_0)
	arg_2_0:addEventCb(OdysseyDungeonController.instance, OdysseyEvent.OnFocusElement, arg_2_0.onFocusElement, arg_2_0)
	arg_2_0:addEventCb(OdysseyDungeonController.instance, OdysseyEvent.OnFocusMapSelectItem, arg_2_0.onFocusMapSelectItem, arg_2_0)
	arg_2_0:addEventCb(OdysseyDungeonController.instance, OdysseyEvent.OnMapSelectItemEnter, arg_2_0.onMapSelectItemEnter, arg_2_0)
	arg_2_0:addEventCb(OdysseyDungeonController.instance, OdysseyEvent.JumpNeedOpenElement, arg_2_0.onJumpNeedOpenElement, arg_2_0)
	arg_2_0:addEventCb(OdysseyDungeonController.instance, OdysseyEvent.JumpToHeroPos, arg_2_0.onJumpToHeroPos, arg_2_0)
	arg_2_0:addEventCb(OdysseyDungeonController.instance, OdysseyEvent.OnUpdateElementPush, arg_2_0.refreshMyth, arg_2_0)
	arg_2_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_2_0._onScreenResize, arg_2_0)

	if arg_2_0._drag then
		arg_2_0._drag:AddDragBeginListener(arg_2_0.onMapDragBegin, arg_2_0)
		arg_2_0._drag:AddDragEndListener(arg_2_0.onMapDragEnd, arg_2_0)
		arg_2_0._drag:AddDragListener(arg_2_0.onMapDrag, arg_2_0)
	end
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(OdysseyDungeonController.instance, OdysseyEvent.OnClickElement, arg_3_0.onClickElement, arg_3_0)
	arg_3_0:removeEventCb(OdysseyDungeonController.instance, OdysseyEvent.OnFocusElement, arg_3_0.onFocusElement, arg_3_0)
	arg_3_0:removeEventCb(OdysseyDungeonController.instance, OdysseyEvent.OnFocusMapSelectItem, arg_3_0.onFocusMapSelectItem, arg_3_0)
	arg_3_0:removeEventCb(OdysseyDungeonController.instance, OdysseyEvent.OnMapSelectItemEnter, arg_3_0.onMapSelectItemEnter, arg_3_0)
	arg_3_0:removeEventCb(OdysseyDungeonController.instance, OdysseyEvent.JumpNeedOpenElement, arg_3_0.onJumpNeedOpenElement, arg_3_0)
	arg_3_0:removeEventCb(OdysseyDungeonController.instance, OdysseyEvent.JumpToHeroPos, arg_3_0.onJumpToHeroPos, arg_3_0)
	arg_3_0:removeEventCb(OdysseyDungeonController.instance, OdysseyEvent.OnUpdateElementPush, arg_3_0.refreshMyth, arg_3_0)
	arg_3_0:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_3_0._onScreenResize, arg_3_0)

	if arg_3_0._drag then
		arg_3_0._drag:RemoveDragBeginListener()
		arg_3_0._drag:RemoveDragListener()
		arg_3_0._drag:RemoveDragEndListener()
	end
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.tempScenePos = Vector3()
	arg_4_0.curScenePos = Vector3()

	arg_4_0:initMapRootNode()

	arg_4_0.elementRootUrl = "ui/viewres/sp01/odyssey/odysseydungeonelementview.prefab"
	arg_4_0.sceneCanvasUrl = "ui/viewres/dungeon/chaptermap/chaptermapscenecanvas.prefab"
	arg_4_0.mapSelectRootUrl = "ui/viewres/sp01/odyssey/odysseydungeonmapselectview.prefab"
	arg_4_0._animMapName = arg_4_0._gomapName:GetComponent(gohelper.Type_Animator)

	gohelper.setActive(arg_4_0._gomapName, false)
end

function var_0_0.initMapRootNode(arg_5_0)
	arg_5_0.sceneRoot = UnityEngine.GameObject.New(OdysseyEnum.SceneRootName)

	local var_5_0 = CameraMgr.instance:getMainCameraTrs().parent
	local var_5_1, var_5_2, var_5_3 = transformhelper.getLocalPos(var_5_0)

	transformhelper.setLocalPos(arg_5_0.sceneRoot.transform, 0, var_5_2, 0)

	local var_5_4 = CameraMgr.instance:getSceneRoot()

	gohelper.addChild(var_5_4, arg_5_0.sceneRoot)
	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnCreateMapRootGoDone, arg_5_0.sceneRoot)
end

function var_0_0.onUpdateParam(arg_6_0)
	arg_6_0:refreshMap()
end

function var_0_0.onOpen(arg_7_0)
	MainCameraMgr.instance:addView(arg_7_0.viewName, arg_7_0.initCamera, nil, arg_7_0)

	arg_7_0.lastMapId = 0
	arg_7_0.canPlayTransitionEffect = true

	if OdysseyDungeonModel.instance:getLastElementFightParam() then
		arg_7_0.canPlayTransitionEffect = false
	end

	arg_7_0:refreshMap()
end

function var_0_0.initCamera(arg_8_0)
	local var_8_0 = CameraMgr.instance:getMainCamera()

	var_8_0.orthographic = true

	local var_8_1 = GameUtil.getAdapterScale()

	var_8_0.orthographicSize = OdysseyEnum.DungeonMapCameraSize * var_8_1
end

function var_0_0.refreshMapSelectView(arg_9_0)
	arg_9_0.mapSelectUrl = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.MapSelectUrl).value
	arg_9_0.lastMapId = 0

	arg_9_0:refreshMap()
	OdysseyStatHelper.instance:sendOdysseyDungeonViewClose(arg_9_0.curMapId, "switch")
end

function var_0_0.onMapSelectItemEnter(arg_10_0)
	arg_10_0.lastMapId = 0

	arg_10_0:refreshMap()

	local var_10_0 = arg_10_0.viewContainer:getDungeonView()

	if var_10_0 then
		var_10_0:setChangeMapUIState(true)
	end
end

function var_0_0.onJumpNeedOpenElement(arg_11_0, arg_11_1)
	local var_11_0 = OdysseyDungeonModel.instance:getElemenetInMapId(arg_11_1)

	if var_11_0 == 0 then
		return
	end

	arg_11_0.isInMapSelectState = OdysseyDungeonModel.instance:getIsInMapSelectState()

	if var_11_0 == arg_11_0.curMapId and not arg_11_0.isInMapSelectState then
		local var_11_1 = OdysseyConfig.instance:getElementConfig(arg_11_1)

		arg_11_0:focusElementByCo(var_11_1)

		local var_11_2 = arg_11_0.viewContainer:getDungeonSceneElementsView()

		if var_11_2 then
			var_11_2:setHeroItemPos(var_11_1)
			var_11_2:playShowOrHideHeroAnim(true, var_11_1.id)
		end

		OdysseyDungeonController.instance:openDungeonInteractView({
			config = var_11_1
		})
	else
		OdysseyDungeonModel.instance:setCurMapId(var_11_0)
		OdysseyDungeonModel.instance:setIsMapSelect(false)
		arg_11_0:onMapSelectItemEnter()

		local var_11_3 = arg_11_0.viewContainer:getDungeonView()

		if var_11_3 then
			var_11_3:refreshUI()
		end
	end
end

function var_0_0.onJumpToHeroPos(arg_12_0)
	local var_12_0 = OdysseyDungeonModel.instance:getCurInElementId()

	if var_12_0 > 0 then
		local var_12_1 = OdysseyDungeonModel.instance:getElemenetInMapId(var_12_0)

		if arg_12_0.curMapId == var_12_1 then
			local var_12_2 = OdysseyConfig.instance:getElementConfig(var_12_0)

			arg_12_0:focusElementByCo(var_12_2)
			OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.PlayElementAnim, var_12_0, OdysseyEnum.ElementAnimName.Tips)
		else
			arg_12_0.lastMapId = 0

			OdysseyDungeonModel.instance:setCurMapId(var_12_1)
			arg_12_0:refreshMap()
		end
	else
		arg_12_0:setMapPos()
	end
end

function var_0_0.refreshMap(arg_13_0, arg_13_1)
	if arg_13_0.canPlayTransitionEffect then
		gohelper.setActive(arg_13_0._gotransitionEffect, false)
		gohelper.setActive(arg_13_0._gotransitionEffect, true)
		AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_mist)
	end

	arg_13_0.isInMapSelectState = OdysseyDungeonModel.instance:getIsInMapSelectState()
	arg_13_0.needTween = arg_13_1
	arg_13_0.curMapId = OdysseyDungeonModel.instance:getCurMapId()

	if arg_13_0.curMapId == arg_13_0.lastMapId then
		if not arg_13_0.mapLoadedDone or not arg_13_0.elementsRootGO or arg_13_0.isInMapSelectState then
			return
		end

		arg_13_0:setMapPos()
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnInitElements, arg_13_0.elementsRootGO)
	else
		arg_13_0.lastMapId = arg_13_0.curMapId

		arg_13_0:loadMap()
	end

	arg_13_0:setCloseOverrideFunc()
end

function var_0_0.loadMap(arg_14_0)
	arg_14_0.curMapConfig = OdysseyConfig.instance:getDungeonMapConfig(arg_14_0.curMapId)
	arg_14_0.mapRes = OdysseyDungeonModel.instance:getMapRes(arg_14_0.curMapId)
	arg_14_0.mythCo = OdysseyDungeonModel.instance:getMythCoMyMapId(arg_14_0.curMapId)
	arg_14_0.mythRes = not arg_14_0.isInMapSelectState and arg_14_0.mythCo and arg_14_0.mythCo.unlockMap or nil

	if arg_14_0.mapLoadedDone then
		arg_14_0.oldMapLoader = arg_14_0.mapLoader
		arg_14_0.oldSceneGo = arg_14_0.sceneGo
		arg_14_0.oldMythGo = arg_14_0.mythGo
		arg_14_0.oldLightGo = arg_14_0.lightGO
		arg_14_0.mapLoader = nil
	end

	if arg_14_0.mapLoader then
		arg_14_0.mapLoader:dispose()

		arg_14_0.mapLoader = nil
	end

	arg_14_0.mapLoadedDone = false
	arg_14_0.mapLoader = MultiAbLoader.New()

	arg_14_0:addLoadRes()
	arg_14_0.mapLoader:startLoad(arg_14_0.loadSceneFinish, arg_14_0)
end

function var_0_0.addLoadRes(arg_15_0)
	if arg_15_0.isInMapSelectState then
		arg_15_0.mapLoader:addPath(ResUrl.getDungeonMapRes(arg_15_0.mapSelectUrl))
		arg_15_0.mapLoader:addPath(arg_15_0.mapSelectRootUrl)
	else
		arg_15_0.mapLoader:addPath(ResUrl.getDungeonMapRes(arg_15_0.mapRes))
		arg_15_0.mapLoader:addPath(arg_15_0.elementRootUrl)

		if arg_15_0.mythRes then
			arg_15_0.mapLoader:addPath(ResUrl.getDungeonMapRes(arg_15_0.mythRes))
		end
	end

	arg_15_0.mapLoader:addPath(OdysseyEnum.DungeonMapLightUrl)
	arg_15_0.mapLoader:addPath(arg_15_0.sceneCanvasUrl)
end

function var_0_0.loadSceneFinish(arg_16_0)
	arg_16_0.mapLoadedDone = true

	arg_16_0:disposeOldMap()

	local var_16_0 = arg_16_0.isInMapSelectState and ResUrl.getDungeonMapRes(arg_16_0.mapSelectUrl) or ResUrl.getDungeonMapRes(arg_16_0.mapRes)
	local var_16_1 = arg_16_0.mapLoader:getAssetItem(var_16_0):GetResource(var_16_0)

	arg_16_0.sceneGo = gohelper.clone(var_16_1, arg_16_0.sceneRoot, arg_16_0.curMapId)
	arg_16_0.sceneTrans = arg_16_0.sceneGo.transform

	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnLoadSceneFinish, {
		mapSceneGo = arg_16_0.sceneGo
	})
	OdysseyStatHelper.instance:initSceneStartTime()
	arg_16_0:initScene()
	arg_16_0:addMapLight()
	arg_16_0:addMythRes()

	if not arg_16_0.isInMapSelectState then
		arg_16_0:initElements()
		arg_16_0:setMapPos()
		arg_16_0:refreshMyth()
	else
		arg_16_0:initMapSelect()
	end

	if arg_16_0.canPlayTransitionEffect then
		arg_16_0:closeTransitionEffect()
		TaskDispatcher.runDelay(arg_16_0.showSubTaskShowEffect, arg_16_0, 1)
	else
		gohelper.setActive(arg_16_0._gotransitionEffect, false)

		if not arg_16_0.isInMapSelectState then
			TaskDispatcher.runDelay(arg_16_0.popupRewardView, arg_16_0, 1)
		end

		arg_16_0:showSubTaskShowEffect()
	end

	arg_16_0.canPlayTransitionEffect = true
end

function var_0_0._onScreenResize(arg_17_0)
	if arg_17_0.sceneGo then
		arg_17_0:initScene()
	end
end

function var_0_0.initScene(arg_18_0)
	local var_18_0 = gohelper.findChild(arg_18_0.sceneGo, "root/size")
	local var_18_1 = var_18_0:GetComponentInChildren(typeof(UnityEngine.BoxCollider))
	local var_18_2, var_18_3, var_18_4 = transformhelper.getLocalScale(var_18_0.transform, 0, 0, 0)
	local var_18_5
	local var_18_6 = GameUtil.getAdapterScale()

	if var_18_6 ~= 1 then
		var_18_5 = ViewMgr.instance:getUILayer(UILayerName.Hud)
	else
		var_18_5 = ViewMgr.instance:getUIRoot()
	end

	local var_18_7 = var_18_5.transform:GetWorldCorners()
	local var_18_8 = CameraMgr.instance:getUICamera()
	local var_18_9 = var_18_8 and var_18_8.orthographicSize or 5
	local var_18_10 = OdysseyEnum.DungeonMapCameraSize / var_18_9
	local var_18_11 = var_18_7[1] * var_18_6 * var_18_10
	local var_18_12 = var_18_7[3] * var_18_6 * var_18_10

	arg_18_0.viewWidth = math.abs(var_18_12.x - var_18_11.x)
	arg_18_0.viewHeight = math.abs(var_18_12.y - var_18_11.y)
	arg_18_0.mapMinX = var_18_11.x - (var_18_1.size.x * var_18_2 - arg_18_0.viewWidth)
	arg_18_0.mapMaxX = var_18_11.x
	arg_18_0.mapMinY = var_18_11.y
	arg_18_0.mapMaxY = var_18_11.y + (var_18_1.size.y * var_18_3 - arg_18_0.viewHeight)
end

function var_0_0.setMapPos(arg_19_0)
	local var_19_0 = OdysseyDungeonModel.instance:getCurInElementId()
	local var_19_1 = OdysseyDungeonModel.instance:getHeroInMapId()

	if var_19_0 > 0 and arg_19_0.curMapId == var_19_1 then
		local var_19_2 = OdysseyConfig.instance:getElementConfig(var_19_0)
		local var_19_3 = string.splitToNumber(var_19_2.pos, "#")
		local var_19_4 = -(var_19_3[1] * arg_19_0.rootScale) or 0
		local var_19_5 = -(var_19_3[2] * arg_19_0.rootScale) or 0

		arg_19_0.tempScenePos:Set(var_19_4, var_19_5, 0)
	else
		local var_19_6 = arg_19_0.curMapConfig.initPos
		local var_19_7 = string.splitToNumber(var_19_6, "#")

		arg_19_0.tempScenePos:Set(var_19_7[1], var_19_7[2], 0)
	end

	if arg_19_0.needTween then
		arg_19_0:tweenSetScenePos(arg_19_0.tempScenePos)

		arg_19_0.needTween = false
	else
		arg_19_0:directSetScenePos(arg_19_0.tempScenePos)
	end
end

function var_0_0.tweenSetScenePos(arg_20_0, arg_20_1)
	arg_20_0.tweenTargetPosX, arg_20_0.tweenTargetPosY = arg_20_0:getTargetPos(arg_20_1)
	arg_20_0.tweenStartPosX, arg_20_0.tweenStartPosY = arg_20_0:getTargetPos(arg_20_0.curScenePos)

	arg_20_0:killTween()

	arg_20_0.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, DungeonEnum.DefaultTweenMapTime, arg_20_0.tweenFrameCallback, arg_20_0.tweenFinishCallback, arg_20_0)

	arg_20_0:tweenFrameCallback(0)
end

function var_0_0.tweenFrameCallback(arg_21_0, arg_21_1)
	local var_21_0 = Mathf.Lerp(arg_21_0.tweenStartPosX, arg_21_0.tweenTargetPosX, arg_21_1)
	local var_21_1 = Mathf.Lerp(arg_21_0.tweenStartPosY, arg_21_0.tweenTargetPosY, arg_21_1)

	arg_21_0.tempScenePos:Set(var_21_0, var_21_1, 0)
	arg_21_0:directSetScenePos(arg_21_0.tempScenePos)
end

function var_0_0.tweenFinishCallback(arg_22_0)
	arg_22_0.tempScenePos:Set(arg_22_0.tweenTargetPosX, arg_22_0.tweenTargetPosY, 0)
	arg_22_0:directSetScenePos(arg_22_0.tempScenePos)
end

function var_0_0.directSetScenePos(arg_23_0, arg_23_1)
	local var_23_0, var_23_1 = arg_23_0:getTargetPos(arg_23_1)

	arg_23_0.curScenePos:Set(var_23_0, var_23_1, 0)

	if not arg_23_0.sceneTrans or gohelper.isNil(arg_23_0.sceneTrans) then
		return
	end

	transformhelper.setLocalPos(arg_23_0.sceneTrans, arg_23_0.curScenePos.x, arg_23_0.curScenePos.y, 0)

	if not arg_23_0.isInMapSelectState then
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnUpdateElementArrow)
	end
end

function var_0_0.getTargetPos(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_1.x
	local var_24_1 = arg_24_1.y

	if not arg_24_0.mapMinX or not arg_24_0.mapMaxX or not arg_24_0.mapMinY or not arg_24_0.mapMaxY then
		local var_24_2 = arg_24_0.curMapConfig and arg_24_0.curMapConfig.initPos
		local var_24_3 = string.splitToNumber(var_24_2, "#")

		var_24_0 = var_24_3[1] or 0
		var_24_1 = var_24_3[2] or 0
	else
		var_24_0 = Mathf.Clamp(var_24_0, arg_24_0.mapMinX, arg_24_0.mapMaxX)
		var_24_1 = Mathf.Clamp(var_24_1, arg_24_0.mapMinY, arg_24_0.mapMaxY)
	end

	return var_24_0, var_24_1
end

function var_0_0.addMapLight(arg_25_0)
	local var_25_0 = OdysseyEnum.DungeonMapLightUrl
	local var_25_1 = arg_25_0.mapLoader:getAssetItem(var_25_0):GetResource(var_25_0)

	arg_25_0.lightGO = gohelper.clone(var_25_1, arg_25_0.sceneGo)
end

function var_0_0.addMythRes(arg_26_0)
	local var_26_0 = arg_26_0.mythRes and ResUrl.getDungeonMapRes(arg_26_0.mythRes) or nil

	if var_26_0 then
		local var_26_1 = arg_26_0.mapLoader:getAssetItem(var_26_0):GetResource(var_26_0)

		arg_26_0.mythGo = gohelper.clone(var_26_1, arg_26_0.sceneGo, "myth" .. arg_26_0.mythCo.id)

		local var_26_2 = string.splitToNumber(arg_26_0.mythCo.pos, "#")

		transformhelper.setLocalPos(arg_26_0.mythGo.transform, var_26_2[1], var_26_2[2], var_26_2[3])
	end
end

function var_0_0.refreshMyth(arg_27_0)
	if arg_27_0.mythGo then
		local var_27_0 = arg_27_0.mythCo and OdysseyDungeonModel.instance:getElementMo(arg_27_0.mythCo.elementId) or nil

		gohelper.setActive(arg_27_0.mythGo, var_27_0)
	end
end

function var_0_0.initElements(arg_28_0)
	local var_28_0 = arg_28_0.mapLoader:getAssetItem(arg_28_0.sceneCanvasUrl):GetResource(arg_28_0.sceneCanvasUrl)

	arg_28_0.elementCanvasGo = gohelper.clone(var_28_0, arg_28_0.sceneGo, "OdysseyElementsCanvas")
	arg_28_0.elementCanvasGo:GetComponent("Canvas").worldCamera = CameraMgr.instance:getMainCamera()

	local var_28_1 = arg_28_0.mapLoader:getAssetItem(arg_28_0.elementRootUrl):GetResource(arg_28_0.elementRootUrl)

	arg_28_0.elementsRootGO = gohelper.clone(var_28_1, arg_28_0.elementCanvasGo, "elementsRoot")

	local var_28_2 = gohelper.findChild(arg_28_0.elementsRootGO, "root")

	arg_28_0.rootScale = transformhelper.getLocalScale(var_28_2.transform)

	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnInitElements, arg_28_0.elementsRootGO)
end

function var_0_0.initMapSelect(arg_29_0)
	local var_29_0 = arg_29_0.mapLoader:getAssetItem(arg_29_0.sceneCanvasUrl):GetResource(arg_29_0.sceneCanvasUrl)

	arg_29_0.mapSelectCanvasGo = gohelper.clone(var_29_0, arg_29_0.sceneGo, "OdysseyMapSelectCanvas")
	arg_29_0.mapSelectCanvasGo:GetComponent("Canvas").worldCamera = CameraMgr.instance:getMainCamera()

	local var_29_1 = arg_29_0.mapLoader:getAssetItem(arg_29_0.mapSelectRootUrl):GetResource(arg_29_0.mapSelectRootUrl)

	arg_29_0.mapSelectRootGO = gohelper.clone(var_29_1, arg_29_0.mapSelectCanvasGo, "mapSelectRoot")

	local var_29_2 = gohelper.findChild(arg_29_0.mapSelectRootGO, "root")

	arg_29_0.rootScale = transformhelper.getLocalScale(var_29_2.transform)

	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnInitMapSelect, arg_29_0.mapSelectRootGO)
end

function var_0_0.setWholeMapPos(arg_30_0)
	local var_30_0 = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.MapSelectPos)
	local var_30_1 = string.splitToNumber(var_30_0.value, "#")

	arg_30_0.tempScenePos:Set(var_30_1[1], var_30_1[2], 0)
	arg_30_0:directSetScenePos(arg_30_0.tempScenePos)
end

function var_0_0.onMapDragBegin(arg_31_0, arg_31_1, arg_31_2)
	OdysseyDungeonModel.instance:setDraggingMapState(true)

	arg_31_0.dragBeginPos = arg_31_0:getDragWorldPos(arg_31_2)

	AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_drag)
end

function var_0_0.onMapDrag(arg_32_0, arg_32_1, arg_32_2)
	if not arg_32_0.dragBeginPos then
		return
	end

	local var_32_0 = arg_32_0:getDragWorldPos(arg_32_2)
	local var_32_1 = var_32_0 - arg_32_0.dragBeginPos

	arg_32_0.dragBeginPos = var_32_0

	arg_32_0.tempScenePos:Set(arg_32_0.curScenePos.x + var_32_1.x, arg_32_0.curScenePos.y + var_32_1.y)
	arg_32_0:directSetScenePos(arg_32_0.tempScenePos)
	OdysseyDungeonModel.instance:setDraggingMapState(true)
end

function var_0_0.onMapDragEnd(arg_33_0, arg_33_1, arg_33_2)
	arg_33_0.dragBeginPos = nil

	OdysseyDungeonModel.instance:setDraggingMapState(false)
end

function var_0_0.getDragWorldPos(arg_34_0, arg_34_1)
	local var_34_0 = CameraMgr.instance:getMainCamera()
	local var_34_1 = arg_34_0._gofullscreen.transform.position

	return (SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(arg_34_1.position, var_34_0, var_34_1))
end

function var_0_0.onClickElement(arg_35_0, arg_35_1)
	if arg_35_1 and arg_35_1.config then
		arg_35_0:focusElementByComp(arg_35_1)
	end
end

function var_0_0.focusElementByComp(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0.elementsRootGO.transform:InverseTransformPoint(arg_36_1.go.transform.position)
	local var_36_1 = -var_36_0.x or 0
	local var_36_2 = -var_36_0.y or 0

	arg_36_0.tempScenePos:Set(var_36_1, var_36_2, 0)
	arg_36_0:tweenSetScenePos(arg_36_0.tempScenePos)
end

function var_0_0.focusElementByCo(arg_37_0, arg_37_1)
	local var_37_0 = string.splitToNumber(arg_37_1.pos, "#")
	local var_37_1 = -(var_37_0[1] * arg_37_0.rootScale) or 0
	local var_37_2 = -(var_37_0[2] * arg_37_0.rootScale) or 0

	arg_37_0.tempScenePos:Set(var_37_1, var_37_2, 0)
	arg_37_0:tweenSetScenePos(arg_37_0.tempScenePos)
end

function var_0_0.onFocusElement(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = arg_38_0.viewContainer:getDungeonSceneElementsView()

	if not var_38_0 then
		return
	end

	local var_38_1 = var_38_0:getElemenetComp(arg_38_1)

	if var_38_1 and var_38_1.config then
		arg_38_0:focusElementByComp(var_38_1)
	elseif arg_38_2 then
		local var_38_2 = OdysseyConfig.instance:getElementConfig(arg_38_1)

		arg_38_0:focusElementByCo(var_38_2)
	end
end

function var_0_0.onFocusMapSelectItem(arg_39_0, arg_39_1, arg_39_2)
	if arg_39_2 then
		arg_39_0:tweenSetScenePos(arg_39_1)
	else
		arg_39_0:directSetScenePos(arg_39_1)
	end

	OdysseyDungeonModel.instance:setNeedFocusMainMapSelectItem(false)
end

function var_0_0.closeTransitionEffect(arg_40_0)
	TaskDispatcher.runDelay(arg_40_0.hideTransitionEffect, arg_40_0, 1.7)
end

function var_0_0.hideTransitionEffect(arg_41_0)
	gohelper.setActive(arg_41_0._gotransitionEffect, false)
	TaskDispatcher.cancelTask(arg_41_0.hideMapName, arg_41_0)

	if not OdysseyDungeonModel.instance:getIsInMapSelectState() then
		gohelper.setActive(arg_41_0._gomapName, true)
		arg_41_0._animMapName:Play("open", 0, 0)
		TaskDispatcher.runDelay(arg_41_0.hideMapName, arg_41_0, 1)
	end

	arg_41_0:popupRewardView()
	arg_41_0:showJumpNeedShowElement()
end

function var_0_0.popupRewardView(arg_42_0)
	OdysseyDungeonController.instance:popupRewardView()
	AssassinController.instance:dispatchEvent(AssassinEvent.EnableLibraryToast, true)
end

function var_0_0.hideMapName(arg_43_0)
	arg_43_0._animMapName:Play("close", 0, 0)
end

function var_0_0.showJumpNeedShowElement(arg_44_0)
	local var_44_0 = OdysseyDungeonModel.instance:getJumpNeedOpenElement()

	if var_44_0 > 0 then
		local var_44_1 = OdysseyConfig.instance:getElementConfig(var_44_0)

		if var_44_1 and var_44_1.mapId == arg_44_0.curMapId then
			OdysseyDungeonController.instance:openDungeonInteractView({
				config = var_44_1
			})
		end
	end
end

function var_0_0.showSubTaskShowEffect(arg_45_0)
	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.PlaySubTaskShowEffect)
end

function var_0_0.setCloseOverrideFunc(arg_46_0)
	arg_46_0.isInMapSelectState = OdysseyDungeonModel.instance:getIsInMapSelectState()

	if arg_46_0.isInMapSelectState then
		arg_46_0.viewContainer:setOverrideCloseClick(arg_46_0.backToLastMap, arg_46_0)
	else
		arg_46_0.viewContainer:setOverrideCloseClick(arg_46_0.closeThis, arg_46_0)
	end
end

function var_0_0.backToLastMap(arg_47_0)
	arg_47_0.canPlayTransitionEffect = false

	ViewMgr.instance:closeView(ViewName.OdysseyDungeonMapSelectInfoView)
	OdysseyDungeonModel.instance:setIsMapSelect(false)
	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnMapSelectItemEnter)
end

function var_0_0.killTween(arg_48_0)
	if arg_48_0.tweenId then
		ZProj.TweenHelper.KillById(arg_48_0.tweenId)
	end
end

function var_0_0.onClose(arg_49_0)
	arg_49_0:killTween()
	arg_49_0:resetCamera()
	TaskDispatcher.cancelTask(arg_49_0.hideTransitionEffect, arg_49_0)
	TaskDispatcher.cancelTask(arg_49_0.hideMapName, arg_49_0)
	TaskDispatcher.cancelTask(arg_49_0.popupRewardView, arg_49_0)
	TaskDispatcher.cancelTask(arg_49_0.showSubTaskShowEffect, arg_49_0)
	OdysseyDungeonModel.instance:setDraggingMapState(false)
	OdysseyStatHelper.instance:sendOdysseyDungeonViewClose(arg_49_0.curMapId, "close")
end

function var_0_0.resetCamera(arg_50_0)
	local var_50_0 = CameraMgr.instance:getMainCamera()

	var_50_0.orthographicSize = 5
	var_50_0.orthographic = false
end

function var_0_0.onDestroyView(arg_51_0)
	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnDisposeScene)
	gohelper.destroy(arg_51_0.sceneRoot)
	arg_51_0:disposeOldMap()

	arg_51_0.sceneTrans = nil

	if arg_51_0.sceneGo then
		gohelper.destroy(arg_51_0.sceneGo)

		arg_51_0.sceneGo = nil
	end

	if arg_51_0.mapLoader then
		arg_51_0.mapLoader:dispose()
	end
end

function var_0_0.disposeOldMap(arg_52_0)
	if arg_52_0.oldMapLoader then
		arg_52_0.oldMapLoader:dispose()

		arg_52_0.oldMapLoader = nil
	end

	if arg_52_0.elementCanvasGo then
		gohelper.destroy(arg_52_0.elementCanvasGo)

		arg_52_0.elementCanvasGo = nil
	end

	if arg_52_0.elementsRootGO then
		gohelper.destroy(arg_52_0.elementsRootGO)

		arg_52_0.elementsRootGO = nil
	end

	if arg_52_0.mapSelectCanvasGo then
		gohelper.destroy(arg_52_0.mapSelectCanvasGo)

		arg_52_0.mapSelectCanvasGo = nil
	end

	if arg_52_0.mapSelectRootGO then
		gohelper.destroy(arg_52_0.mapSelectRootGO)

		arg_52_0.mapSelectRootGO = nil
	end

	if arg_52_0.oldMythGo then
		gohelper.destroy(arg_52_0.oldMythGo)

		arg_52_0.oldMythGo = nil
	end

	if arg_52_0.oldLightGo then
		gohelper.destroy(arg_52_0.oldLightGo)

		arg_52_0.oldLightGo = nil
	end

	if arg_52_0.oldSceneGo then
		gohelper.destroy(arg_52_0.oldSceneGo)

		arg_52_0.oldSceneGo = nil
	end

	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnDisposeOldMap)
end

return var_0_0
