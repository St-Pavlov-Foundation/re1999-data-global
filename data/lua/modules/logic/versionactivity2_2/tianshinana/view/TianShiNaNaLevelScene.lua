module("modules.logic.versionactivity2_2.tianshinana.view.TianShiNaNaLevelScene", package.seeall)

local var_0_0 = class("TianShiNaNaLevelScene", TianShiNaNaBaseSceneView)

function var_0_0.onInitView(arg_1_0)
	return
end

function var_0_0.getScenePath(arg_2_0)
	return TianShiNaNaModel.instance.mapCo.path
end

function var_0_0.beforeLoadScene(arg_3_0)
	arg_3_0._sceneTrans = arg_3_0._sceneRoot.transform
	arg_3_0._nodeContainer = gohelper.create3d(arg_3_0._sceneRoot, "Node")
	arg_3_0._unitContainer = gohelper.create3d(arg_3_0._sceneRoot, "Unit")

	transformhelper.setLocalPos(arg_3_0._nodeContainer.transform, 0, 0, 1)
	arg_3_0:_initNodeAndUnit()
end

function var_0_0.addEvents(arg_4_0)
	arg_4_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_4_0._onScreenResize, arg_4_0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.ResetScene, arg_4_0._resetScene, arg_4_0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.DragScene, arg_4_0._onDragScene, arg_4_0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.CheckMapCollapse, arg_4_0._checkMapCollapse, arg_4_0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.PlayerMove, arg_4_0._onPlayerMove, arg_4_0)
end

function var_0_0.removeEvents(arg_5_0)
	arg_5_0:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_5_0._onScreenResize, arg_5_0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.ResetScene, arg_5_0._resetScene, arg_5_0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.DragScene, arg_5_0._onDragScene, arg_5_0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.CheckMapCollapse, arg_5_0._checkMapCollapse, arg_5_0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.PlayerMove, arg_5_0._onPlayerMove, arg_5_0)
end

function var_0_0._initCamera(arg_6_0)
	local var_6_0 = CameraMgr.instance:getMainCamera()
	local var_6_1 = GameUtil.getAdapterScale(true)

	var_6_0.orthographic = true
	var_6_0.orthographicSize = 7 * var_6_1
end

function var_0_0.onSceneLoaded(arg_7_0, arg_7_1)
	arg_7_0._sceneGo = arg_7_1

	arg_7_0:calcSceneBoard()
	arg_7_0:autoFocusPlayer()
	TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.LoadLevelFinish, arg_7_1)
end

function var_0_0._onScreenResize(arg_8_0)
	if arg_8_0._sceneGo then
		arg_8_0:calcSceneBoard()
	end
end

function var_0_0.calcSceneBoard(arg_9_0)
	arg_9_0._mapMinX = -10
	arg_9_0._mapMaxX = 10
	arg_9_0._mapMinY = -10
	arg_9_0._mapMaxY = 10

	if not arg_9_0._sceneGo then
		return
	end

	local var_9_0 = gohelper.findChild(arg_9_0._sceneGo, "BackGround/size")

	if not var_9_0 then
		return
	end

	local var_9_1 = var_9_0:GetComponentInChildren(typeof(UnityEngine.BoxCollider))

	if not var_9_1 then
		return
	end

	local var_9_2 = var_9_0.transform.lossyScale

	arg_9_0._mapSize = var_9_1.size
	arg_9_0._mapSize.x = arg_9_0._mapSize.x * var_9_2.x
	arg_9_0._mapSize.y = arg_9_0._mapSize.y * var_9_2.y

	local var_9_3
	local var_9_4 = GameUtil.getAdapterScale()

	if var_9_4 ~= 1 then
		var_9_3 = ViewMgr.instance:getUILayer(UILayerName.Hud)
	else
		var_9_3 = ViewMgr.instance:getUIRoot()
	end

	local var_9_5 = var_9_4 * 7 / 5
	local var_9_6 = var_9_3.transform:GetWorldCorners()
	local var_9_7 = var_9_6[1] * var_9_5
	local var_9_8 = var_9_6[3] * var_9_5

	arg_9_0._viewWidth = math.abs(var_9_8.x - var_9_7.x)
	arg_9_0._viewHeight = math.abs(var_9_8.y - var_9_7.y)

	local var_9_9 = 5.8
	local var_9_10 = var_9_1.center

	arg_9_0._mapMinX = var_9_7.x - (arg_9_0._mapSize.x / 2 - arg_9_0._viewWidth) - var_9_10.x
	arg_9_0._mapMaxX = var_9_7.x + arg_9_0._mapSize.x / 2 - var_9_10.x
	arg_9_0._mapMinY = var_9_7.y - arg_9_0._mapSize.y / 2 + var_9_9 - var_9_10.y
	arg_9_0._mapMaxY = var_9_7.y + (arg_9_0._mapSize.y / 2 - arg_9_0._viewHeight) + var_9_9 - var_9_10.y
end

function var_0_0.autoFocusPlayer(arg_10_0)
	local var_10_0 = TianShiNaNaModel.instance:getHeroMo()
	local var_10_1 = -TianShiNaNaHelper.nodeToV3(var_10_0)

	var_10_1.y = var_10_1.y + 5.8
	var_10_1.z = 0

	arg_10_0:setScenePosSafety(var_10_1)
end

local var_0_1 = Vector3()

function var_0_0._onDragScene(arg_11_0, arg_11_1)
	if not arg_11_0._targetPos then
		return
	end

	local var_11_0 = CameraMgr.instance:getMainCamera()
	local var_11_1 = SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(arg_11_1.position - arg_11_1.delta, var_11_0, var_0_1)
	local var_11_2 = SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(arg_11_1.position, var_11_0, var_0_1) - var_11_1

	var_11_2.z = 0

	arg_11_0:setScenePosSafety(arg_11_0._targetPos:Add(var_11_2))
end

function var_0_0._onPlayerMove(arg_12_0, arg_12_1)
	local var_12_0 = -arg_12_1

	var_12_0.y = var_12_0.y + 5.8
	var_12_0.z = 0

	arg_12_0:setScenePosSafety(var_12_0)
end

function var_0_0.setScenePosSafety(arg_13_0, arg_13_1)
	if not arg_13_0._mapMinX then
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
	arg_13_0._sceneTrans.localPosition = arg_13_1
	TianShiNaNaModel.instance.nowScenePos = arg_13_1
end

function var_0_0._initNodeAndUnit(arg_14_0)
	TianShiNaNaEntityMgr.instance:clear()

	arg_14_0._mapCo = TianShiNaNaModel.instance.mapCo

	arg_14_0:_initNode()

	for iter_14_0, iter_14_1 in pairs(TianShiNaNaModel.instance.unitMos) do
		TianShiNaNaEntityMgr.instance:addEntity(iter_14_1, arg_14_0._unitContainer)
	end
end

function var_0_0._initNode(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0._mapCo.nodesDict) do
		for iter_15_2, iter_15_3 in pairs(iter_15_1) do
			if not iter_15_3:isCollapse() then
				TianShiNaNaEntityMgr.instance:addNode(iter_15_3, arg_15_0._nodeContainer)
			else
				TianShiNaNaEntityMgr.instance:removeNode(iter_15_3)
			end
		end
	end
end

function var_0_0._checkMapCollapse(arg_16_0)
	for iter_16_0, iter_16_1 in pairs(TianShiNaNaModel.instance.unitMos) do
		local var_16_0 = TianShiNaNaModel.instance.mapCo:getNodeCo(iter_16_1.x, iter_16_1.y)

		if not var_16_0 or var_16_0:isCollapse() then
			TianShiNaNaModel.instance:removeUnit(iter_16_0)
		end
	end

	arg_16_0:_initNode()
end

function var_0_0._resetScene(arg_17_0)
	for iter_17_0, iter_17_1 in pairs(TianShiNaNaModel.instance.unitMos) do
		TianShiNaNaEntityMgr.instance:addEntity(iter_17_1, arg_17_0._unitContainer)
	end

	arg_17_0:_initNode()
end

function var_0_0.onDestroyView(arg_18_0)
	TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.ExitLevel)
	TianShiNaNaEntityMgr.instance:clear()
	var_0_0.super.onDestroyView(arg_18_0)
end

return var_0_0
