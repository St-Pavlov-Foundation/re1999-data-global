module("modules.logic.versionactivity1_3.va3chess.game.scene.Va3ChessGameScene", package.seeall)

local var_0_0 = class("Va3ChessGameScene", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._gotouch = gohelper.findChild(arg_1_0.viewGO, "#go_touch")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_2_0.onScreenResize, arg_2_0)
	arg_2_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.AddInteractObj, arg_2_0.createInteractObj, arg_2_0)
	arg_2_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.DeleteInteractAvatar, arg_2_0.deleteInteractObj, arg_2_0)
	arg_2_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.ResetMapView, arg_2_0.onResetMapView, arg_2_0)
	arg_2_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.SetNeedChooseDirectionVisible, arg_2_0.onSetDirectionVisible, arg_2_0)
	arg_2_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.GameReset, arg_2_0.onResetGame, arg_2_0)
	arg_2_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.RefreshAlarmArea, arg_2_0.onAlarmAreaRefresh, arg_2_0)
	arg_2_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.RefreshAlarmAreaOnXY, arg_2_0.refreshAlarmAreaOnXY, arg_2_0)
	arg_2_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.GameMapDataUpdate, arg_2_0.onGameDataUpdate, arg_2_0)
	arg_2_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.GuideClickTile, arg_2_0._guideClickTile, arg_2_0)
	arg_2_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.ResetGameByResultView, arg_2_0.handleResetByResult, arg_2_0)
	arg_2_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.GameResultQuit, arg_2_0.onResultQuit, arg_2_0)
	arg_2_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.EventStart, arg_2_0.onChessStateUpdate, arg_2_0)
	arg_2_0:addEventCb(StoryController.instance, StoryEvent.StoryFrontViewDestroy, arg_2_0._afterPlayStory, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

var_0_0.BLOCK_KEY = "Va3ChessGameSceneLoading"

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._tfTouch = arg_4_0._gotouch.transform
	arg_4_0._click = SLFramework.UGUI.UIClickListener.Get(arg_4_0._gotouch)

	arg_4_0._click:AddClickListener(arg_4_0.onClickContainer, arg_4_0)

	arg_4_0._handler = Va3ChessGameHandler.New()

	arg_4_0._handler:init(arg_4_0)

	arg_4_0._baseTiles = {}
	arg_4_0._baseTilePool = {}
	arg_4_0._dirItems = {}
	arg_4_0._dirItemPool = {}
	arg_4_0._alarmItems = {}
	arg_4_0._alarmItemPool = {}
	arg_4_0._avatarMap = {}
	arg_4_0._fixedOrder = 0

	arg_4_0:createSceneRoot()
	arg_4_0:initCamera()
	Va3ChessGameController.instance:initSceneTree(arg_4_0._gotouch, arg_4_0._sceneOffsetY)
	arg_4_0:loadRes()
end

function var_0_0.onDestroyView(arg_5_0)
	if arg_5_0._click then
		arg_5_0._click:RemoveClickListener()

		arg_5_0._click = nil
	end

	if arg_5_0._handler then
		arg_5_0._handler:dispose()

		arg_5_0._handler = nil
	end

	arg_5_0._baseTiles = nil

	arg_5_0:resetCamera()
	arg_5_0:releaseRes()
	arg_5_0:disposeSceneRoot()
	TaskDispatcher.cancelTask(arg_5_0.delayRefreshAlarmArea, arg_5_0)

	arg_5_0._isWaitingRefreshAlarm = false
end

function var_0_0.onOpen(arg_6_0)
	return
end

function var_0_0.onOpenFinish(arg_7_0)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameViewOpened, arg_7_0.viewParam)
end

function var_0_0.onClose(arg_8_0)
	UIBlockMgr.instance:endBlock(var_0_0.BLOCK_KEY)
	arg_8_0:stopAudio()
end

function var_0_0.playAudio(arg_9_0)
	local var_9_0 = Va3ChessGameModel.instance:getActId()
	local var_9_1 = Va3ChessGameModel.instance:getMapId()

	if var_9_0 and var_9_1 then
		local var_9_2 = Va3ChessConfig.instance:getMapCo(var_9_0, var_9_1)

		arg_9_0:stopAudio()

		if var_9_2 and var_9_2.audioAmbient ~= 0 then
			arg_9_0._triggerAmbientId = AudioMgr.instance:trigger(var_9_2.audioAmbient)
		end
	end
end

function var_0_0.stopAudio(arg_10_0)
	if arg_10_0._triggerAmbientId then
		AudioMgr.instance:stopPlayingID(arg_10_0._triggerAmbientId)

		arg_10_0._triggerAmbientId = nil
	end
end

function var_0_0.onScreenResize(arg_11_0)
	if arg_11_0._sceneGo then
		CameraMgr.instance:getMainCamera().orthographicSize = 7.5 * GameUtil.getAdapterScale(true)
	end
end

function var_0_0.initCamera(arg_12_0)
	if arg_12_0._isInitCamera then
		return
	end

	arg_12_0._isInitCamera = true

	local var_12_0 = CameraMgr.instance:getMainCamera()

	var_12_0.orthographic = true
	var_12_0.orthographicSize = 7.5 * GameUtil.getAdapterScale(true)
end

function var_0_0.resetCamera(arg_13_0)
	local var_13_0 = CameraMgr.instance:getMainCamera()

	var_13_0.orthographicSize = 5
	var_13_0.orthographic = false
end

function var_0_0.loadRes(arg_14_0)
	UIBlockMgr.instance:startBlock(var_0_0.BLOCK_KEY)

	arg_14_0._loader = MultiAbLoader.New()

	arg_14_0._loader:addPath(arg_14_0:getCurrentSceneUrl())
	arg_14_0._loader:addPath(arg_14_0:getGroundItemUrl())
	arg_14_0._loader:addPath(Va3ChessEnum.SceneResPath.DirItem)
	arg_14_0._loader:addPath(Va3ChessEnum.SceneResPath.AlarmItem)
	arg_14_0._loader:addPath(Va3ChessEnum.SceneResPath.AlarmItem2)
	arg_14_0._loader:addPath(Va3ChessEnum.SceneResPath.AlarmItem3)
	arg_14_0:onLoadRes()
	arg_14_0._loader:startLoad(arg_14_0.loadResCompleted, arg_14_0)
end

function var_0_0.onLoadRes(arg_15_0)
	return
end

function var_0_0.getGroundItemUrl(arg_16_0)
	return Va3ChessEnum.SceneResPath.GroundItem
end

function var_0_0.getCurrentSceneUrl(arg_17_0)
	local var_17_0 = Va3ChessGameModel.instance:getMapId()
	local var_17_1 = Va3ChessGameModel.instance:getActId()
	local var_17_2 = Va3ChessConfig.instance:getMapCo(var_17_1, var_17_0)

	if var_17_2 and not string.nilorempty(var_17_2.bgPath) then
		return string.format(Va3ChessEnum.SceneResPath.SceneFormatPath, var_17_2.bgPath)
	else
		return Va3ChessEnum.SceneResPath.DefaultScene
	end
end

function var_0_0.loadResCompleted(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1:getAssetItem(arg_18_0:getCurrentSceneUrl())

	if var_18_0 then
		arg_18_0._sceneGo = gohelper.clone(var_18_0:GetResource(), arg_18_0._sceneRoot, "scene")
		arg_18_0._sceneAnim = arg_18_0._sceneGo:GetComponent(typeof(UnityEngine.Animator))

		arg_18_0._sceneBackground.transform:SetParent(arg_18_0._sceneGo.transform, false)
		arg_18_0._sceneGround.transform:SetParent(arg_18_0._sceneGo.transform, false)
		arg_18_0._sceneContainer.transform:SetParent(arg_18_0._sceneGo.transform, false)
		transformhelper.setLocalPos(arg_18_0._sceneBackground.transform, 0, 0, -0.5)
		transformhelper.setLocalPos(arg_18_0._sceneGround.transform, 0, 0, -1)
		transformhelper.setLocalPos(arg_18_0._sceneContainer.transform, 0, 0, -1.5)
		arg_18_0:fillChessBoardBase()
		arg_18_0:createAllInteractObjs()
		arg_18_0:onloadResCompleted(arg_18_1)
		arg_18_0:playEnterAnim()
		arg_18_0:playAudio()

		if not Va3ChessGameController.instance:getSelectObj() then
			Va3ChessGameController.instance:autoSelectPlayer(true)
		end
	end

	UIBlockMgr.instance:endBlock(var_0_0.BLOCK_KEY)

	local var_18_1 = tostring(Va3ChessModel.instance:getEpisodeId())
	local var_18_2 = tostring(Va3ChessModel.instance:getActId())

	Va3ChessController.instance:dispatchEvent(Va3ChessEvent.GuideOnEnterEpisode, var_18_2 .. "_" .. var_18_1)
end

function var_0_0.onloadResCompleted(arg_19_0, arg_19_1)
	return
end

function var_0_0.releaseRes(arg_20_0)
	if arg_20_0._loader then
		arg_20_0._loader:dispose()

		arg_20_0._loader = nil
	end
end

function var_0_0.createSceneRoot(arg_21_0)
	local var_21_0 = CameraMgr.instance:getMainCameraTrs().parent
	local var_21_1 = CameraMgr.instance:getSceneRoot()

	arg_21_0._sceneRoot = UnityEngine.GameObject.New("ChessMap")
	arg_21_0._sceneBackground = UnityEngine.GameObject.New("background")
	arg_21_0._sceneGround = UnityEngine.GameObject.New("ground")
	arg_21_0._sceneContainer = UnityEngine.GameObject.New("container")

	local var_21_2, var_21_3, var_21_4 = transformhelper.getLocalPos(var_21_0)

	transformhelper.setLocalPos(arg_21_0._sceneRoot.transform, 0, var_21_3, 0)

	arg_21_0._sceneOffsetY = var_21_3

	gohelper.addChild(var_21_1, arg_21_0._sceneRoot)
	gohelper.addChild(arg_21_0._sceneRoot, arg_21_0._sceneBackground)
	gohelper.addChild(arg_21_0._sceneRoot, arg_21_0._sceneGround)
	gohelper.addChild(arg_21_0._sceneRoot, arg_21_0._sceneContainer)
end

function var_0_0.disposeSceneRoot(arg_22_0)
	if arg_22_0._sceneRoot then
		gohelper.destroy(arg_22_0._sceneRoot)

		arg_22_0._sceneRoot = nil
	end
end

function var_0_0.fillChessBoardBase(arg_23_0)
	local var_23_0, var_23_1 = Va3ChessGameModel.instance:getGameSize()

	logNormal("fill w = " .. tostring(var_23_0) .. ", h = " .. tostring(var_23_1))

	for iter_23_0 = 1, var_23_0 do
		arg_23_0._baseTiles[iter_23_0] = arg_23_0._baseTiles[iter_23_0] or {}

		for iter_23_1 = 1, var_23_1 do
			local var_23_2 = arg_23_0:createTileBaseItem(iter_23_0 - 1, iter_23_1 - 1)

			arg_23_0._baseTiles[iter_23_0][iter_23_1] = var_23_2

			local var_23_3 = Va3ChessGameModel.instance:getBaseTile(iter_23_0 - 1, iter_23_1 - 1)

			arg_23_0:onTileItemCreate(iter_23_0 - 1, iter_23_1 - 1, var_23_2)
			gohelper.setActive(var_23_2.go, var_23_3 == Va3ChessEnum.TileBaseType.Normal)
		end
	end
end

function var_0_0.createTileBaseItem(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0

	if #arg_24_0._baseTilePool > 0 then
		var_24_0 = arg_24_0._baseTilePool[1]

		table.remove(arg_24_0._baseTilePool, 1)
	end

	if not var_24_0 then
		var_24_0 = arg_24_0:getUserDataTb_()

		local var_24_1 = arg_24_0:getGroundItemUrl(arg_24_1, arg_24_2)
		local var_24_2 = arg_24_0._loader:getAssetItem(var_24_1)
		local var_24_3 = gohelper.clone(var_24_2:GetResource(), arg_24_0._sceneBackground, "tilebase_" .. arg_24_1 .. "_" .. arg_24_2)

		var_24_0.go = var_24_3
		var_24_0.sceneTf = var_24_3.transform
	end

	arg_24_0:setTileBasePosition(var_24_0, arg_24_1, arg_24_2)

	return var_24_0
end

function var_0_0.setTileBasePosition(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0, var_25_1, var_25_2 = Va3ChessGameController.instance:calcTilePosInScene(arg_25_2, arg_25_3)

	transformhelper.setLocalPos(arg_25_1.sceneTf, var_25_0, var_25_1, var_25_2)
end

function var_0_0.onTileItemCreate(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	return
end

function var_0_0.resetTiles(arg_27_0)
	for iter_27_0, iter_27_1 in pairs(arg_27_0._baseTiles) do
		for iter_27_2, iter_27_3 in pairs(iter_27_1) do
			table.insert(arg_27_0._baseTilePool, iter_27_3)
		end
	end

	arg_27_0._baseTiles = {}

	arg_27_0:fillChessBoardBase()
end

function var_0_0.createAllInteractObjs(arg_28_0)
	logNormal("createAllObjects")

	if not Va3ChessGameController.instance.interacts then
		return
	end

	local var_28_0 = Va3ChessGameController.instance.interacts:getList()

	table.sort(var_28_0, Va3ChessInteractMgr.sortRenderOrder)

	for iter_28_0, iter_28_1 in ipairs(var_28_0) do
		arg_28_0:createInteractObj(iter_28_1)
	end

	arg_28_0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.AllObjectCreated, arg_28_0.createAllInteractObjs, arg_28_0)
end

function var_0_0.createInteractObj(arg_29_0, arg_29_1)
	if gohelper.isNil(arg_29_0._sceneContainer) then
		logNormal("Va3ChessGameScene: game is already end")

		return
	end

	local var_29_0 = Va3ChessInteractMgr.getRenderOrder(arg_29_1)
	local var_29_1 = arg_29_0:getUserDataTb_()

	var_29_1.sceneGo = UnityEngine.GameObject.New("item_" .. arg_29_1.id)
	var_29_1.sceneTf = var_29_1.sceneGo.transform
	var_29_1.loader = PrefabInstantiate.Create(var_29_1.sceneGo)

	var_29_1.sceneTf:SetParent(arg_29_0._sceneContainer.transform, false)

	var_29_1.order = var_29_0 + arg_29_0._fixedOrder
	arg_29_0._fixedOrder = arg_29_0._fixedOrder + 0.01

	arg_29_1:setAvatar(var_29_1)

	arg_29_0._avatarMap[arg_29_1.id] = var_29_1

	local var_29_2 = Va3ChessGameModel.instance:getActId()

	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.SceneInteractObjCreated, var_29_2 .. "_" .. arg_29_1.id)
end

function var_0_0.deleteInteractObj(arg_30_0, arg_30_1)
	arg_30_0._avatarMap[arg_30_1] = nil
end

function var_0_0.createDirItem(arg_31_0)
	local var_31_0
	local var_31_1 = #arg_31_0._dirItemPool

	if var_31_1 > 0 then
		var_31_0 = arg_31_0._dirItemPool[var_31_1]
		arg_31_0._dirItemPool[var_31_1] = nil
	end

	if not var_31_0 then
		var_31_0 = arg_31_0:getUserDataTb_()

		local var_31_2 = arg_31_0._loader:getAssetItem(Va3ChessEnum.SceneResPath.DirItem)

		var_31_0.go = gohelper.clone(var_31_2:GetResource(), arg_31_0._sceneGround, "dirItem")
		var_31_0.sceneTf = var_31_0.go.transform
		var_31_0.goCenter = gohelper.findChild(var_31_0.go, "#go_center")
		var_31_0.goNormal = gohelper.findChild(var_31_0.go, "#go_normal")
		var_31_0.goItem = gohelper.findChild(var_31_0.go, "#go_item")
	end

	table.insert(arg_31_0._dirItems, var_31_0)

	return var_31_0
end

function var_0_0.recycleAllDirItem(arg_32_0)
	for iter_32_0, iter_32_1 in pairs(arg_32_0._dirItems) do
		gohelper.setActive(iter_32_1.go, false)
		table.insert(arg_32_0._dirItemPool, iter_32_1)

		arg_32_0._dirItems[iter_32_0] = nil
	end
end

function var_0_0.onResetMapView(arg_33_0)
	arg_33_0:resetTiles()
end

function var_0_0.onResetGame(arg_34_0)
	arg_34_0._fixedOrder = 1

	arg_34_0:playEnterAnim()
	arg_34_0:resetTiles()
	Va3ChessGameController.instance:setSelectObj(nil)
	Va3ChessGameController.instance:autoSelectPlayer(true)
end

function var_0_0.onGameDataUpdate(arg_35_0)
	if not Va3ChessGameController.instance:getSelectObj() then
		Va3ChessGameController.instance:autoSelectPlayer(true)
	end
end

function var_0_0.onChessStateUpdate(arg_36_0, arg_36_1)
	if arg_36_1 == Va3ChessEnum.GameEventType.Normal then
		local var_36_0 = Va3ChessGameController.instance.interacts:getMainPlayer(true)
		local var_36_1 = var_36_0:getObjPosIndex()
		local var_36_2 = Va3ChessGameModel.instance:getMapId()

		if var_36_2 then
			Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GuideRoundStartCheckPlayerPos, var_36_2 .. "_" .. var_36_1)
		end

		local var_36_3 = var_36_0.originData.posX
		local var_36_4 = var_36_0.originData.posY

		arg_36_0:updatePlayerInteractState(var_36_0, var_36_3 + 1, var_36_4)
		arg_36_0:updatePlayerInteractState(var_36_0, var_36_3 - 1, var_36_4)
		arg_36_0:updatePlayerInteractState(var_36_0, var_36_3, var_36_4 + 1)
		arg_36_0:updatePlayerInteractState(var_36_0, var_36_3, var_36_4 - 1)
	end
end

function var_0_0.updatePlayerInteractState(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	local var_37_0 = arg_37_1.originData.posX
	local var_37_1 = arg_37_1.originData.posY
	local var_37_2 = Va3ChessMapUtils.ToDirection(var_37_0, var_37_1, arg_37_2, arg_37_3)

	Va3ChessGameController.instance:posCanWalk(arg_37_2, arg_37_3, var_37_2, arg_37_1.objType)
end

function var_0_0.onSetDirectionVisible(arg_38_0, arg_38_1)
	arg_38_0:recycleAllDirItem()

	if not arg_38_1 then
		return
	end

	if arg_38_1.visible then
		local var_38_0 = arg_38_1.selectType or Va3ChessEnum.ChessSelectType.Normal

		for iter_38_0 = 1, #arg_38_1.posXList do
			local var_38_1 = arg_38_0:createDirItem()

			arg_38_0:addDirectionItem(var_38_1, arg_38_1.posXList[iter_38_0], arg_38_1.posYList[iter_38_0])
			gohelper.setActive(var_38_1.goNormal, Va3ChessEnum.ChessSelectType.Normal == var_38_0)
			gohelper.setActive(var_38_1.goItem, Va3ChessEnum.ChessSelectType.UseItem == var_38_0)
			gohelper.setActive(var_38_1.goCenter, false)
		end

		if arg_38_1.selfPosX ~= nil and arg_38_1.selfPosY ~= nil then
			local var_38_2 = arg_38_0:createDirItem()

			arg_38_0:addDirectionItem(var_38_2, arg_38_1.selfPosX, arg_38_1.selfPosY)
			gohelper.setActive(var_38_2.goNormal, false)
			gohelper.setActive(var_38_2.goItem, false)
			gohelper.setActive(var_38_2.goCenter, true)
		end

		arg_38_0:delayRefreshAlarmArea()
	else
		arg_38_0:recycleAllAlarmItem()
	end
end

function var_0_0.addDirectionItem(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	gohelper.setActive(arg_39_1.go, true)

	local var_39_0, var_39_1, var_39_2 = Va3ChessGameController.instance:calcTilePosInScene(arg_39_2, arg_39_3, Va3ChessEnum.AlarmOrder.DirItem)

	arg_39_1.tileX = arg_39_2
	arg_39_1.tileY = arg_39_3

	transformhelper.setLocalPos(arg_39_1.sceneTf, var_39_0, var_39_1, var_39_2)
end

function var_0_0._afterPlayStory(arg_40_0)
	arg_40_0:playAudio()
end

function var_0_0.createAlarmItem(arg_41_0, arg_41_1, arg_41_2, arg_41_3, arg_41_4)
	local var_41_0 = false
	local var_41_1 = Va3ChessEnum.SceneResPath.AlarmItem3
	local var_41_2 = {}
	local var_41_3 = false

	if type(arg_41_4) == "table" then
		var_41_0 = arg_41_4.isStatic or var_41_0
		var_41_1 = arg_41_4.resPath or var_41_1
		var_41_2 = arg_41_4.showDirLine or var_41_2
		var_41_3 = arg_41_4.showOrangeStyle or var_41_3
	end

	local var_41_4 = Va3ChessMapUtils.calPosIndex(arg_41_1, arg_41_2)
	local var_41_5 = arg_41_0._alarmItems[var_41_4]

	if var_41_5 then
		for iter_41_0, iter_41_1 in ipairs(var_41_5) do
			if iter_41_1.resPath == var_41_1 then
				return
			end
		end
	end

	local var_41_6
	local var_41_7 = arg_41_0._alarmItemPool[var_41_1]

	if var_41_7 then
		local var_41_8 = #var_41_7

		if var_41_8 > 0 then
			var_41_6 = var_41_7[var_41_8]
			var_41_7[var_41_8] = nil
		end
	end

	if not var_41_6 then
		var_41_6 = arg_41_0:getUserDataTb_()

		local var_41_9 = arg_41_0._loader:getAssetItem(var_41_1) or arg_41_0._loader:getAssetItem(Va3ChessEnum.SceneResPath.AlarmItem)

		var_41_6.go = gohelper.clone(var_41_9:GetResource(), arg_41_0._sceneGround, "alarmItem")
		var_41_6.dir2GO = {}

		for iter_41_2, iter_41_3 in pairs(Va3ChessEnum.Direction) do
			local var_41_10 = gohelper.findChild(var_41_6.go, string.format("dir_%s", iter_41_3))

			var_41_6.dir2GO[iter_41_3] = var_41_10
		end

		var_41_6.sceneTf = var_41_6.go.transform
		var_41_6.redStyle = gohelper.findChild(var_41_6.go, "diban_red")
		var_41_6.orangeStyle = gohelper.findChild(var_41_6.go, "diban_orange")
	end

	for iter_41_4, iter_41_5 in pairs(var_41_6.dir2GO) do
		if not gohelper.isNil(iter_41_5) then
			gohelper.setActive(iter_41_5, false)
		end
	end

	for iter_41_6, iter_41_7 in pairs(var_41_2) do
		local var_41_11 = var_41_6.dir2GO[iter_41_7]

		if not gohelper.isNil(var_41_11) then
			gohelper.setActive(var_41_11, true)
		end
	end

	gohelper.setActive(var_41_6.orangeStyle, var_41_3)
	gohelper.setActive(var_41_6.redStyle, not var_41_3)
	gohelper.setActive(var_41_6.go, true)

	local var_41_12, var_41_13, var_41_14 = Va3ChessGameController.instance:calcTilePosInScene(arg_41_1, arg_41_2, Va3ChessEnum.AlarmOrder.AlarmItem)

	var_41_6.tileX = arg_41_1
	var_41_6.tileY = arg_41_2
	var_41_6.isManual = arg_41_3
	var_41_6.isStatic = var_41_0
	var_41_6.resPath = var_41_1

	transformhelper.setLocalPos(var_41_6.sceneTf, var_41_12, var_41_13, var_41_14)

	if not var_41_5 then
		var_41_5 = {}
		arg_41_0._alarmItems[var_41_4] = var_41_5
	end

	var_41_5[#var_41_5 + 1] = var_41_6

	return var_41_6
end

function var_0_0.recycleAlarmItem(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
	local var_42_0 = Va3ChessMapUtils.calPosIndex(arg_42_1, arg_42_2)
	local var_42_1 = arg_42_0._alarmItems[var_42_0]

	if not var_42_1 then
		return
	end

	for iter_42_0, iter_42_1 in ipairs(var_42_1) do
		gohelper.setActive(iter_42_1.go, false)

		iter_42_1.tileX = nil
		iter_42_1.tileY = nil
		iter_42_1.isManual = nil
		iter_42_1.isStatic = nil

		local var_42_2 = arg_42_0._alarmItemPool[iter_42_1.resPath]

		if not var_42_2 then
			var_42_2 = {}
			arg_42_0._alarmItemPool[iter_42_1.resPath] = var_42_2
		end

		table.insert(var_42_2, iter_42_1)

		var_42_1[iter_42_0] = nil
	end
end

function var_0_0.recycleAllAlarmItem(arg_43_0, arg_43_1)
	for iter_43_0, iter_43_1 in pairs(arg_43_0._alarmItems) do
		for iter_43_2, iter_43_3 in pairs(iter_43_1) do
			local var_43_0 = not iter_43_3.isManual
			local var_43_1 = arg_43_1 or not iter_43_3.isStatic

			if var_43_0 and var_43_1 then
				gohelper.setActive(iter_43_3.go, false)

				local var_43_2 = arg_43_0._alarmItemPool[iter_43_3.resPath]

				if not var_43_2 then
					var_43_2 = {}
					arg_43_0._alarmItemPool[iter_43_3.resPath] = var_43_2
				end

				table.insert(var_43_2, iter_43_3)

				iter_43_1[iter_43_2] = nil
			end
		end
	end
end

function var_0_0.onAlarmAreaRefresh(arg_44_0)
	if arg_44_0._isWaitingRefreshAlarm then
		return
	end

	arg_44_0._isWaitingRefreshAlarm = true

	TaskDispatcher.runDelay(arg_44_0.delayRefreshAlarmArea, arg_44_0, 0.001)
end

function var_0_0.delayRefreshAlarmArea(arg_45_0)
	TaskDispatcher.cancelTask(arg_45_0.delayRefreshAlarmArea, arg_45_0)

	arg_45_0._isWaitingRefreshAlarm = false

	arg_45_0:recycleAllAlarmItem(true)

	if not Va3ChessGameController.instance.interacts then
		return
	end

	local var_45_0 = Va3ChessGameController.instance.interacts:getList()

	if not var_45_0 then
		return
	end

	local var_45_1 = {}

	for iter_45_0, iter_45_1 in ipairs(var_45_0) do
		iter_45_1:getHandler():onDrawAlert(var_45_1)
	end

	for iter_45_2, iter_45_3 in pairs(var_45_1) do
		for iter_45_4, iter_45_5 in pairs(iter_45_3) do
			for iter_45_6, iter_45_7 in pairs(iter_45_5) do
				arg_45_0:createAlarmItem(iter_45_2, iter_45_4, nil, iter_45_7)
			end
		end
	end
end

function var_0_0.refreshAlarmAreaOnXY(arg_46_0, arg_46_1, arg_46_2, arg_46_3)
	if arg_46_3 then
		arg_46_0:createAlarmItem(arg_46_1, arg_46_2, true)
	else
		arg_46_0:recycleAlarmItem(arg_46_1, arg_46_2)
	end
end

function var_0_0.onResultQuit(arg_47_0)
	arg_47_0:closeThis()
end

function var_0_0.handleResetByResult(arg_48_0)
	if arg_48_0._sceneAnim then
		arg_48_0._sceneAnim:Play("open", 0, 0)
	end
end

function var_0_0.playEnterAnim(arg_49_0)
	if arg_49_0._sceneAnim then
		arg_49_0._sceneAnim:Play(UIAnimationName.Open, 0, 0)
	end
end

function var_0_0._guideClickTile(arg_50_0, arg_50_1)
	local var_50_0 = string.splitToNumber(arg_50_1, "_")
	local var_50_1 = var_50_0[1]
	local var_50_2 = var_50_0[2]

	arg_50_0:onClickChessPos(var_50_1, var_50_2)
end

function var_0_0.onClickContainer(arg_51_0)
	if Va3ChessGameController.instance:isNeedBlock() then
		return
	end

	local var_51_0 = recthelper.screenPosToAnchorPos(GamepadController.instance:getMousePosition(), arg_51_0._tfTouch)
	local var_51_1, var_51_2 = Va3ChessGameController.instance:getNearestScenePos(var_51_0.x, var_51_0.y)

	if var_51_1 then
		local var_51_3 = Va3ChessMapUtils.calPosIndex(var_51_1, var_51_2)

		logNormal("click Scene tileX, tileY : " .. tostring(var_51_1) .. ", " .. tostring(var_51_2) .. " index: " .. var_51_3)
		arg_51_0:onClickChessPos(var_51_1, var_51_2)
	end
end

function var_0_0.onClickChessPos(arg_52_0, arg_52_1, arg_52_2)
	local var_52_0 = Va3ChessGameController.instance.event

	if var_52_0 and var_52_0:getCurEvent() then
		local var_52_1 = var_52_0:getCurEvent()

		if var_52_1 then
			var_52_1:onClickPos(arg_52_1, arg_52_2, true)
		end
	end
end

function var_0_0.getBaseTile(arg_53_0, arg_53_1, arg_53_2)
	return arg_53_0._baseTiles[arg_53_1 + 1][arg_53_2 + 1]
end

return var_0_0
