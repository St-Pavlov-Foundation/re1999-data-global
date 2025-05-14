module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateSceneView", package.seeall)

local var_0_0 = class("EliminateSceneView", BaseView)

function var_0_0.onOpen(arg_1_0)
	local var_1_0 = CameraMgr.instance:getSceneRoot()

	transformhelper.setLocalPos(var_1_0.transform, 0, 0, 0)

	arg_1_0._sceneRoot = UnityEngine.GameObject.New(arg_1_0.__cname)

	arg_1_0:beforeLoadScene()
	gohelper.addChild(var_1_0, arg_1_0._sceneRoot)
	transformhelper.setLocalPos(arg_1_0._sceneRoot.transform, 0, 5, 0)
	MainCameraMgr.instance:addView(arg_1_0.viewName, arg_1_0._initCamera, nil, arg_1_0)

	arg_1_0._loader1 = PrefabInstantiate.Create(arg_1_0._eliminateSceneGo)

	arg_1_0._loader1:startLoad(arg_1_0:getEliminateScenePath(), arg_1_0._onEliminateSceneLoadEnd, arg_1_0)

	arg_1_0._loader2 = PrefabInstantiate.Create(arg_1_0._teamChessGo)

	arg_1_0._loader2:startLoad(arg_1_0:getTeamChessScenePath(), arg_1_0._onTeamChessSceneLoadEnd, arg_1_0)
end

function var_0_0.beforeLoadScene(arg_2_0)
	arg_2_0._sceneTrans = arg_2_0._sceneRoot.transform
	arg_2_0._unitContainer = gohelper.create3d(arg_2_0._sceneRoot, "Unit")
	arg_2_0._unitPosition = arg_2_0._unitContainer.transform.position
	arg_2_0._unitEffectContainer = gohelper.create3d(arg_2_0._sceneRoot, "UnitEffect")

	TeamChessEffectPool.setPoolContainerGO(arg_2_0._unitEffectContainer)
	arg_2_0:_initCanvas()
	transformhelper.setLocalPos(arg_2_0._unitContainer.transform, 0, 0, 0)

	arg_2_0._eliminateSceneGo = gohelper.create3d(arg_2_0._sceneRoot, "EliminateScene")
	arg_2_0._teamChessGo = gohelper.create3d(arg_2_0._sceneRoot, "TeamChessScene")

	arg_2_0:updateSceneState()
end

function var_0_0.setGoPosZ(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0, var_3_1, var_3_2 = transformhelper.getPos(arg_3_1.transform)

	transformhelper.setPos(arg_3_1.transform, var_3_0, var_3_1, arg_3_2)
end

function var_0_0.getTeamChessScenePath(arg_4_0)
	return EliminateTeamChessModel.instance:getCurWarChessEpisodeConfig().chessScene
end

function var_0_0.getEliminateScenePath(arg_5_0)
	return EliminateTeamChessModel.instance:getCurWarChessEpisodeConfig().eliminateScene
end

function var_0_0._onEliminateSceneLoadEnd(arg_6_0)
	local var_6_0 = arg_6_0._loader1:getInstGO()

	transformhelper.setLocalPos(var_6_0.transform, 0, 0.8, 0)
	arg_6_0:setGoPosZ(var_6_0, 1)
end

function var_0_0._onTeamChessSceneLoadEnd(arg_7_0)
	local var_7_0 = arg_7_0._loader2:getInstGO()

	transformhelper.setLocalPos(var_7_0.transform, 0, 0.8, 0)

	local var_7_1, var_7_2, var_7_3 = transformhelper.getPos(var_7_0.transform)

	transformhelper.setPos(var_7_0.transform, var_7_1, var_7_2, 1)
end

function var_0_0._initCamera(arg_8_0)
	local var_8_0 = CameraMgr.instance:getMainCamera()
	local var_8_1 = CameraMgr.instance:getMainCameraTrs()
	local var_8_2 = GameUtil.getAdapterScale(true)

	transformhelper.setLocalRotation(var_8_1, 0, 0, 0)
	transformhelper.setLocalPos(var_8_1, 0, 0, 0)

	var_8_0.orthographic = true
	var_8_0.orthographicSize = 5 * var_8_2
	var_8_0.nearClipPlane = 0.3
	var_8_0.farClipPlane = 1500
end

function var_0_0.setSceneVisible(arg_9_0, arg_9_1)
	gohelper.setActive(arg_9_0._sceneRoot, arg_9_1)
end

function var_0_0.addEvents(arg_10_0)
	arg_10_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_10_0._onScreenResize, arg_10_0)
	arg_10_0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.TeamChessItemBeginDrag, arg_10_0.soliderItemDragBegin, arg_10_0)
	arg_10_0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.TeamChessItemDrag, arg_10_0.soliderItemDrag, arg_10_0)
	arg_10_0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.TeamChessItemDragEnd, arg_10_0.soliderItemDragEnd, arg_10_0)
	arg_10_0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.RefreshStronghold3DChess, arg_10_0.refreshStronghold3DChess, arg_10_0)
	arg_10_0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.RemoveStronghold3DChess, arg_10_0.removeStronghold3DChess, arg_10_0)
	arg_10_0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.HideAllStronghold3DChess, arg_10_0.hideAllStronghold3DChess, arg_10_0)
	arg_10_0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.ShowChessEffect, arg_10_0.showEffect, arg_10_0)
	arg_10_0:addEventCb(EliminateLevelController.instance, EliminateChessEvent.EliminateRoundStateChangeEnd, arg_10_0.updateViewState, arg_10_0)
	arg_10_0:addEventCb(EliminateLevelController.instance, EliminateChessEvent.EliminateRoundStateChange, arg_10_0.updateSceneState, arg_10_0)
	arg_10_0:addEventCb(EliminateLevelController.instance, EliminateChessEvent.TeamChessViewWatchView, arg_10_0.updateTeamChessViewWatchState, arg_10_0)
end

function var_0_0.removeEvents(arg_11_0)
	return
end

function var_0_0.updateSceneState(arg_12_0)
	local var_12_0 = EliminateLevelModel.instance:getCurRoundType()
	local var_12_1 = var_12_0 == EliminateEnum.RoundType.TeamChess
	local var_12_2 = var_12_0 == EliminateEnum.RoundType.Match3Chess

	if arg_12_0._eliminateSceneGo then
		gohelper.setActive(arg_12_0._eliminateSceneGo, var_12_2)
	end

	if arg_12_0._teamChessGo then
		gohelper.setActive(arg_12_0._teamChessGo, var_12_1)
	end

	if var_12_2 then
		arg_12_0:updateViewState()
	end
end

local var_0_1 = Vector2.zero

function var_0_0.soliderItemDragBegin(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = TeamChessUnitEntityMgr.instance:getEmptyEntity(arg_13_0._unitContainer, arg_13_1)

	var_0_1.x, var_0_1.y = arg_13_2, arg_13_3

	var_13_0:setScreenPoint(var_0_1)
	var_13_0:setUnitParentPosition(arg_13_0._unitPosition)
	var_13_0:updateByScreenPos()
	var_13_0:setActive(true)
	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.TeamChessItemBeginModelUpdated, arg_13_1, arg_13_2, arg_13_3)
end

function var_0_0.soliderItemDrag(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5)
	local var_14_0 = TeamChessUnitEntityMgr.instance:getEmptyEntity(arg_14_0._unitContainer, arg_14_1)

	var_0_1.x, var_0_1.y = arg_14_4, arg_14_5

	var_14_0:setScreenPoint(var_0_1)
	var_14_0:setUnitParentPosition(arg_14_0._unitPosition)
	var_14_0:updateByScreenPos()
	var_14_0:setActive(true)
	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.TeamChessItemDragModelUpdated, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5)
end

function var_0_0.soliderItemDragEnd(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
	TeamChessUnitEntityMgr.instance:getEmptyEntity(arg_15_0._unitContainer, arg_15_1):setActive(false)
	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.TeamChessItemDragEndModelUpdated, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
end

function var_0_0.refreshStronghold3DChess(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5)
	if arg_16_1 == nil then
		return
	end

	if arg_16_0.teamChessUnitMoList == nil then
		arg_16_0.teamChessUnitMoList = {}
		arg_16_0.teamChessUnitItem = {}
	end

	local var_16_0 = arg_16_1.uid
	local var_16_1 = arg_16_0.teamChessUnitMoList[var_16_0]
	local var_16_2 = TeamChessUnitEntityMgr.instance:getEntity(var_16_0)

	if var_16_1 ~= nil then
		var_16_1:update(arg_16_1.uid, arg_16_1.id, arg_16_2, arg_16_3, arg_16_1.teamType)
	else
		var_16_1 = TeamChessUnitMO.New()

		var_16_1:init(arg_16_1.uid, arg_16_1.id, arg_16_2, arg_16_3, arg_16_1.teamType)

		var_16_2 = TeamChessUnitEntityMgr.instance:addEntity(var_16_1, arg_16_0._unitContainer)
	end

	if canLogNormal then
		logNormal("EliminateSceneView==>refreshStronghold3DChess--1", arg_16_1.uid)
	end

	if var_16_2 ~= nil then
		var_16_2:refreshTransform(arg_16_4, arg_16_0._unitPosition)
		var_16_2:setCanClick(true)
		var_16_2:setCanDrag(true)
		var_16_2:setActive(true)
		var_16_2:refreshMeshOrder()
	end

	arg_16_0.teamChessUnitMoList[arg_16_1.uid] = var_16_1
end

function var_0_0.removeStronghold3DChess(arg_17_0, arg_17_1)
	if arg_17_0.teamChessUnitMoList == nil then
		return
	end

	arg_17_0.teamChessUnitMoList[arg_17_1] = nil

	TeamChessUnitEntityMgr.instance:removeEntity(arg_17_1)
end

function var_0_0.hideAllStronghold3DChess(arg_18_0)
	TeamChessUnitEntityMgr.instance:setAllEntityActive(false)
end

function var_0_0.updateViewState(arg_19_0)
	local var_19_0 = EliminateLevelModel.instance:getCurRoundType()

	TeamChessUnitEntityMgr.instance:setAllEntityActiveAndPlayAni(var_19_0 == EliminateEnum.RoundType.TeamChess)
	TeamChessUnitEntityMgr.instance:setAllEntityCanClick(var_19_0 == EliminateEnum.RoundType.TeamChess)
	TeamChessUnitEntityMgr.instance:setAllEmptyEntityActive(false)
end

function var_0_0.updateTeamChessViewWatchState(arg_20_0, arg_20_1)
	if arg_20_1 then
		TeamChessUnitEntityMgr.instance:cacheAllEntityShowMode()
		TeamChessUnitEntityMgr.instance:setAllEntityNormal()
	else
		TeamChessUnitEntityMgr.instance:restoreEntityShowMode()
	end

	TeamChessUnitEntityMgr.instance:setAllEntityActiveAndPlayAni(arg_20_1)
	TeamChessUnitEntityMgr.instance:setAllEntityCanClick(arg_20_1)

	if arg_20_0._eliminateSceneGo then
		gohelper.setActive(arg_20_0._eliminateSceneGo, not arg_20_1)
	end

	if arg_20_0._teamChessGo then
		gohelper.setActive(arg_20_0._teamChessGo, arg_20_1)
	end
end

function var_0_0.onOpenFinish(arg_21_0)
	if arg_21_0._sceneGo then
		arg_21_0:calcSceneBoard()
	end
end

function var_0_0._onScreenResize(arg_22_0)
	if arg_22_0._sceneGo then
		arg_22_0:calcSceneBoard()
	end

	arg_22_0:calCanvasWidthAndHeight()
end

function var_0_0.calcSceneBoard(arg_23_0)
	if not arg_23_0._sceneGo then
		return
	end

	local var_23_0 = gohelper.findChild(arg_23_0._sceneGo, "BackGround/size")

	if not var_23_0 then
		return
	end

	local var_23_1 = var_23_0:GetComponentInChildren(typeof(UnityEngine.BoxCollider))

	if not var_23_1 then
		return
	end

	arg_23_0._mapSize = var_23_1.size

	local var_23_2
	local var_23_3 = GameUtil.getAdapterScale()

	if var_23_3 ~= 1 then
		var_23_2 = ViewMgr.instance:getUILayer(UILayerName.Hud)
	else
		var_23_2 = ViewMgr.instance:getUIRoot()
	end

	local var_23_4 = var_23_2.transform:GetWorldCorners()
	local var_23_5 = var_23_4[1] * var_23_3
	local var_23_6 = var_23_4[3] * var_23_3

	arg_23_0._viewWidth = math.abs(var_23_6.x - var_23_5.x)
	arg_23_0._viewHeight = math.abs(var_23_6.y - var_23_5.y)

	local var_23_7 = 5.8
	local var_23_8 = var_23_1.center

	arg_23_0._mapMinX = var_23_5.x - (arg_23_0._mapSize.x / 2 - arg_23_0._viewWidth) - var_23_8.x
	arg_23_0._mapMaxX = var_23_5.x + arg_23_0._mapSize.x / 2 - var_23_8.x
	arg_23_0._mapMinY = var_23_5.y - arg_23_0._mapSize.y / 2 + var_23_7 - var_23_8.y
	arg_23_0._mapMaxY = var_23_5.y + (arg_23_0._mapSize.y / 2 - arg_23_0._viewHeight) + var_23_7 - var_23_8.y
	CameraMgr.instance:getMainCamera().orthographicSize = 5 * GameUtil.getAdapterScale(true)
end

function var_0_0.calCanvasWidthAndHeight(arg_24_0)
	if arg_24_0._sceneCanvasGo == nil then
		return
	end

	local var_24_0 = gohelper.find("POPUP_TOP").transform
	local var_24_1 = recthelper.getWidth(var_24_0)
	local var_24_2 = recthelper.getHeight(var_24_0)

	recthelper.setSize(arg_24_0._sceneCanvasGo.transform, var_24_1, var_24_2)
	recthelper.setSize(arg_24_0._sceneTipCanvasGo.transform, var_24_1, var_24_2)

	local var_24_3 = gohelper.findChild(arg_24_0._sceneCanvasGo, "#go_cameraMain")

	if var_24_3 ~= nil then
		recthelper.setSize(var_24_3.transform, var_24_1, var_24_2)
	end
end

function var_0_0._initCanvas(arg_25_0)
	local var_25_0 = arg_25_0.viewContainer:getSetting().otherRes[4]

	arg_25_0._sceneCanvasGo = arg_25_0:getResInst(var_25_0, arg_25_0._sceneRoot)
	arg_25_0._sceneCanvas = arg_25_0._sceneCanvasGo:GetComponent("Canvas")
	arg_25_0._sceneCanvas.worldCamera = CameraMgr.instance:getMainCamera()
	arg_25_0._sceneCanvas.sortingOrder = -1
	arg_25_0._sceneTipCanvasGo = gohelper.clone(arg_25_0._sceneCanvasGo, arg_25_0._sceneRoot, "SceneTipCanvas")
	arg_25_0._sceneTipCanvas = arg_25_0._sceneTipCanvasGo:GetComponent("Canvas")
	arg_25_0._sceneTipCanvas.worldCamera = CameraMgr.instance:getMainCamera()
	arg_25_0._sceneTipCanvas.sortingOrder = 30

	arg_25_0.viewContainer:setTeamChessViewParent(arg_25_0._sceneCanvasGo, arg_25_0._sceneCanvas)
	arg_25_0.viewContainer:setTeamChessTipViewParent(arg_25_0._sceneTipCanvasGo, arg_25_0._sceneTipCanvas)
	transformhelper.setPosXY(arg_25_0._sceneCanvasGo.transform, 0, 0.8798389)
	transformhelper.setPosXY(arg_25_0._sceneTipCanvasGo.transform, 0, 0.8798389)
end

function var_0_0.showEffect(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4, arg_26_5, arg_26_6, arg_26_7, arg_26_8)
	arg_26_5 = arg_26_5 or 1
	arg_26_6 = arg_26_6 or 1
	arg_26_7 = arg_26_7 or 1

	local var_26_0 = TeamChessEffectPool.getEffect(arg_26_1, arg_26_0._onEffectLoadEnd, arg_26_0)

	var_26_0:setWorldPos(arg_26_2, arg_26_3, arg_26_4)
	var_26_0:setWorldScale(arg_26_5, arg_26_6, arg_26_7)
	var_26_0:play(arg_26_8)
end

function var_0_0.onDestroyView(arg_27_0)
	if arg_27_0.teamChessUnitMoList then
		tabletool.clear(arg_27_0.teamChessUnitMoList)

		arg_27_0.teamChessUnitMoList = nil
	end

	if arg_27_0._eliminateSceneGo then
		arg_27_0._eliminateSceneGo = nil
	end

	if arg_27_0._teamChessGo then
		arg_27_0._teamChessGo = nil
	end

	if arg_27_0._sceneTipCanvasGo then
		arg_27_0._sceneTipCanvas = nil
		arg_27_0._sceneTipCanvasGo = nil
	end

	if arg_27_0._sceneCanvasGo then
		arg_27_0._sceneCanvas = nil
		arg_27_0._sceneCanvasGo = nil
	end

	arg_27_0._unitContainer = nil
	arg_27_0._unitEffectContainer = nil

	if arg_27_0._loader1 then
		arg_27_0._loader1:dispose()

		arg_27_0._loader1 = nil
	end

	if arg_27_0._loader2 then
		arg_27_0._loader2:dispose()

		arg_27_0._loader2 = nil
	end

	if arg_27_0._sceneRoot then
		gohelper.destroy(arg_27_0._sceneRoot)

		arg_27_0._sceneRoot = nil
	end
end

return var_0_0
